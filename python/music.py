#!/usr/bin/env python

'''
Provides a simple interface for iTunes.
Uses Javascript and the `osascript` tool. Requires OS X 10.10 or higher

Provides two classes:
    Parser -- parses strings
    Play -- plays a parsed string (Parser)
    
The module also provides a few convenience functions:
    play() -- plays the music
    printTrack() -- prints the current track in JSON
    pause() -- pauses the music
    stop() -- stops the music
    playPause() -- plays the music if it's paused or pauses it if it's playing
    backtrack() -- go back or go to the beginning of the track
    nextTrack() -- go forward to the next track
    rewind()
    fastForward()
    resume() -- stop rewind and fastForward
    increaseVolume() -- increases the volume by 1 percent
    decreaseVolume() -- decreases the volume by 1 percent
    printVolume() -- prints the volume
    printState() -- prints the state
'''

import sys;
import copy;
import subprocess;
import fileinput;

class Parser:
    '''
    Parses a simple language for interacting with iTunes.
    
    The output is an array of ``Operation``s
    '''
    
    class Operation:
        '''
        An Operation consists of number of times, name, and params.
        
        ```self.numTimes``` is the number of times this operation should be exeucted
        ```self.name``` is it's name
        ```self.params``` is an array of strings representing the parameters of the operation
        
        An operation, in text format, looks like this: <num times><name>(<param1>, <param2>, ...)
        '''
        def __init__(self):
            self.numTimes = 1;
            self.name = "";
            self.params = [];
        def __str__(self):
            st = str(self.numTimes);
            st += self.name;
            st += "("
            for param in self.params:
                st += param + ", ";
            if len(self.params) > 0:
                st = st[:-2];
            st += ")";
            return st;
        def __repr__(self):
            return self.__str__();
    
    class UnableToParse(Exception):
        '''
        An exception thrown when the Parser is unable to parse a line
        '''
        def __init__(self, source, reason):
            self.source = source;
            self.reason = reason;
        def why(self):
            return ("Unable to parse \"%s\": %s" % (self.source, self.reason));
        
    def __init__(self, rawInput):
        '''
        Parses rawInput. Throws UnableToParse if it can't.
        
        Input should look like this:
            ```operation : operation : ...```
        Where ``operation`` consists of:
            ```<num times><name>(<param1>, <param2>, ...)```
        '''
        
        self.operations = [];
        self.numTimes = "";
        self.name = "";
        self.param = "";
        self.params = [];
        
        def nextStateFn (state, c):
            if state == 0:
                if c == ':':
                    return 0;
                elif ord(c) >= ord('0') and ord(c) <= ord('9'):
                    self.numTimes += c;
                    return 1;
                else:
                    self.name += c;
                    return 2;
            elif state == 1:
                if ord(c) >= ord('0') and ord(c) <= ord('9'):
                    self.numTimes += c;
                    return 1;
                else:
                    self.name += c;
                    return 2;
            elif state == 2:
                if ord(c) >= ord('0') and ord(c) <= ord('9'):
                    self.op = Parser.Operation();
                    self.op.numTimes = int(self.numTimes) if len(self.numTimes) > 0 else 1;
                    self.op.name = self.name;
                    self.name = "";
                    self.numTimes = "";
                    self.operations.append(copy.copy(self.op));
                    self.numTimes += c;
                    return 1;
                elif c == ':':
                    self.op = Parser.Operation();
                    self.op.numTimes = int(self.numTimes) if len(self.numTimes) > 0 else 1;
                    self.op.name = self.name;
                    self.name = "";
                    self.numTimes = "";
                    self.operations.append(copy.copy(self.op));
                    return 0;
                elif c == '(':
                    return 3;
                else:
                    self.name += c;
                    return state;
            elif state == 3:
                if c == ',':
                    if (len(self.param) > 0):
                        self.params.append(self.param);
                    self.param = "";
                    return 4;
                elif c == ')':
                    if (len(self.param) > 0):
                        self.params.append(self.param);
                    self.param = "";
                    return 5;
                else:
                    self.param += c;
                    return state;
            elif state == 4:
                if c != ',':
                    self.param += c;
                    return 3;
                else:
                    return -1;
            elif state == 5:
                self.op = Parser.Operation();
                self.op.numTimes = int(self.numTimes) if len(self.numTimes) > 0 else 1;
                self.op.name = self.name;
                self.op.params = self.params;
                self.numTimes = "";
                self.name = "";
                self.params = [];
                self.param = "";
                self.operations.append(copy.copy(self.op));
                if ord(c) >= ord('0') and ord(c) <= ord('9'):
                    return 1;
                else:
                    return 2;
         
        nextState = 0;
        for c in rawInput:
            nextState = nextStateFn(nextState, c);
            if nextState == -1:
                raise UnableToParse(c, "unable to parse");
        if nextState == 0 or nextState == 2 or nextState == 5:
            self.op = Parser.Operation();
            self.op.numTimes = int(self.numTimes) if len(self.numTimes) > 0 else 1;
            self.op.name = self.name;
            self.op.params = self.params;
            self.operations.append(copy.copy(self.op));
        
        
        
class Play:
    '''
    Plays a set of operation produced by a parser.
    '''
    def __init__(self, parser):
        self.p = parser;
        self.script = r'''
app = Application("iTunes");
currApp = Application.currentApplication();
currApp.includeStandardAdditions = true;

function getJSON(item){
    json = "{\n";
    for (prop in item){
        value = item[prop];
        json += "\t\"" + prop + "\":";
        if (typeof value == "string"){
            json += "\"" + value.replace(/\"/g, '\\\"') + "\",\n";
        } else if (typeof value == "object"){
            json += "\"" + value + "\",\n";
            //json += stringify(value) + ",\n";
        } else {
            json += value + ",\n";
        }
    }
    json = json.substring(0, json.length - 2);
    json += "\n}\n"
    return json;
}

function inArr(item, arr){
    for (var i = 0; i < arr.length; i++){
        if (item == arr[i]){
            return true;
        }
    }
    return false;
}

function getItems(item, props){
    var obj = {};
    for (prop in item){
        if (inArr(prop, props)){
            obj[prop] = item[prop];
        }
    }
    return obj;
}
'''
        
    def __call__(self):
        '''
        Runs an array of operations found in Parser.
        
        Operations supported are:
            `compile` -- print the script instead of executing it
            `|>` or `play` -- play the music
            `|>?` or `play?` -- print the current song in JSON. If params are provided, only print the attributes listed in params
            `||` or `pause` -- pause the music
            `s' or `stop` -- stop the music
            `|` or `playpause` -- play the music if it's paused and pause it if it's played
            `<` or `backtrack` -- go back or go to the beginning of the track
            `<p` or `previoustrack` -- go back to the previous track
            `>` or `nexttrack` -- go forward to the next track
            `<<` or `rewind` -- rewind for one second
            `>>` or `fastforward` -- fast forward for one second
            `<<!` or `rewind!` -- rewind forever
            `>>!' or `fastforward!` -- fast forward forever
            `resume` -- resume from a fast forward or rewind
            `+` or `increasevolume` -- increase the volume. If a parameter is given, it sets the volume to it
            `-` or `decreasevolume` -- decrease the volume. If a parameter is given, it sets the volume to it
            `+?` or `-?` -- print the volume
            `state?` -- print the state of the player. 'playing', 'paused', 'stopped', 'fast forwarding', or 'rewinding'.
        '''
        script = self.script;
        compile = False
        for op in self.p.operations:
            if op.name == "compile":
                compile = True;
            elif op.name == "|>" or op.name == "play":
                for i in range(0, op.numTimes):
                    script += "app.play();\n";
            elif op.name == "|>?" or op.name == "play?":
                # Filter out by params
                for i in range(0, op.numTimes):
                    if len(op.params) > 0:
                        script += "props = [";
                        for param in op.params:
                            script += '"' + param.strip() + '", ';
                        script = script[:-2];
                        script += "];\n";
                        script += "console.log(getJSON(getItems(app.currentTrack().properties(), props)));\n"
                    else:
                        script += "console.log(getJSON(app.currentTrack().properties()));\n";
                    
            elif op.name == "||" or op.name == "pause":
                for i in range(0, op.numTimes):
                    script += "app.pause();\n"
            elif op.name == "s" or op.name == "stop":
                for i in range(0, op.numTimes):
                    script += "app.stop();\n";
            elif op.name == "|" or op.name == "playpause":
                for i in range(0, op.numTimes):
                    script += "app.playpause();\n";
            elif op.name == "<" or op.name == "backtrack":
                for i in range(0, op.numTimes):
                    script += "app.backTrack();\n";
            elif op.name == "<p" or op.name == "previoustrack":
                for i in range(0, op.numTimes):
                    script += "app.previousTrack();\n";
            elif op.name == ">" or op.name == "nexttrack":
                for i in range(0, op.numTimes):
                    script += "app.nextTrack();\n";
            elif op.name == "<<" or op.name == "rewind":
                script += "app.rewind();\n";
                script += "currApp.doShellScript('sleep " + str(op.numTimes) + "');\napp.resume();\n";
            elif op.name == ">>" or op.name == "fastforward":
                script += "app.fastForward();\n";
                script += "currApp.doShellScript('sleep " + str(op.numTimes) + "');\napp.resume();\n";
            elif op.name == "<<!" or op.name == "rewind!":
                script += "app.rewind();\n";
            elif op.name == ">>!" or op.name == "fastforward!":
                script += "app.fastForward();\n"
            elif op.name == "resume":
                script += "app.resume();\n";
            elif op.name == "+" or op.name == "increasevolume" or op.name == "setvolume":
                if len(op.params) == 1:
                    try:
                        vol = int(op.params[0]);
                        script += "currApp.setVolume(" + str((float(vol) / 100.0)*7) + ");\n";
                    except:
                        pass
                else:
                    script += "vol = (currApp.getVolumeSettings().outputVolume/100)*7;\n";
                    script += "currApp.setVolume(vol + " + str(float(op.numTimes) * 0.1) + ");\n";
            elif op.name == "-" or op.name == "decreasevolume":
                if len(op.params) == 1:
                    try:
                        vol = int(op.params[0]);
                        script += "currApp.setVolume(" + str((float(vol) / 100.0)*7) + ");\n";
                    except:
                        pass
                else:
                    script += "vol = (currApp.getVolumeSettings().outputVolume/100)*7;\n";
                    script += "currApp.setVolume(vol - " + str(float(op.numTimes) * 0.1) + ");\n";
            elif op.name == "+?" or op.name == "-?":
                for i in range(0, op.numTimes):
                    script += "console.log(currApp.getVolumeSettings().outputVolume);\n";
            elif op.name == 'state?':
                for i in range(0, op.numTimes):
                    script += "console.log(app.playerState());\n";
            else:
                return;
                
            
        #script = script.replace(" ", "");
        #script = script.replace("\n", ";");
        if compile:
            print(script);
        else:
            p = subprocess.Popen(['osascript', '-l', 'JavaScript'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE);
            stdout, stderr = p.communicate(script);
            if len(stdout.strip()) > 0 or len(stderr.strip()):
                print(stderr.strip());

def run(str):
    p = Play(Parser(str))();
    
# Some convenient functions
def play():
    run("play");
def printTrack():
    run("play?");
def pause():
    run("pause");
def stop():
    run("stop");
def playPause():
    run("playpause");
def previousTrack():
    run("previoustrack");
def backtrack():
    run("backtrack");
def nextTrack():
    run("nexttrack");
def rewind():
    run("rewind!");
def fastForward():
    run("fastforward!");
def resume():
    run("resume");
def increaseVolume():
    run("+");
def decreaseVolume():
    run("-");
def printVolume():
    run("+?");
def printState():
    run("state?");
 
if __name__ == "__main__":
    if len(sys.argv) == 1:
        run("|");
    elif len(sys.argv) >= 2 and sys.argv[1] == "-i":
        # Run interactive mode
        while True:
            try:
                line = raw_input();
                run(line);
            except EOFError:
                sys.exit(0);
            except KeyboardInterrupt:
                print
                pass;
    # Cat all the args in a string (in a smart way)
    commands = "";
    openParen = False;
    for arg in sys.argv[1:]:
        commands += " " if openParen else ":";
        commands += arg;
        numOpen = arg.count('(');
        numClosed = arg.count(')');
        if numClosed > numOpen:
            openParen = False;
        elif numOpen < numClosed:
            openParen = True;
    # remove whitespace (also in an inteligent way)
    numOpen = 0;
    i = 0;
    length = len(commands);
    while i < length:
        if commands[i] == '(':
            numOpen+=1;
        elif commands[i] == ')':
            numOpen-=1;
        elif commands[i] == ' ' and numOpen == 0:
            # remove it
            commands1 = commands[:i];
            commands2 = commands[i+1:];
            commands = commands1 + commands2;
            i-=1;
            length-=1;
        i+=1;
    run(commands);

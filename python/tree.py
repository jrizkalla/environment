#!/usr/bin/env python3

import os;
import copy;

class ParseSettings:
    def __init__(self):
        self.ignoreHiddenFiles = False;
        self.blacklist = ['.DS_Store']; # ignore these files
        self.detectType = True;
        self.maxLevel = 99999999; # basically infinity
        
    def filter_func(self, file):
        ''' Checks if a file is hidden and checks if it is in the blacklist'''
        
        if len(file) == 0:
            raise ValueError('File must be at least one char long');
        
        if self.ignoreHiddenFiles and file[0] == '.':
            return False;
        
        try:
            index = self.blacklist.index(file);
        except ValueError:
            pass
        else:
            return False;
        
        return True;
    
    

class File(object):
    ''' The baseclass for a node in FileTree
 
    Attributes:
        -- name: the name of the file
        -- parent: the parent of this file. A file with
                   None as its parent is the root
        -- type: the type of the file. An empty string represents an unknown type
    '''
    
    def __init__(self, name, parent = None):
        self.name = name;
        self.parent = parent;
        self.type = ''
 
    def __str__(self):
        return self.name + ' [' + self.type + ']';
        
class Dir(File):
    ''' A directory that can have multiple children
    
    Attributes:
        -- children: an array of children (of type File)
        Note: it is recommended to avoid using children directly
    '''
    
    def __init__(self, name, parent = None):
        File.__init__(self, name, parent);
        self.children = [];
        self.type = 'directory';
        self.subtype = 'plaindir';
        
    def append_child(self, file):
        ''' Appends file (of type File) to this Dir.'''
        
        if not isinstance(file, File):
            raise TypeError('Only Files can be appended to the children of Dir');
        
        self.children.append(file);
        file.parent = self;
        
    def delete_child(self, file):
        ''' Deletes file from this Dir.
        File can be:
            - A File object
            - A string
        '''
        
        if isinstance(file, File):
            self.children.remove(file);
            file.parent = None;
        elif type(file) is str:
            # Look for the file 'manually'
            for i in range(len(self.children)):
                if self.children[i].name == file:
                    self.children[i].parent = None;
                    del self.children[i];
                    break;
            else:
                raise ValueError('Unable to find child')
        else:
            raise ValueError('paramter not file or string');
            
    def delete_all_children(self):
        ''' Deletes all children'''
        for ch in self.children:
            ch.parent = None;
        self.children = [];


class FileTree:
    ''' An actual file tree (from actual files).
    
    The root is a File (or a subclasses of File)
    '''
    
    def __init__(self, directory='', settings = ParseSettings()):
        ''' Creates a FileTree from the directory in directory (if it exists)
        
        If directory is empty, it uses the current working directory
        '''
        self.settings = settings;
        
        if len(directory) == 0:
            directory = os.getcwd();
            
        directory = os.path.abspath(directory);
        if not os.path.exists(directory):
            raise ValueError('directory passed to FileTree.__init__ is not a real directory');
        
        # is the root a directory:
        self.root = None;
        if os.path.isdir(directory):
            self.root = Dir(directory);
            for dir in os.listdir(directory):
                self._discover_tree(dir, self.root, 1);
         
        
    def _discover_tree(self, dir, parent, level):
        if level > self.settings.maxLevel:
            return;
        
        if not self.settings.filter_func(dir):
            return;
        
        fullPath = self.path_from_root(parent) + '/' + dir;
        if os.path.isdir(fullPath):
            file = Dir(dir);
            parent.append_child(file);
            
            try:
                for f in os.listdir(fullPath):
                    self._discover_tree(f, file, level+1);
            except OSError:
                # Permission denied. That's ok
                pass
        else:
            name, ext = os.path.splitext(dir);
            file = File(name + ext);
            if self.settings.detectType:
                file.type = ext[1:]; # remove the . in the extention
            parent.append_child(file);
            
             
    def path_from_root(self, file):
        path = [file.name];
        # Append them in reverse for more efficiency
        file = file.parent;
        while (file != None):
            path.append(file.name);
            file = file.parent;
            
        pathstr = path[-1];
        i = len(path) - 2;
        while (i >= 0):
            pathstr += '/' + path[i];
            i -= 1;
        return pathstr;

    def _create_str(self, file, level):
        res = (level * 4) * ' ' + str(file) + '\n';
        if file.type == 'directory':
            for child in file.children:
                res += self._create_str(child, level+1);
                
        return res;
            
    def __str__(self):
        return self._create_str(self.root, 0);
    
    
    def _filter(self, node, accept_file):
        if accept_file(node):
            if node.type == 'directory':
                children = copy.copy(node.children);
                for child in children:
                    self._filter(child, accept_file);
        else:
            # Completely remove the node (and all of its children) from the tree
            if node.parent:
                node.parent.delete_child(node);
            else:
                root = None;
                
    def _prune_branch(self, node):
        ''' Prunes node (but does not remove node itself).
        Returns true if there was a file in node and false otherwise'''
        
        # Go to the end. And while walking up, remove unwanted
        # branches
        if node.type == 'directory':
            files = False;
            i = 0;
            while(i < len(node.children)):
                if not self._prune_branch(node.children[i]):
                    node.delete_child(node.children[i]);
                    i-=1;
                else:
                    files = True;
                i+=1;
            return files;       
        else:
            return True;
        
    def prune(self):
        ''' Removes all branches that don't have files at the end.
        '''
        # Keep the root anyway
        self._prune_branch(self.root);
        
    
    def filter(self, accept_file, cut_empty_branches=False):
        ''' Filters the tree based on accept_file (func).
        
        Arguments:
            -- accept_file is a function that takes in a File as a paramter
                and returns a boolean
            -- cut_empty_branches: if it is true all brances that don't end in files
                are cut off. Otherwise they are kept as they are
        '''
        self._filter(self.root, accept_file);
        if cut_empty_branches:
            self.prune();
            
            
    def _expand(self, file, expand_file):
        newFile, newFiles = expand_file(file);
        if len(newFiles) > 0 and (not isinstance(newFile, Dir) or newFile.type != 'directory'):
            raise ValueError('The file returned by expand_file must be a directory if there are new files');
        if file.type == 'directory' and (newFile.type != 'directory' or not isinstance(newFile, Dir)):
            raise ValueError('expand_file cannot change a directory to a regular file');
        
        # newFile could be the same as file...
        if (newFile == file):
            if len(newFiles) > 0:
                for f in newFiles:
                    file.append_child(f);
            if file.type == 'directory':
                for c in file.children:
                    self._expand(c, expand_file);
            return;
            
        
        parent = file.parent;
        newFile.parent = parent;
        if file.type == 'directory':
            # Remove all files from file and add them to newFile
            children = file.children;
            file.delete_all_children();
            for ch in children:
                newFile.append_child(ch);
                
        # add the new file
        for ch in newFiles:
            newFile.append_child(ch);
                
        # Replace file with newFile (in parent)
        i = parent.children.index(file);
        parent.children[i] = newFile;
        file.parent = None;
        file.name = 'ERROR';
        return;
        
        # Recurse on all children
        if newFile.type == 'directory':
            for ch in newFile.children:
                self._expand(ch, expand_file);
            
        
    def expand(self, expand_file):
        ''' Expands the tree by processing files
        
        Arguments:
            -- expand_file is a function that takes a File as input and returns
                a new Dir (or subchild) and a list of files that are added to it (return
                only the new file. Not the files that were already children of file)
        Note: all directories must have type == 'directory'. Directory subtypes are
            placed in Dir.dirtype
        '''
        
        # Root cannot be expanded:
        if self.root.type == 'directory':
            for f in self.root.children:
                self._expand(f, expand_file);
                
                
    def _apply(self, node, level, apply_func):
       apply_func(level, node);
        
       if node.type == 'directory':
           for ch in node.children:
               self._apply(ch, level+1, apply_func);
         
    def apply(self, apply_func):
        ''' Applies a function on all nodes
        
        Arguments:
           -- apply_func (level, file) -> None
               A function that takes the level and the file and edits file
               level starts at 0 (for the root)
        '''
        
        self._apply(self.root, 0, apply_func)
        
    
    
    
 
# Shell script part:


if __name__ == '__main__': # Run as a script (not imported)
    # Parse the command line arguments and run the tree
    import sys;
    def print_help(retcode=0, extend=False):
        print('Usage: ' + sys.argv[0] + ' -[cpflht] -help')
        if extend:
            sys.stderr.write('''
    Arguments:
        -help           print this help message
        -c              don't use colors
        -p              print the full path of the files, not just their names
        -f <format>     change the prefix string to format
        -l <num>        set the max number of levels to descend
        -h              look at hidden files
        -t              print the type of file
        -d <dir>        start at <dir> not the cwd
''');
        sys.exit(retcode);
        
    class PrintSettings:
        pass
    
    set = ParseSettings();
    set.detectType = False;
    set.ignoreHiddenFiles = True;
    pset = PrintSettings();
    pset.color = True;
    pset.fullPath = False;
    pset.prefix = 4 * ' ';
    
    startDir = '';
        
    # Parse the arguments
    i = 1;
    while (i < len(sys.argv)):
        arg = sys.argv[i].lower();
        if (arg == '-help' or arg == '--help' or arg == 'help'):
            print_help(extend=True);
        elif (arg == '-c'):
            pset.color = False;
        elif (arg == '-p'):
            pset.fullPath = True;
        elif (arg == '-h'):
            set.ignoreHiddenFiles = False;
        elif (arg == '-t'):
            set.detectType = True;
        elif (arg == '-f' or arg == '-l' or arg == '-d'):
            if ((i+1) == len(sys.argv)):
                print_help(2);
            param = sys.argv[i+1];
            i += 1;
            
            if (arg == '-f'):
                pset.prefix = param;
            elif (arg == '-l'):
                try:
                    param = int(param);
                except ValueError:
                    sys.stderr.write('Error: unable to parse -l <num>');
                    print_help(3);
                set.maxLevel = param;
            elif (arg == '-d'):
                startDir = param;
        else:
            print_help(1);
            
        i += 1;
            
            
     # Create the tree and print it
    try:
        tree = FileTree(startDir, settings=set);
    except ValueError:
        sys.stderr.write('Error: not a directory');
        print_help(4);
    else:
        def _print_node(file, level):
            res = '';
            if pset.fullPath:
                res += tree.path_from_root(file);
            else:
                res += file.name;
            if set.detectType:
                res += ' [' + file.type + ']';
                
            if file.type == 'directory':
                if pset.color:
                    # make directories blue on a white background
                    res = level * pset.prefix + '\033[34;m' + res + '\033[0;m'
                else:
                    res = level * pset.prefix + res;
                print(res);
                for child in file.children:
                    _print_node(child, level + 1);
            else:
                res = level * pset.prefix + res;
                print(res);
                 
        _print_node(tree.root, 0);
                
                
     
else:
    pass # Do nothing

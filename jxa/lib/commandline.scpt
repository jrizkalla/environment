ObjC.import('Foundation')
ObjC.import('stdlib');


/* BOILER PLATE CODE TO BOOTSTRAP A COMMANDLINE JS APPLICATION */
var args = $.NSProcessInfo.processInfo.arguments;

var argv = [];
for (var i = 0; i < args.count; i++) {
    argv.push(ObjC.unwrap(args.objectAtIndex(i)));
}
delete args;

// Filter out the first 3 args (osascript, -l, and JavaScript)
argv = argv.splice(3)
function run(main) {
    $.exit(main(argv));
}

function print() {
    console.log.apply(this, arguments);
}

/* END OF BOILER PLATE CODE */



//function main(argv) {
//    //console.log(argv);
//    print('Argc: ' + argv.length);
//    //console.log('Argc: ' + argv.length);
//    for (var i = 0; i < argv.length; i++){ 
//        print('\targv[' + i + ']: ' + argv[i]);
//    }
//    
//    for (var thing in console) {
//        print('console.' + thing);
//    }
//    return 0;
//}

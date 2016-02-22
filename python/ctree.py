'''
    CTree
    Defines a few more types for C and C header files
    and filters out unneeded files.
    
    Also reads functions in a C files using ctags
'''

import tree;
import subprocess;
import sys;
import latex;

class CFunc(tree.File):
    def __init__(self, name, parent = None, code = '', line = -1):
        tree.File.__init__(self, name, parent);
        self.type = 'C function';
        self.code = code;
        self.line = line;
        
    def __str__(self):
        return str(self.line) + ' ' + self.name + ': ' + self.code;

class CFile(tree.Dir):
    def __init__(self, name, parent = None):
        tree.Dir.__init__(self, name, parent);
        self.subtype = 'c';
        
    def read_functions(self, full_path):
        ''' Reads the functions from the file at full_path
        
        Uses ctags to read full_path. Returns a list of all
        functions
        
        Arguments:
            -- full_path: the full path of this C file
        '''
        
        output = subprocess.check_output('ctags -x "' + full_path + '"', shell=True);
        
        # Output looks like this:
        # <name> <line_num> <file> <code>
        result = [];
        for line in iter(output.splitlines()):
            linelst = line.split();
            cfunc = CFunc(linelst[0], code = ' '.join(linelst[3:]), line = linelst[1]);
            result.append(cfunc);
        return result;
            
    def __str__(self):
        return self.name + ' [' + self.subtype + ']';
    
def _filter_func(file):
    return file.type == 'directory' or file.type == 'c' or file.type == 'h';
    
def _make_expand_func(t):
    def _expand_func(file):
        if file.type == 'c':
            cfile = CFile(name=file.name);
            return (cfile, cfile.read_functions(t.path_from_root(file)));
        else:
            return (file, []);
    return _expand_func;
        
    
def shape_tree(t):
    ''' Filters and expands t and then returns it.
    
    t is a FileTree
    
    Filters out all non-c (.c, .h, and directories) files
    then expands all .c files using ctags
    '''
    
    t.filter(_filter_func, True);
    t.expand(_make_expand_func(t));
    return t;


# And as a bonus :)...

def print_node_dirtree(file, level, header, out):
    ''' Prints a node to out
    Used with print_latex to print a tree.
    This function formats the output for the dirtree package
    '''
    
    if level == -1:
        # Print the header
        out.write('\definecolor{c-func-color}{rgb}{.3, .3, .3}\n\dirtree{%\n');
        return;
    elif level == -2:
        out.write('}\n')
        return;
    
    if not header:
        return;
    
    level += 1;
 
    if file.type == 'directory':
        out.write('.' + str(level) + ' {' + latex.sanitize(file.name) + '}.\n');
        if isinstance(file, CFile):
            pass # C file
        else:
            pass # Normal directory
    else:
        if isinstance(file, CFunc):
            # C function
            out.write('.' + str(level) + ' {\\color{c-func-color}' + latex.sanitize(file.code) + '}.\n');
        else:
            # Normal (probably header) file
            out.write('.' + str(level) + ' {' + latex.sanitize(file.name) + '}.\n');
            
            

def _print_latex(node, level, out, node_printer):
    node_printer(node, level, True, out);
    if node.type == 'directory':
        for c in node.children:
            _print_latex(c, level+1, out, node_printer);
    node_printer(node, level, False, out);
    
def print_latex(t, out=sys.stdout, node_printer=print_node_dirtree):
    ''' Prints the C Tree in LaTeX.
    
    Arguments:
        -- t the tree to print
        -- out the file to print to (stdout by default)
        -- node_printer(file, level, out) -> None: a function used to print each node.
            By default, this is set to print_node_dirtree.
            If level is -1, node_printer must print the header.
            If level is -2, node_printer must print the footer.
    '''
    
    node_printer(None, -1, None, out)
    _print_latex(t.root, 0, out, node_printer);
    node_printer(None, -2, None, out)

#!/usr/bin/env python
import tree;
import os;
from shutil import rmtree;

def _print_html(file, html, level=0, path=""):
    indent = "    " * level;
    
    html += indent + '<div class="%s" type="%s" level="%d">' % (file.type, ('directory' if isinstance(file, tree.Dir) else 'file'), level);
    html += '<div class="name"><a href="' + path + "/" + file.name + '">';
    html += file.name + '</a></div>\n';
    
    if isinstance(file, tree.Dir):
        html += indent + '<div class="dir-contents">\n';
        for child in file.children:
            html = _print_html(child, html, level+1, path + '/' + file.name);
        html += indent + '</dir>\n';
        
    html += indent + '</div>\n';
    return html;
            
            
def create_html(file):
    html = '''<html>
<head>
    <title>Directory</title>
</head>
<body>
'''

    file.root.name = file.root.name[file.root.name.rfind("/")+1:];
    html += '<a href=".">%s</a>\n' % file.root.name;
    for child in file.root.children:
        html = _print_html(child, html, 0, path=".");
    html += '</body>\n</html>';
    return html;

# Create the .html_fs_tree
directory_path = ".html_fs_tree";
try:
    directory = os.mkdir(directory_path);
except OSError:
    sys.stderr.write(directory_path + " already exsits. Do you want to override it (y/n)? ");
    line = sys.stdin.readline();
    if line.lower() == "yes" || line.lower() == "y":
        # Delete .html_fs_tree and everything in it
        rmtree(directory_path);
    else:
        sys.exit(1);
        


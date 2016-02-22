#!/usr/bin/env python

def mult_table(height, width):
    '''Produces a multiplication table.
    
    The result is a list of rows with width items.'''
    
    res = [];
    for row in range(height):
        res.append([]);
        for col in range(width):
            res[row].append((row+1) * (col+1));
    return res;

def format_table(table):
    '''Creates a string with a nicely formated multiplication table'''
    
    # Get the max number and count the number of digits in it
    max_digits = len(str(table[-1][-1])) + 1;
    
    res = ''.ljust(max_digits) + ' | ';
    # Print the header
    for i in range(len(table[0])):
        res += str(i+1).ljust(max_digits) + ' ';
    res += '\n';
    
    res += max_digits * '-' + '-+-' + (len(table[0]) * (max_digits +1)) * '-' + '\n';
 
    # Print the table
    for row in range(len(table)):
        res += str(row+1).rjust(max_digits) + ' | ';
        for num in table[row]:
            res += str(num).ljust(max_digits) + ' ';
        res += '\n';
        
    return res;

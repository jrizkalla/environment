''' Provides a few functions for outputing LaTeX. '''



LATEX_CHARS =       ['\\', '&', '%', '$', '#', '_', '{', '}', '~', '^'];
LATEX_CHARS_REP =   [r'\textbackslash{}', r'\&', r'\%', r'\$', r'\#', r'\_', r'\{', r'\}', r'\textasciitilde{}', r'\textasciicircum{}'];

def sanitize(s):
    ''' Sanitizes a string for LaTeX (non math mode)
    
    Arguments:
        -- s any string
    Returns a copy of s sanitized for LaTeX (outside math mode)
    '''
    
    lst = [];
    for c in s:
        for i in range(len(LATEX_CHARS)):
            if c == LATEX_CHARS[i]:
                lst.append(LATEX_CHARS_REP[i]);
                break;
        else:
            # Not a special char at all
            lst.append(c);
            
    return ''.join(lst);

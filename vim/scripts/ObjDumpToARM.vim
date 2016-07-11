silent! v/\v[0-9a-f]+:\s+[0-9a-f]+\s+/norm! I;
silent! %s/\v^\s*([0-9a-f]+:\s+[0-9a-f]+\s+)/\/*\1*\//g
silent! set ft=armasm

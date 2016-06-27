import json;

def _obj_to_schema(obj):
    if type(obj) is dict:
        copy = {};
        for k,v in obj.items():
            v = _obj_to_schema(v);
            copy[k] = Schema(v) if type(v) is dict else v;
        return copy;
    elif type(obj) is list:
        copy = [];
        for e in obj:
            e = _obj_to_schema(e);
            copy.append(Schema(e) if type(e) is dict else e);
        return copy;
    else:
        return obj;

class Schema(dict):
    def __init__(self, data, **kargs):
        '''
        Creates a Schema from a file or a dictionary.
        Parameters:
        data  -- either a filename (string) or a dict
        kargs -- arguments passed to `json.load` or `json.loads`
        '''
        if type(data) is str:
            with open(data, 'r') as f:
                d = json.load(f, **kargs);
        else:
            d = data;
        # Convert d into a Schema (recursively)
        d = _obj_to_schema(d);
        super().__init__(d);
        
    def dump(self, f, **kargs):
        json.dump(self, f, **kargs);
    def dumps(self, f, **kargs):
        json.dumps(self, f, **kargs);
        
    def __getattr__(self, attr):
        try:
            return super().__getitem__(attr);
        except KeyError as e:
            raise AttributeError from e;
    
    def __setattr__(self, attr, value):
        try:
            return super().__setitem__(attr, value);
        except KeyError as e:
            raise AttributeError from e;
        
    def __delattr__(self, attr):
        return super().__delitem__(attr);

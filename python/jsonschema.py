import json;
from collections import UserDict
from collections.abc import Mapping

from typing import Any

class JSObject(UserDict):
    '''
    Implements a Javascript Object (for the lack of a better term).
    JSObjects are essentially dictionaries that allow getting, setting, and deleting keys using the 
    dot syntax.
    '''
    
    @classmethod
    def load(Class, *args, **kwargs):
        '''
        Load a JSObject from a JSON file.
        *args and **kwargs are passed directly to json.load.
        '''
        kwargs['object_hook'] = lambda d: Class(d)
        return json.load(*args, **kwargs)
    
    @classmethod
    def loads(Class, *args, **kwargs):
        '''
        Load a JSObject from a JSON string.
        *args and **kwargs are passed directly to json.loads.
        '''
        kwargs['object_hook'] = lambda d: Class(d)
        return json.loads(*args, **kwargs)
        
    def __init__(self, data={}):
        '''
        Create a new JSObject from a dictionary.
        '''
        
        data = dict(data)
        for k in data:
            value = data[k]
            if isinstance(value, Mapping) and type(value) != self.__class__:
                value = JSObject(value)
                
            data[k] = value
        
        self.__dict__['data'] = {}
        super().__init__(data)
        
    def dump(self, f, **kargs) -> None:
        json.dump(self, f, **kargs);
    def dumps(self, f, **kargs) -> str:
        return json.dumps(self, f, **kargs);
        
    def __getattr__(self, attr: str) -> Any:
        try:
            return self[attr];
        except KeyError as e:
            raise AttributeError from e;
    
    def __setattr__(self, attr: str, value: Any):
        if attr in self.__dict__:
            self.__dict__[attr] = value
        else:
            self[attr] = value
        
    def __delattr__(self, attr: str):
        if attr in self.__dict__:
            del self.__dict__[attr]
        else:
            del self.data[attr]
        
    def __repr__(self) -> str:
        return '{self.__class__.name}({repr})'.format(self=self, repr=super().__repr__())
    
    def __str__(self) -> str:
        return '{self.__class__.name}({str})'.format(self=self, str=super().__str__())

#!/usr/bin/env python3
import unittest;
import json;
import os.path as path;
import os;
import copy;
from jsonschema import Schema;

class SchemaTestCase(unittest.TestCase):
    def setUp(self):
        # Create a fairly complex JSON object (and output it in a file)
        self.json_data = {
                'key1' : 123,
                'key2' : 324.343,
                'key3' : 'string',
                'key4' : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                'key5' : ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'],
                'key6' : {
                    'key6_1' : 123,
                    'key6_2' : 324.343,
                    'key6_3' : 'string',
                    'key6_4' : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                    'key6_5' : ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'],
                    },
                'key7' : [{
                        'key7_1' : 0,
                    }, {
                        'key7_2' : 0,
                        }],
                'invalid-py-key1' : 0,
                '342'             : 0,
                'invalid key 2'   : 0,
                };
        # Look for a working filename
        for i in range(1000):
            self.filename = 'testjsonschema-testfile-%d.json' % i;
            if not path.isfile(self.filename):
                break;
        else:
            self.filename = '';
            raise Exception('Unable to find empty filename!');
        # Actually write the information to the file
        with open(self.filename, 'w') as f:
            json.dump(self.json_data, f, indent = 4);
            
    def tearDown(self):
        # Delete the file
        os.remove(self.filename);
        
    def check_schema(self, s):
        self.assertEqual(s, s, 'schema not equal to itself');
        self.assertEqual(s, copy.deepcopy(s), "schema not equal to it's copy");
        
        # Assert that all the keys are in there
        default_keys = {'key1':0, 'key2':0, 'key3':0, 'key4':0, 'key5':0, 'key6':0, 'key7':0, 'invalid-py-key1':0, '342':0, 'invalid key 2':0};
        keys = {};
        for k,v in s.items():
            keys[k] = 0;
        self.assertEqual(keys, default_keys, 'Missing or extra keys');
        
        for k in default_keys:
            self.assertTrue(k in s, str(k) + "should be in s but it isn't");
        
        self.assertTrue(type(s.key6) is Schema, 's.key6 is not a Schema');
        self.assertTrue(type(s['key6']) is Schema, 's["key6"] is not a Schema');
        self.assertTrue(type(s['key7'][0]) is Schema, 's["key7"][0] is not a Schema');
        
        self.assertEqual(s.key1, s['key1']);
        self.assertEqual(s.key2, s['key2']);
        self.assertEqual(s.key3, s['key3']);
        self.assertEqual(s.key4, s['key4']);
        self.assertEqual(s.key5, s['key5']);
        self.assertEqual(s.key6, s['key6']);
        self.assertEqual(s.key7, s['key7']);
        
        
    def test_create_from_dict(self):
        s = Schema(self.json_data);
        self.check_schema(s);
    def test_create_from_file(self):
        s = Schema(self.filename);
        self.check_schema(s);
    def test_writing_out(self):
        with open(self.filename, 'w+') as f:
            f.seek(0, 0);
            json.dump(self.json_data, f);
        self.assertEqual(self.json_data, Schema(self.filename));
        
suite = unittest.TestLoader().loadTestsFromTestCase(SchemaTestCase);
if __name__ == '__main__':
    unittest.TextTestRunner(verbosity=2).run(suite);

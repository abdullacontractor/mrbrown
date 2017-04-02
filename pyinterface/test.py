# test.py
from py2clp import Py2CLP

p = Py2CLP()

p.add_template("person", ["name", "age"])
p.assert_simple_fact("dog")
p.assert_simple_fact("cat")
p.add_fact("person", {"name": "John", "age": 23})

p.generate_CLP_output()

# Py2CLP Interface

The module provides an interface between Python Code and the CLIPS shell environment:

**Methods**

 * multislot

> Wrap a string in this function to treat it as a multislot element.

 * add_template

> Adds a new template to system to assert future facts.<br />
input format: name: string, slot_def: list of variables<br />
variable is a string if single slot, else for multislot, wrap string in multislot function call.<br />
e.g. add_template("person", [multislot("name"), "age", "job"]).

 * add_fact
> Adds a new fact based on defined template
  name is a string and slot_vals is a mapping of variables to values (dict)

* assert_simple_fact
> Lets your assert simple singular facts.
 * generate_CLP_output
> Call this to generate a .txt file to be used in CLIPS.<br />
 Run generated commands in CLIPS with (batch output.txt).

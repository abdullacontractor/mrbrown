# py2clp.py
# The module provides an interface between Python Code and the CLIPS shell environment

class Py2CLP(object):

    def __init__(self):
        self.text = "" #initialize text collector
        self.templates = {} # collect templates

    @staticmethod
    def multislot(txt):
        return ("multislot", txt)

    # Adds a new template to system to assert future facts
    # input format: name: string, slot_def: list of variables
    # variable is a string if single slot, else for multislot, wrap string in multislot function call
    # add_template("person", [multislot("name"), "age", "job"])

    def add_template(self, name, slot_def):
        temp_txt = "(deftemplate %s " % name

        for slot in slot_def:
            if isinstance(slot, basestring):
                temp_txt += "(slot %s)" % slot
            else:
                temp_txt += "(multislot %s)" % slot[1] #multislot
        temp_txt += ")" # close

        self.add_as_newline(temp_txt)

    # Adds a new fact based on defined template
    # name is a string and slot_vals is a mapping of variables to values (dict)
    def add_fact(self, name, slot_vals):
        txt = "(assert (%s" % name
        for var, value in slot_vals.iteritems():
            txt += "(%s %s)" % (var, value)
        txt += "))"
        self.add_as_newline(txt)

    def assert_simple_fact(self, fact):
        self.add_as_newline("(assert (%s))" % fact)

    #adds as a new line
    def add_as_newline(self, txt):
        self.text += txt + "\n"

    def generate_CLP_output(self):
        output_file = open("output.txt", "w")
        output_file.write(self.text)

# Mr.Brown Test
# Looper

#### Imports ####
import sys
import nltk
import clips

#### Global Variables ####
MESSAGE_WELCOME = "\nHi there, I'm Mr.Brown. What sentence do you need help with today? [type \"exit\" to quit]\n"
MESSAGE_EXIT = "\ngood bye!\n"
MESSAGE_ERROR = "Sorry you seem to have entered a single word. Would you like to try again?"
MESSAGE_REPEAT = "You have mentioned this before!"
PROMPT = ">>>"

############################### Functions ######################################
def define_init_rules():
    clips.Load("rules.clp")
    clips.Reset()

def process_user_input(s):
    text = nltk.word_tokenize(s)

    if len(text) == 1:
        print MESSAGE_ERROR
        return

    tags = nltk.pos_tag(text)
    add_tags_as_facts(tags) # add sentence as facts

def execute():
    add_wrong_rules()
    clips.Run()

def add_bigram_as_fact(t1, t2):
    command = "(assert (bigram (tags %s-%s) (words \"%s %s\")))" % (t1[1], t2[1], t1[0], t2[0])
    clips.SendCommand(command) # print command

def add_tags_as_facts(tags):
    add_bigram_as_fact(tags[0], tags[1]) # implicit base case

    if len(tags) > 2:
        add_tags_as_facts(tags[1:]) # recursively move down the list

def add_wrong_rules():
    #reads in from wrong-rule.txt
    file = open("wrong-rule.txt", "r")
    header = file.readline().split()
    ngram, no_of_root_rules = int(header[0]), int(header[1])

    for i in xrange(no_of_root_rules):
        header = file.readline().split()
        root, no_of_subrules = header[0], int(header[1])
        for j in xrange(no_of_subrules):
            grammar_rule = file.readline()
            command = "(assert (wrong-bigram-rule (root %s)(wrong-rule %s)))" % (root, grammar_rule)
            clips.SendCommand(command)

    file.close()

############################### I/O Functions ######################################

def pyprintout(*args):
    for arg in args[1]:
        if arg.cltypename().upper() == "SYMBOL":
            if arg.upper() == "CRLF":
                print
            elif arg.upper() == "TAB":
                print "\t",

            else:
                print arg,

        else:
            print arg,

def pyreadline(*args):
    return raw_input()

def pyread(*args):
    return raw_input()

def define_IO_Routines():
    clips.RegisterPythonFunction(pyprintout)
    clips.RegisterPythonFunction(pyreadline)
    clips.RegisterPythonFunction(pyread)
    clips.Load("IO.clp")

############################### Engine Functions ######################################
def init_engine():
    define_IO_Routines()
    define_init_rules()

def run_brown():
    print MESSAGE_WELCOME
    init_engine()

    while(True):
        print PROMPT,
        user_input = raw_input()

        #Exit Check
        if user_input.lower() == "exit":
            print MESSAGE_EXIT
            break

        response_to_user = process_user_input(user_input)
        print "\nyou said %s\n" % user_input
        execute()
        reset() # for eval cycle to reset

    sys.exit(0)

def reset():
    clips.Clear()
    init_engine()

#### Main Program ####
run_brown()

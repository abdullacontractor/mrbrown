# Mr.Brown Test
# Looper

#### Imports ####
import sys
import nltk
import clips
from feedback import Feedback

#### Global Variables ####
MESSAGE_WELCOME = "\nHi there, I'm Mr.Brown. What sentence do you need help with today? [type \"exit\" to quit]\n"
MESSAGE_EXIT = "\ngood bye!\n"
MESSAGE_ERROR = "Sorry you seem to have entered a single word. Would you like to try again?"
MESSAGE_REPEAT = "You have mentioned this before!"
PROMPT = ">>>"
ERRORS = [] #Tracks errors

############################### Helper Functions ######################################
def define_init_rules():
    clips.Load("rules.clp")
    clips.Reset()

def process_user_input(s):
    text = nltk.word_tokenize(s)

    if len(text) == 1:
        print MESSAGE_ERROR
        return False

    tags = nltk.pos_tag(text)
    add_tags_as_facts(tags) # add sentence as facts
    if text[-1] == '?':
        return True
    else:
        return False

def execute():
    add_wrong_rules()
    clips.Run()

def add_bigram_as_fact(t1, t2):
    command = "(assert (bigram (tags %s %s) (words \"%s\" \"%s\")))" % (t1[1], t2[1], t1[0], t2[0])
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
            root, leaf = file.readline().split("-")
            leaf = leaf.rstrip()
            command = "(assert (wrong-bigram-rule (root %s)(wrong-rule %s %s)))" % (root, root, leaf) #flag for scaling
            clips.SendCommand(command)

    file.close()

############################### Feedback System ######################################
def feedback_to_user(errors, is_question):
    overall_feedback = ""
    for i, (word1, tag1, word2, tag2) in enumerate(errors):
        overall_feedback += "%d) " % (int(i) + 1)
        overall_feedback += Feedback.feedback(word1, tag1, word2, tag2, is_question)
        overall_feedback += "\n\n"

    return overall_feedback

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

def capture_error(*args):
    global ERRORS
    word1, tag1, word2, tag2 = args[1]
    ERRORS.append((str(word1), str(tag1), str(word2), str(tag2)))

def pyreadline(*args):
    return raw_input()

def pyread(*args):
    return raw_input()

def define_IO_Routines():
    clips.RegisterPythonFunction(pyprintout)
    clips.RegisterPythonFunction(pyreadline)
    clips.RegisterPythonFunction(pyread)
    clips.RegisterPythonFunction(capture_error)
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

        is_question = process_user_input(user_input)
        print
        execute()
        print feedback_to_user(ERRORS, is_question)
        reset() # for eval cycle to reset

    sys.exit(0)

def reset():
    clips.Clear()
    init_engine()
    global ERRORS
    ERRORS = []

#### Main Program ####
run_brown()

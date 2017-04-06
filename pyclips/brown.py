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
TEMPLATES = {}

#### Functions ####
def process_user_input(s):
    text = nltk.word_tokenize(s)

    if len(text) == 1:
        print MESSAGE_ERROR
        return

    tags = nltk.pos_tag(text)
    add_tags_as_facts(tags)
    clips.PrintFacts()

def define_templates():
    clips.Reset()
    TEMPLATES["tags"] = clips.BuildTemplate("tags", "(slot pair)")
    TEMPLATES["words"] = clips.BuildTemplate("words", "(slot word-pair)")
    TEMPLATES["bigram"] = clips.BuildTemplate("bigram", "(slot tags) (slot words)")

def add_bigram_as_fact(t1, t2):
    bigram_fact = clips.Fact(TEMPLATES["bigram"])
    bigram_fact.Slots["words"] = "%s %s" % (t1[0], t2[0])
    bigram_fact.Slots["tags"] = "%s-%s" % (t1[1], t2[1])
    # if bigram_fact.Exists:
    #     print MESSAGE_REPEAT
    # else:
    bigram_fact.Assert()

def add_tags_as_facts(tags):
    add_bigram_as_fact(tags[0], tags[1]) # implicit base case

    if len(tags) > 2:
        add_tags_as_facts(tags[1:]) # recursively move down the list

def run_brown():
    print MESSAGE_WELCOME
    define_templates()

    while(True):
        print PROMPT,
        user_input = raw_input()

        #Exit Check
        if user_input.lower() == "exit":
            print MESSAGE_EXIT
            break

        response_to_user = process_user_input(user_input)
        print "\nyou said %s\n" % user_input

    sys.exit(0)

#### Main Program ####
run_brown()

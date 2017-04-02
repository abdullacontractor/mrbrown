# interface.py
# User-facing Python Interface. Takes in user input and processes for CLIPS to perform inference.
import nltk
from py2clp import Py2CLP

def define_templates():
    py2clp.add_template("tag", ["type"])
    py2clp.add_template("word", ["type"])
    py2clp.add_template("pos", ["tag", "word"])

def take_new_sentence(s):
    text = nltk.word_tokenize(s);
    add_sentence_as_facts(nltk.pos_tag(text))

def add_sentence_as_facts(s):
    for word_pair in s:
        word, tag = word_pair
        py2clp.add_fact("pos", {"tag": tag, "word": word})
    py2clp.generate_CLP_output()

#Test Run
py2clp = Py2CLP()
define_templates()
s2 = "The dog is big."
take_new_sentence(s2)

# s = "We are going to the park."
# s3 = "The dog runs."
# print take_new_sentence(s)
# print take_new_sentence(s2)
# print take_new_sentence(s3)

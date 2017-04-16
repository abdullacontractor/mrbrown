# Feedback Module
# This module provides relevant feedback for the rules violated in the Mr.Brown

import nltk
from bs4 import BeautifulSoup
import urllib2
import json

pos_mapping = {
    "CC": "Coordinating conjunction",
    "CD": "Cardinal number",
    "DT": "Determiner",
    "EX": "Existential there",
    "FW": "Foreign word",
    "IN": "Preposition or subordinating conjunction",
    "JJ": "Adjective",
    "JJR": "Adjective, comparative",
    "JJS": "Adjective, superlative",
    "LS": "List item marker",
    "MD": "Modal",
    "NN": "Noun, singular or mass",
    "NNS": "Noun, plural",
    "NNP": "Proper noun, singular",
    "NNPS": "Proper noun, plural",
    "PDT": "Predeterminer",
    "POS": "Possessive ending",
    "PRP": "Personal pronoun",
    "PRP$": "Possessive pronoun",
    "RB": "Adverb",
    "RBR": "Adverb, comparative",
    "RBS": "Adverb, superlative",
    "RP": "Particle",
    "SYM": "Symbol",
    "TO": "to",
    "UH": "Interjection",
    "VB": "Verb, base form",
    "VBD": "Verb, past tense",
    "VBG": "Verb, gerund or present participle",
    "VBN": "Verb, past participle",
    "VBP": "Verb, non-3rd person singular present",
    "VBZ": "Verb, 3rd person singular present",
    "WDT": "Wh-determiner",
    "WP": "Wh-pronoun",
    "WP$": "Possessive wh-pronoun",
    "WRB": "Wh-adverb",
}

noun_statements = ["NN-JJS", "NN-RBS", "NNS-JJS", "NNS-JJ", "NNS-RBS", "NNS-RBR", "NNS-CD"]
verb_statements = ["VBP-JJS", "VBP-RBS", "VBD-JJS", "VBD-RBS", "VBD-VBZ", "VBD-VBP", "VBG-MD"]
adj_statements = ["JJS-JJS", "JJS-JJR", "JJS-PRP$", "JJR-PRP$", "JJR-JJR", "JJR-JJS", "JJ-WP$", "JJ-PRP$", "JJ-JJS", "JJ-JJR", "JJ-DT"]
adv_statements = ["RB-PRP"]

questions = ["RB-WP", "VBP-WDT", "VBP-WP$", "VBP-WP", "VBD-WP$", "VBD-WP", "VBD-WDT", "VBG-WDT", "VBG-WP$", "JJS-WP$", "JJS-WDT", "JJR-WP$", "JJR-WDT", "JJ-WDT", "RB-MD", "VBD-WRB", "RB-WP$", "RB-WDT"]

class Feedback(object):

    @staticmethod
    def generate_message_bank():
        output = {}
        rule_txt = open("rule-list.txt", "r")
        for rule in rule_txt:
            root_leaf = rule.rstrip().split("-")
            print root_leaf
            output[rule.rstrip()] = {
                "root": pos_mapping[root_leaf[0]],
                "leaf": pos_mapping[root_leaf[1]],
                "error_msg": ""
            }

        with open('msg_bank.json', 'w') as fp:
            json.dump(output, fp)

    @staticmethod
    def extract_pos_defn():
        url = "https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html"
        content = urllib2.urlopen(url).read()
        soup = BeautifulSoup(content, "html.parser")
        for link in soup.find_all('tr'):
            print map(lambda x: x.text, link.find_all('td')[1:])
            print

    @staticmethod
    def feedback(word1, tag1, word2, tag2, is_question):
        # return Feedback.generate_message(error, TAGS[root], TAGS[leaf], False)
        error = "%s-%s" % (tag1, tag2)
        feedback = Feedback.generate_message(error, word1, word2, is_question)
        feedback += "\n[%s -> %s Error]" % (pos_mapping[tag1], pos_mapping[tag2])
        return feedback

    @staticmethod
    def generate_message(error, root, leaf, is_question):

        if error in noun_statements or error in verb_statements or error in adj_statements or error in adv_statements or error == "RB-PDT":
            return "'%s' cannot be followed by '%s'" % (root, leaf)
        #Special Cases
        elif error == "NN-JJ":
            return "If the word '%s' is being used to describe the noun '%s' then the correct form might be '%s %s'. On the other hand, if the word '%s' is being used to describe an action on the object, then the sentence is correct." % (leaf, root, root, leaf, root)
        elif error == "NN-RBR":
            return "If the phrase '%s something' is being used to describe the noun '%s' then the correct form might be '%s something %s'. On the other hand, if the word '%s' is being used to describe an action on the object, then the sentence is correct." % (leaf, root, leaf, root, leaf)
        elif error == "NN-PRP$" or error == "NNS-PRP$":
            return "A noun can be followed by a possessive pronoun like '%s', you may have meant '%s is %s' or '%s %s'" % (leaf, root, leaf, leaf, root)
        elif error == "NN-CD":
            return "If you are using a number as a count for the noun, then the correct form might be '%s %s', if not the sentence is correct." % (leaf, root)
        elif is_question:
            if error == "VBP-MD":
                return "A modal like '%s' cannot immediately follow the verb that it is modifying, you might have meant '%s %s'" % (leaf, leaf, root)
            elif error == "VBD-MD":
                return "A modal like '%s' isn't commonly used with a verb in past tense like '%s'" % (leaf, root)
            elif error in questions:
                return "The phrase '%s %s' is pretty uncommon for a question, try starting with '%s' for a more direct structure" % (root, leaf, leaf)
        else:
            return "Error"

        # if error == "NN-JJS":
        # elif error == "NN-JJ":
        # elif error == "NN-RBS":
        # elif error == "NN-RBR":
        #     pass
        # elif error == "NN-PRP$":
        #     pass
        # elif error == "NN-CD":
        #     pass
        # elif error == "NNS-JJS":
        #     pass
        # elif error == "NNS-JJ":
        #     pass
        # elif error == "NNS-RBS":
        #     pass
        # elif error == "NNS-RBR":
        #     pass
        # elif error == "NNS-PRP$":
        #     pass
        # elif error == "NNS-CD":
        #     pass
        # elif error == "VBP-JJS":
        #     pass
        # elif error == "VBP-MD":
        #     pass
        # elif error == "VBP-WDT":
        #     pass
        # elif error == "VBP-WP$":
        #     pass
        # elif error == "VBP-RBS":
        #     pass
        # elif error == "VBP-WP":
        #     pass
        # elif error == "VBD-WP$":
        #     pass
        # elif error == "VBD-WP":
        #     pass
        # elif error == "VBD-JJS":
        #     pass
        # elif error == "VBD-RBS":
        #     pass
        # elif error == "VBD-VBZ":
        #     pass
        # elif error == "VBD-VBP":
        #     pass
        # elif error == "VBD-WDT":
        #     pass
        # elif error == "VBD-WRB":
        #     pass
        # elif error == "VBD-MD":
        #     pass
        # elif error == "VBG-WDT":
        #     pass
        # elif error == "WBG-WP$":
        #     pass
        # elif error == "VBG-MD":
        #     pass
        # elif error == "RB-WP$":
        #     pass
        # elif error == "RB-PDT":
        #     pass
        # elif error == "RB-WP":
        #     pass
        # elif error == "RB-WDT":
        #     pass
        # elif error == "RB-PRP$":
        #     pass
        # elif error == "RB-MD":
        #     pass
        # elif error == "JJS-JJS":
        #     pass
        # elif error == "JJS-JJR":
        #     pass
        # elif error == "JJS-WP$":
        #     pass
        # elif error == "JJS-PRP$":
        #     pass
        # elif error == "JJS-WDT":
        #     pass
        # elif error == "JJR-WP$":
        #     pass
        # elif error == "JJR-WDT":
        #     pass
        # elif error == "JJR-PRP$":
        #     pass
        # elif error == "JJR-JJR":
        #     pass
        # elif error == "JJR-JJS":
        #     pass
        # elif error == "JJ-WP$":
        #     pass
        # elif error == "JJ-WDT":
        #     pass
        # elif error == "JJ-PRP$":
        #     pass
        # elif error == "JJ-JJS":
        #     pass
        # elif error == "JJ-JJR":
        #     pass
        # elif error == "JJ-DT":
        #     pass
        # else:
        #     return ""

# extract_pos_defn()
# generate_message_bank()

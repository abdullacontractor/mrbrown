# Feedback Module
# This module provides relevant feedback for the rules violated in the Mr.Brown

import nltk
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
            return "If the word '%s' is being used to describe the noun '%s' then the correct form might be '%s %s'. On the other hand, if the word '%s' is being used to describe an action on the object, then the sentence is correct." % (leaf, root, leaf, root, root)
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

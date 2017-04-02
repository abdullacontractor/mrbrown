# PyClips Test
import clips
templates = {}

def define_templates():
    clips.Reset()
    templates["tags"] = clips.BuildTemplate("tags", "(slot pair)")
    templates["words"] = clips.BuildTemplate("words", "(slot pair)")
    templates["bigram"] = clips.BuildTemplate("bigram", "(slot tags) (slot words)")

def add_initial_facts():
    bigram_fact = clips.Fact(templates["bigram"])
    bigram_fact.Slots["tags"] = "NN-VB"
    bigram_fact.Slots["words"] = "The day".upper()
    bigram_fact.Assert()

define_templates()
add_initial_facts()
clips.PrintFacts()

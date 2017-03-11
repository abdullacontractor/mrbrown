import nltk
from collections import Counter
import operator
import itertools
import penn_treebank_tags

import codecs
import os

OUTPUT_FILE = 'rule_inference.txt'

f = open("nyt_top_stories.txt")
lines = f.read().split('\n')
sentence = ""
for line in lines:
    sentence += line.decode('utf-8').strip()
f.close()

# sentence = """Hi, my name is Abdulla Contractor. Do you want to play football tomorrow? Hi, my name is Abdulla Contractor"""

tokens = nltk.word_tokenize(sentence)
tagged = nltk.pos_tag(tokens)
tags = [""]*len(tagged)
for i in range(len(tagged)):
    word, tag = tagged[i]
    tags[i] = tag
tag_count = Counter(tags)

bgs = nltk.bigrams(tags)
#compute frequency distribution for all the bigrams in the text
fdist = nltk.FreqDist(bgs)
for big in list(itertools.product(tag_count.keys(), tag_count.keys())):
    if big not in fdist:
        fdist[big] = 0

perc_dist = {k:((v*1.0)/tag_count[k[0]]) for k,v in fdist.items()}
sorted_dist = sorted(perc_dist.items(), key=operator.itemgetter(1))

if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)
output = codecs.open(OUTPUT_FILE, 'a', 'utf-8')

for k,prob in sorted_dist:
    t1, t2 = k
    output.write(
        unicode("%.2f"%(prob) + '\t' +\
            penn_treebank_tags.getReadableTag(t1) + ' -> ' +\
            penn_treebank_tags.getReadableTag(t2) + "\n",
        'utf-8'))

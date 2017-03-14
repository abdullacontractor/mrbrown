import nltk
from collections import Counter
import operator
import itertools
import penn_treebank_tags

import codecs
import os

OUTPUT_FILE_BGS = 'rule_inference_bgs.txt'
OUTPUT_FILE_TGS = 'rule_inference_tgs.txt'

f = open("nyt_top_stories.txt")
lines = f.read().split('\n')
sentence = ""
for line in lines:
    sentence += line.decode('utf-8').strip()
f.close()

# sentence = """Hi, one two three my name is Abdulla Contractor. Do you want to play football tomorrow? Hi, my name is Abdulla Contractor"""

tokens = nltk.word_tokenize(sentence)
tagged = nltk.pos_tag(tokens)
tags = [""]*len(tagged)
for i in range(len(tagged)):
    word, tag = tagged[i]
    tags[i] = tag
tag_count = Counter(tags)

bgs = nltk.bigrams(tags)
# ugs = nltk.unigrams(tags)
tgs = nltk.trigrams(tags)

#compute frequency distribution for all the bigrams in the text
fdist_bgs = nltk.FreqDist(bgs)
for big in list(itertools.product(tag_count.keys(), tag_count.keys())):
    if big not in fdist_bgs:
        fdist_bgs[big] = 0

#compute frequency distribution for all the trigrams in the text
fdist_tgs = nltk.FreqDist(tgs)
for big in list(itertools.product(tag_count.keys(), tag_count.keys())):
    if big not in fdist_tgs:
        fdist_tgs[big] = 0

perc_dist_bgs = {k:((v*1.0)/tag_count[k[0]]) for k,v in fdist_bgs.items()}
sorted_dist_bgs = sorted(perc_dist_bgs.items(), key=operator.itemgetter(1))

perc_dist_tgs = {k:((v*1.0)/tag_count[k[0]]) for k,v in fdist_tgs.items()}
sorted_dist_tgs = sorted(perc_dist_tgs.items(), key=operator.itemgetter(1))

if os.path.exists(OUTPUT_FILE_BGS):
    os.remove(OUTPUT_FILE_BGS)
output_bgs = codecs.open(OUTPUT_FILE_BGS, 'a', 'utf-8')

if os.path.exists(OUTPUT_FILE_TGS):
    os.remove(OUTPUT_FILE_TGS)
output_tgs = codecs.open(OUTPUT_FILE_TGS, 'a', 'utf-8')

for k,prob in sorted_dist_bgs:
    t1, t2 = k
    output_bgs.write(
        unicode("%.2f"%(prob) + '\t' +\
            penn_treebank_tags.getReadableTag(t1) + ' -> ' +\
            penn_treebank_tags.getReadableTag(t2) + "\n",
        'utf-8'))

for k,prob in sorted_dist_tgs:
    if (len(k) > 2):
        t1, t2, t3 = k
        output_tgs.write(
            unicode("%.2f"%(prob) + '\t' +\
                penn_treebank_tags.getReadableTag(t1) + ' -> ' +\
                penn_treebank_tags.getReadableTag(t2) + ' -> ' +\
                penn_treebank_tags.getReadableTag(t3) + "\n",
            'utf-8'))

import nltk
import sys
import penn_treebank_tags
import custom_model

while True:
    sentence  = input()

    tokens = nltk.word_tokenize(sentence)
    tagged = nltk.pos_tag(tokens)
    tags = [""]*len(tagged)
    for i in range(len(tagged)):
        word, tag = tagged[i]
        if custom_model.isInModel(word):
            tags[i] = custom_model.getCustomTag(word)
        else:
            tags[i] = tag

    print(tags)

    for tag in tags:
        print ("%s -> %s"%(tag, penn_treebank_tags.getReadableTag(tag)))
    print()

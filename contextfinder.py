# for each WORD in the dataset, we get the CONTEXT from the CMU
# Identify word and vowel
# Look at vowel context

import nltk; import codecs; import os; import re
from nltk.corpus import cmudict


def cmureader(filename):
    count=0
    vowels=["AA", "AH", "AW", "EH", "EY", "IH", "OW", "UH", "AE", "AO", "AY", "ER", "IY", "OY", "UW"]
    #getting the dictionary from NLTK
    cmudict=nltk.corpus.cmudict.dict()
    f=codecs.open(filename, "r", "utf-8"); spreadsheet=[]
    for line in f:
        spreadsheet.append(line.rstrip("\r").split(","))
    print len(spreadsheet)
    for entry in spreadsheet:
        #the cmu is lowercase
        word=re.sub("[^a-z]","", entry[5].lower())
        try:
            #if several entries, we just take the first one
            #none of the words has secondary stress
            x=cmudict[word][0]
            primestressvowels=[str(i+"1") for i in vowels]
            nostressvowels=[str(i+"0") for i in vowels]
            y=[i for i in x if i in nostressvowels]
            if len(y) == 0:
                count=count+1
        except:
            print word
    print count
        

cmureader("canada_outliers_817.csv")

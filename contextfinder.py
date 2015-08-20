# for each WORD in the dataset, we get the CONTEXT from the CMU
# Identify word and vowel
# Look at vowel context

import nltk; import codecs; import os; import re; import numpy; from collections import defaultdict
from nltk.corpus import cmudict



def cmureader(filename):
    output=defaultdict(list)
    #this counter just for testing purposes
    count=0
    #getting the dictionary from NLTK
    cmudict=nltk.corpus.cmudict.dict()
    #read in the spreadsheet
    f=codecs.open(filename, "r", "utf-8"); spreadsheet=[]
    for line in f:
        spreadsheet.append(line.rstrip("\r").split(","))
    print len(spreadsheet)
    print spreadsheet[1]
    #process line by line, where each item in the list is a line
    for entry in spreadsheet[1:len(spreadsheet)]:
        #the cmu is lowercase; we need to get rid of all the numbers on the words
        word=re.sub("[^a-z]","", entry[5].lower())
        try:
            #if several entries, we just take the first one
            #none of the words has secondary stress
            transcription=cmudict[word][0]
            #print x
            #find the primestressvowel and the two sounds next to it
            indexi=vowelfinder(transcription)
            context=[transcription[i] for i in indexi if i < len(transcription)]
            #print context
            #y=x[context]
            #print context
        except:
            print transcription
            print word
            print "error"
            break
        output[int(entry[0])]=[entry, transcription, [list(i) for i in context]]
    print len(output)
    print output[2]
    return output
    

#cmudict["bed"]
#[[u'B', u'EH1', u'D']]

def vowelfinder(transcription):
    #these are the vowels in the CMU dictionary
    vowels=["AA", "AH", "AW", "EH", "EY", "IH", "OW", "UH", "AE", "AO", "AY", "ER", "IY", "OY", "UW"]
    #this makes a list of primary stress vowels based on the vowels list above
    primestressvowels=[str(i+"1") for i in vowels]
    for sound in transcription:
        if sound in primestressvowels:
            #print sound
            return [transcription.index(sound)-1, transcription.index(sound)+1]

t=cmureader("canada_outliers_817.csv")

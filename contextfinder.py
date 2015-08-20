# for each WORD in the dataset, we get the CONTEXT from the CMU
# Identify word and vowel
# Look at vowel context

import nltk; import codecs; import os; import re
from nltk.corpus import cmudict


def cmureader(filename):
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
            x=cmudict[word][0]
            #find the primestressvowel and the two sounds next to it
            context=vowelfinder(x)
            print(len(context))
            #print context
        except:
            print "error"
    print count

def vowelfinder(transcription):
    #this makes a list of primary stress vowels based on the vowels list above
    primestressvowels=[str(i+"1") for i in vowels]
    #these are the vowels in the CMU dictionary
    vowels=["AA", "AH", "AW", "EH", "EY", "IH", "OW", "UH", "AE", "AO", "AY", "ER", "IY", "OY", "UW"]
    
    for sound in transcription:
        if sound in primestressvowels:
            return (transcription.index(sound)-1, transcription.index(sound)+1)

cmureader("canada_outliers_817.csv")

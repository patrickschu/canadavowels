from __future__ import division
import codecs
import numpy
from collections import defaultdict
import os



os.chdir("H:")
inputfile=codecs.open("canada_outliers_cmuvowels_gormancategories_929.csv", "r", "utf-8"); spreadsheet=[]
output=codecs.open("canada_cmuvowels_gormancategories_outliers_1110.csv", "a",
                   "utf-8")

#canadavowels=["DRESS","FLEECE","GOOSE","KIT","LOT","PALM","STRUT","THOUGHT","TRAP"]



#making a spreadsheet
#note that we have to rstrip different things (\n, \r). Probably a good way
#way of doing this regex-way, but not today
for line in inputfile:
	#count=count+1
	#print line.rstrip("\r").split(",")
	spreadsheet.append(line.rstrip("\r\n").split(","))

print len(spreadsheet)
inputfile.close()	



#this is the equivalent of R's "levels"
#note that column number needs to be in Python count
def levels(spreadsheet, columnnumber):
	entries=[]
	for row in spreadsheet[1:len(spreadsheet)]:
		entries.append(row[columnnumber])
	print "entries", len(entries)
	levels=list(set(entries))
	print "levels", len(levels)
	return (levels)

#this just makes means and stdevs when you feed it a list of fx measures
def meansanddevs(formantlist):
    mean=numpy.mean(formantlist)
    standarddeviation=numpy.std(formantlist)
    return(mean, standarddeviation)


#this takes speaker etc and compares formant value to the
#means and stdevs listed in the speakerdicti
#it returns a 1 is there is an outlier, 0 if not
#
def outlierfinder(speaker, vowel, f1, f2):
    entry=speakerdict[speaker][vowel]
    f1mean=float(entry[len(entry)-2][0])
    f1stdev=float(entry[len(entry)-2][1])
    f2mean=float(entry[len(entry)-1][0])
    f2stdev=float(entry[len(entry)-1][1])
    f1outlier=0
    f2outlier=0
    #print "mean",f2mean
    #print "stdev",f2stdev    
    if (f1 >= f1mean+(2*f1stdev)) or (f1 <= f1mean-(2*f1stdev)):
        f1outlier=1
        print "\nf1 outlier: ", f1, f1mean
        print f1mean, f1stdev,"-->", f1mean-(2*f1stdev), f1mean+(2*f1stdev)
        
    if (f2 >= f2mean+(2*f2stdev)) or (f2 <= f2mean-(2*f2stdev)):
        f2outlier=1
        print "\nf2 outlier: ", f2, f2mean
        print f2mean, f2stdev,"-->", f2mean-(2*f2stdev), f2mean+(2*f2stdev)
        
    return[f1outlier, f2outlier]




###MAIN
#extracting the data (speakers and vowels) we'll be working with
canadavowels=levels(spreadsheet, 3)

canadaspeakers=levels(spreadsheet, 2)

#we will fill this dicti with each speaker's measurements per vowel
speakerdict=defaultdict()

#we set it up
for speaki in canadaspeakers:
    speakerdict[speaki]={"DRESS":[],
     "FLEECE":[],
     "GOOSE":[],
     "KIT":[],
     "LOT":[],
     "PALM":[],
     "STRUT":[],
     "THOUGHT":[],
     "TRAP":[]}

#7 - 9 in yeder row sind F1 - F3
#speaker is 2 vowel is 3
#no	NO	SPEAKER	VOWEL	CONTEXT	VOWEL2	WORD	F1	F2	F3	LOCATION	TOKEN	AGE	GENDER	ETHNICITY	F1n	F2n	AgeGrp	F1outlier	F2outlier	OUTLIER	PPE	FPE	TRANSCRIPTION	PRE_SOUND	VOWEL_TRANS	FOLL_SOUND
# we iterature thru the spreadsheet, along the way 
# making a dict with each speaker as the entry; each entry in turn consists of
# a dictionary with measurements for each vowel. 
for row in spreadsheet[1:len(spreadsheet)]:
    speakerdict[row[2]][row[3]].append((row[7], row[8], row[9]))

#note that we're ignoring F3 here for now
#from now, the last two entries for each vowel in speakerdict are the F1 and F2 means/stdev tuples
for entry in speakerdict:
    for vowi in speakerdict[entry]:
        f1=[int(i[0]) for i in speakerdict[entry][vowi]]
        f2=[int(i[1]) for i in speakerdict[entry][vowi]]
        f3=[int(i[2]) for i in speakerdict[entry][vowi]]
        f1results=meansanddevs(f1)
        f2results=meansanddevs(f2)
        speakerdict[entry][vowi]=speakerdict[entry][vowi]+[f1results, f2results]


print "assi"
    
#we're done building the dictionary
#now we iterate thru the spreadsheet again and flag suspicious outliers.
#these are defined as "2 or more stdevs from the mean". here per vowel
#we found this in the Paolo handbook, pg 194. 

for row in spreadsheet[1:len(spreadsheet)]:
    result=outlierfinder(row[2], row[3], float(row[7]), float(row[8]))
    row=row+result
    row=[str(i) for i in row]
    output.write(",".join(row)+"\n")
    
output.close()


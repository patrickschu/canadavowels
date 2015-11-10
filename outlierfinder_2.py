import codecs
import numpy
from collections import defaultdict
import os


os.chdir("H:")

#canadavowels=["DRESS","FLEECE","GOOSE","KIT","LOT","PALM","STRUT","THOUGHT","TRAP"]

f=codecs.open("canada_outliers_cmuvowels_gormancategories_929.csv", "r", "utf-8"); spreadsheet=[]

#making a spreadsheet
for line in f:
	#count=count+1
	#print line.rstrip("\r").split(",")
	spreadsheet.append(line.rstrip("\r").split(","))

print len(spreadsheet)
f.close()	



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



canadavowels=levels(spreadsheet, 3)
print canadavowels[0]

canadaspeakers=levels(spreadsheet, 2)
print canadaspeakers[0]

###MAIN

speakerdict=defaultdict()

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

#print speakerdict["CR W70F"]


#7 - 9 in yeder row sind F1 - F3
#speaker is 2 vowel is 3
#no	NO	SPEAKER	VOWEL	CONTEXT	VOWEL2	WORD	F1	F2	F3	LOCATION	TOKEN	AGE	GENDER	ETHNICITY	F1n	F2n	AgeGrp	F1outlier	F2outlier	OUTLIER	PPE	FPE	TRANSCRIPTION	PRE_SOUND	VOWEL_TRANS	FOLL_SOUND
#
#we make a dict with each speaker as the entry; each entry in turn consists of
# a dictionary with entries for each vowel. 
for row in spreadsheet[1:len(spreadsheet)]:
    speakerdict[row[2]][row[3]].append((row[7], row[8], row[9]))

#print speakerdict["CR W70F"]

#note that we're ignoring F3 here for now
#from now, the last two entries for each vowel are the F1 and F2 means/stdev tuples
for entry in speakerdict:
    for vowi in speakerdict[entry]:
        f1=[int(i[0]) for i in speakerdict[entry][vowi]]
        f2=[int(i[1]) for i in speakerdict[entry][vowi]]
        f3=[int(i[2]) for i in speakerdict[entry][vowi]]
        f1results=meansanddevs(f1)
        f2results=meansanddevs(f2)
        speakerdict[entry][vowi]=speakerdict[entry][vowi]+[f1results, f2results]

print len(speakerdict)
    
print speakerdict["CR W70F"]

#we're done building the dictionary
#now we iterate thru the spreadsheet again and flag suspicious outliers.
#these are defined as "2 or more stdevs from the mean". here per vowel
#we found this in the Paolo handbook, pg 194. 

for row in spreadsheet[1:len(spreadsheet)]:
    result=outlierfinder(row[2], row[7], row[8])
    row.append(result)

def outlierfinder(speaker, f1, f2):
    look up f mean and stdev in speaker's speakerdicit entry
    compare to f
    return 1 for outlier, 0 for not outlier

#for the vowel entered we compute the means and stdevs
def meansanddevs(vowel):
	f1list=[]
	f2list=[]
	for entry in spreadsheet:
		if vowel in entry:
			f1=float(entry[13])
			f1list.append(f1)
			#print f1
			f2=float(entry[14])
			f2list.append(f2)
	standarddeviationf1=numpy.std(f1list)
	meanf1=numpy.mean(f1list)
	standarddeviationf2=numpy.std(f2list)
	meanf2=numpy.mean(f2list)
	print vowel
	print "stdev f1n:", standarddeviationf1
	print "stdev f2n", standarddeviationf2
	print "mean f1", meanf1
	print "mean f2", meanf2
	return(meanf1, standarddeviationf1, meanf2, standarddeviationf2)
	print "mean f1", meanf1
	print "mean f2", meanf2
			
#in alarms we collect the findings of the script
alarms=defaultdict(list)
#we take the stdevs and rund them past every freaking measurement in the spreadsheet
def outlierfinder(vowel, (meanf1, standarddeviationf1, meanf2, standarddeviationf2)):
	linecount=1
	for entry in spreadsheet[1:len(spreadsheet)]:
		linecount=linecount+1
		if vowel in entry:
			f1=float(entry[13])
			f2=float(entry[14])
			#print f1
			#print meanf1-(2*standarddeviationf1)
			#print meanf1+(2*standarddeviationf1)
			if f1 < meanf1-(2*standarddeviationf1) or f1 > meanf1+(2*standarddeviationf1):
				res=[1]
			else:
				res=[0]
			if f2 < meanf2-(2*standarddeviationf2) or f2 > meanf2+(2*standarddeviationf2):
				res.append(1)
			else:
				res.append(0)
			alarms[linecount]=[res, entry]
	return alarms
	print linecount



#finding the outliers, making a dict for each line
def outlierkiller(vowellist):
	for vowel in vowellist:
		print len(vowellist)
		#print vowel
		x=meansanddevs(vowel)
		result=outlierfinder(vowel, x)
	return result
	print type(result)
		
#get the complete dict
t=outlierkiller(canadavowels)
sortedt=dict(sorted(t.items()))
f=open("test.txt", "w")
#f.write(str(sortedt))
#writing to file
for item in sortedt:
	#print sortedt[item][0]
	f.write (str(item)+","+",".join(sortedt[item][1])+","+str(sortedt[item][0][0])+","+str(sortedt[item][0][1])+"\n")
f.close()


#output
#9
#DRESS
#stdev f1n: 91.1443769144
#stdev f2n 187.655577575
#mean f1 686.602048236
#mean f2 1857.77180346
#9
#FLEECE
#stdev f1n: 75.3317785215
#stdev f2n 286.943268303
#mean f1 374.580973166
#mean f2 2549.0656136
#9
#GOOSE
#stdev f1n: 53.9687640379
#stdev f2n 351.742661633
#mean f1 394.870866941
#mean f2 1258.10537174
#9
#KIT
#stdev f1n: 62.2142869279
#stdev f2n 192.899846163
#mean f1 539.470561975
#mean f2 2011.21132878
#9
#LOT
#stdev f1n: 76.1041476372
#stdev f2n 121.445061385
#mean f1 748.226802116
#mean f2 1181.38362222
#9
#PALM
#stdev f1n: 77.2429653386
#stdev f2n 207.939387183
#mean f1 723.987301587
#mean f2 1141.81255754
#9
#STRUT
#stdev f1n: 81.9435029835
#stdev f2n 170.745663288
#mean f1 752.398121157
#mean f2 1484.93321519
#9
#THOUGHT
#stdev f1n: 61.6865766666
#stdev f2n 131.540574348
#mean f1 747.981377778
#mean f2 1175.58369333
#9
#TRAP
#stdev f1n: 136.774966471
#stdev f2n 235.655345647
#mean f1 764.98203866
#mean f2 1815.86176598
#logout

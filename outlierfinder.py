#find outliers

import codecs
import numpy

f=codecs.open("canada_817.csv", "r", "utf-8"); spreadsheet=[]

for line in f:
	#count=count+1
	#print line.rstrip("\r").split(",")
	spreadsheet.append(line.rstrip("\r").split(","))
	
print len(spreadsheet)	

#>>> spreadsheet[0][6]
#u'F2'
#>>> spreadsheet[0][5]
#u'F1'
#>>> spreadsheet[0][13]
#u'F1n'
#>>> spreadsheet[0][14]
#u'F2n'

def outlierfinder(vowel):
	f1=[]
	f2=[]
	for entry in spreadsheet:
		if vowel in entry:
			#print entry[14], entry[13]
			f1.append(float(entry[13]))
			#print f1
			f2.append(float(entry[14]))
	standarddeviationf1=numpy.std(f1)
	standarddeviationf2=numpy.std(f2)
	print "stdev f1n:", standarddeviationf1
	print "stdev f2n", standarddeviationf2
			
outlierfinder("DRESS")

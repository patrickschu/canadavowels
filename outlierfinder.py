import codecs
import numpy

f=codecs.open("canada_817.csv", "r", "utf-8"); spreadsheet=[]

for line in f:
	#count=count+1
	#print line.rstrip("\r").split(",")
	spreadsheet.append(line.rstrip("\r").split(","))
	
print len(spreadsheet)
f.close()	

#>>> spreadsheet[0][6]
#u'F2'
#>>> spreadsheet[0][5]
#u'F1'
#>>> spreadsheet[0][13]
#u'F1n'
#>>> spreadsheet[0][14]
#u'F2n'

def meansanddevs(vowel):
	f1list=[]
	f2list=[]
	for entry in spreadsheet:
		if vowel in entry:
			#print entry[14], entry[13]
			f1=float(entry[13])
			f1list.append(f1)
			#print f1
			f2=float(entry[14])
			f2list.append(f2)
	standarddeviationf1=numpy.std(f1list)
	meanf1=numpy.mean(f1list)
	standarddeviationf2=numpy.std(f2list)
	meanf2=numpy.mean(f2list)
	print "stdev f1n:", standarddeviationf1
	print "stdev f2n", standarddeviationf2
	print "mean f1", meanf1
	print "mean f2", meanf2
	return(meanf1, standarddeviationf1, meanf2, standarddeviationf2)
	print "mean f1", meanf1
	print "mean f2", meanf2
			
x=meansanddevs("DRESS")
#print x

#we take the stdevs and rund them past every freaking measurement in the spreadsheet
def outlierfinder(vowel, (meanf1, standarddeviationf1, meanf2, standarddeviationf2)):
	linecount=1
	for entry in spreadsheet[1:len(spreadsheet)]:
		linecount=linecount+1
		alarms=[]
		if vowel in entry:
			f1=float(entry[13])
			f2=float(entry[14])
			#print f1
			#print meanf1-(2*standarddeviationf1)
			#print meanf1+(2*standarddeviationf1)
			if f1 < meanf1-(2*standarddeviationf1) or f1 > meanf1+(2*standarddeviationf1):
				print entry
				alarms.append(("F1 problem", linecount, entry))
			else:
				pass
			if f2 < meanf2-(2*standarddeviationf2) or f2 > meanf2+(2*standarddeviationf2):
				print entry
				alarms.append(("F2 problem", linecount, entry))
				print alarms
			else:
				pass
	return alarms
	print linecount

outlierfinder("DRESS", x)

def outlierkiller(vowel):
	x=meansanddevs(vowel)
	alarms=outlierfinder(vowel, x)
	return alarms
	#print alarms
	
#y=outlierkiller("DRESS")

#print y[0]
	

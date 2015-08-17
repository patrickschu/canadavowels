import codecs
import numpy
from collections import defaultdict

canadavowels=["DRESS","FLEECE","GOOSE","KIT","LOT","PALM","STRUT","THOUGHT","TRAP"]

f=codecs.open("canada_817.csv", "r", "utf-8"); spreadsheet=[]

#making a spreadsheet
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

	


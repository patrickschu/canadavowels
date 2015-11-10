save.image()
setwd("H:/")
library(vowels)

##########


#the vowelplot maker
#this takes a dataset and turns it into something to work with for the
#vowels package
#note that depending on the application, we need F1 or F1_normalized
#note that LOCATION is just a dummy to be replaced by NAs. We just need
#sth to make the vowel-package happy
vowelplotmaker=function(dataset){
vowels=dataset[,c("SPEAKER", "VOWEL", "LOCATION", "F1", "F2", "F3",
"LOCATION", "LOCATION", "LOCATION")]
vowels$LOCATION=NA
vowels$LOCATION.1=NA
vowels$LOCATION.2=NA
vowels$LOCATION.3=NA
return(vowels)


##MAIN
#original=read.csv(file.choose(), header=T)


#removing unpleasant contexts
can=original[!(original$FPE %in% c("nas", "liq")) & !(original$PPE %in% c("liq", "gld")) &
original$OUTLIER == 0,]
can=can[!(can$VOWEL=="TRAP"&can$FOLL_SOUND %in% c("K", "G")),]
#summary(can)
nrow(can)

#let us plot
#put this into the format vowels wants
#a required dataframe of the format: speaker_id, vowel_id, context/N, F1, F2, F3,
#F1_glide, F2_glide, F3_glide. The context/N column and the glide columns can
#be blank.
#criterion="Van"
#can=can[can$LOCATION==criterion,]
#nrow(can)
#canvowels=vowelplotmaker(can)

#means 
#canmeans=compute.means(canvowels)

#plot means
#vowelplot(canmeans, labels="vowels", title=paste("Means for ",criterion, ", N= ",nrow(can), sep=""))

#plot both groups
canada_speakers=vowelplotmaker(can[can$LOCATION=="Van",])
canada_speakers_means=compute.means(canada_speakers)

us_speakers=vowelplotmaker(can[can$LOCATION=="WA",])
us_speakers_means=compute.means(us_speakers)

vowelplot(canada_speakers_means, labels="vowels", 
title="Means for Canadian (dot) vs American (+)", subtitle=paste("respective Ns:",
 nrow(canada_speakers),nrow(us_speakers)))

add.vowelplot(us_speakers_means, shape.choice=3)


#boxplots per vowel and one predictor
plotmachine2=function(vowels, predictor, dataset) 
{
#loop over vowels
for (vow in vowels) { 
#set up file and plot parameters
print (vow); 
print (predictor);
#subset the data to a single vowel
subseti=subset(dataset, VOWEL==vow);
tokens=nrow(subseti)

png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=400);  

#boxplotting
par(mfrow=c(1,2)); boxplot(subseti$F1n~subseti[,predictor], main=paste(vow, "F1, tokens: ", tokens), ylab="F1 (Nearey)"); 
boxplot(subseti$F2n~subseti[,predictor], main=paste(vow, "F2, tokens: ", tokens), ylab="F2 (Nearey)"); 
dev.off()
}}

plotmachine2(vowels, "LOCATION", can)



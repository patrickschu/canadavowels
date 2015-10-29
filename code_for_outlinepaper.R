#This code is used for the first outline. We remove bad contexts and start plotting by location


save.image()
setwd("H:/")
library(vowels)

##########


#the vowelplot maker
#this takes a dataset and turns it into something to work with for the
#vowels package
vowelplotmaker=function(dataset){
vowels=dataset[,c("SPEAKER", "VOWEL", "CONTEXT", "F1n", "F2n", "F3",
"CONTEXT", "CONTEXT", "CONTEXT")]
vowels$CONTEXT=NA
vowels$CONTEXT.1=NA
vowels$CONTEXT.2=NA
vowels$CONTEXT.3=NA
return(vowels)
}


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




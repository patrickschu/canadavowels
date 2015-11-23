save.image()
setwd("H:/")
library(vowels)

##########


#the vowelplot maker
#this takes a dataset and turns it into something to work with for the
#vowels package
#note that depending on the application, we need F1 or F1_normalized, or Labov or Lobanov
#note that LOCATION is just a dummy to be replaced by NAs. We just need
#sth to make the vowel-package happy
vowelplotmaker=function(dataset){
vowels=dataset[,c("SPEAKER", "VOWEL", "LOCATION", "F1labov", "F2labov", "F3",
"LOCATION", "LOCATION", "LOCATION")]
vowels$LOCATION=NA
vowels$LOCATION.1=NA
vowels$LOCATION.2=NA
vowels$LOCATION.3=NA
return(vowels)
}


##MAIN
original=read.csv(file.choose(), header=T)


#removing unpleasant contexts
can=original[!(original$FPE %in% c("nas", "liq")) & !(original$PPE %in% c("liq", "gld")) &
original$OUTLIER == 0,]
can=can[!(can$VOWEL=="TRAP"&can$FOLL_SOUND %in% c("K", "G")),]
summary(can)
nrow(can)

#ggplotting
#just cause it looks colorful

#this one was used to plot means for each population, Americans/Canadians
ggvowels=function(dataset, title, separator)
{
print (colnames(dataset));
seps=levels(dataset[[separator]]);
for (i in seps){ 
print (i);
#we construct a dataset for each separator
subseti=dataset[dataset[,separator]==i,];
print(summary(subseti)); 
#with the tapplys, we calculate the means for every vowel
averagef1=tapply(subseti[["F1labovstandard"]], subseti[["VOWEL"]], mean);
averagef2=tapply(subseti[["F2labovstandard"]], subseti[["VOWEL"]], mean);
#we put the whole shebang in a dataframe
meanies=data.frame(
VOWEL=names(averagef1), F1labovstandard=averagef1, F2labovstandard=averagef2, SEPARATOR=i);
gg=ggplot(data=dataset, aes_string(x="F2labovstandard", y="F1labovstandard"));
gg+
scale_y_reverse()+
scale_x_reverse()+
theme_classic()+
geom_point(data=meanies, aes(x=F2labovstandard, y=F1labovstandard), size=5)+
ggtitle(title);
ggsave(paste(title,"_",separator,"_",i, ".png", sep=""), width=8, height=5);
write.csv(meanies)

}
}
cc=ggvowels(can, "This is all the data", "LOCATION")


####a plot for Americans v Canadians
ggvowels=function(subseti, title, separator)
{
#with the tapplys, we calculate the means for every vowel
averagef1=tapply(subseti[["F1labovstandard"]], subseti[["VOWEL"]], mean);
averagef2=tapply(subseti[["F2labovstandard"]], subseti[["VOWEL"]], mean);
#we put the whole shebang in a dataframe
meanies=data.frame(
VOWEL=names(averagef1), F1labovstandard=averagef1, F2labovstandard=averagef2);
return(meanies)


}
backup=can
spliti=split(can, can$LOCATION)
summary(spliti$Van)
canmeans=ggvowels(spliti$Van, "This is all the data", "LOCATION")
usmeans=ggvowels(spliti$WA, "This is all the data", "LOCATION")










###OLD


#let us plot
#put this into the format vowels wants
#a required dataframe of the format: speaker_id, vowel_id, context/N, F1, F2, F3,
#F1_glide, F2_glide, F3_glide. The context/N column and the glide columns can
#be blank.
criterion="WA"
canadian=can[can$LOCATION==criterion,]
canvowels=vowelplotmaker(canadian)

#means 
canmeans=compute.means(canvowels)

#plot means
#vowelplot(canmeans, labels="vowels", title=paste("Means for ",criterion, ", N= ",nrow(can), sep=""))

#plot both groups
canada_speakers=vowelplotmaker(can[can$LOCATION=="Van",])
canada_speakers_means=compute.means(canada_speakers)

us_speakers=vowelplotmaker(can[can$LOCATION=="WA",])
us_speakers_means=compute.means(us_speakers)

vowelplot(canada_speakers_means, labels="vowels", 
title="Means for Canadian (dot) vs American (+)", subtitle=paste("respective Ns:",
 nrow(canada_speakers),nrow(us_speakers), "Nearey-normalized"))

add.vowelplot(us_speakers_means, shape.choice=3)


#vowel charts per speaker, labov-style
speakers=levels(can$SPEAKER)
miny=c(max(can$F1labov), min(can$F1labov))
minx=c(max(can$F2labov), min(can$F2labov))
trapezmachine= function(dataset){
for (speak in speakers) {
print (speak); subseti=subset(dataset, SPEAKER==speak); 
frame=data.frame(speaker_id=subseti$SPEAKER, 
vowel_id=subseti$VOWEL, "context/N"=NA, F1=subseti$F1labov, F2=subseti$F2labov, F3=subseti$F3, "F1_glide"=NA, "F2_glide"=NA, "F3_glide"=NA); 
png(paste(speak, "_labov_trapezoid.png"), width=550, height=550); 
vowelplot(frame, ylim=miny, xlim=minx, shape="vowels", leg="vowels", a.size=0.7, 
title=paste(speak,": ", subseti$GENDER[1], ", ", subseti$LOCATION[1],", ", subseti$ETHNICITY[1], ", ", subseti$AgeGrp[1], ", labov normalized")); 
add.spread.vowelplot(frame, mean.points=TRUE, sd.mult=0, color="red", size=0.7);
dev.off()
}
}

trapezmachine(can)



#vowel charts per speaker, lobanov-style
speakers=levels(can$SPEAKER)
miny=c(max(can$F1lobanov), min(can$F1lobanov))
minx=c(max(can$F2lobanov), min(can$F2lobanov))
trapezmachine= function(dataset){
for (speak in speakers) {
print (speak); subseti=subset(dataset, SPEAKER==speak); 
frame=data.frame(speaker_id=subseti$SPEAKER, 
vowel_id=subseti$VOWEL, "context/N"=NA, F1=subseti$F1lobanov, F2=subseti$F2lobanov, F3=subseti$F3, "F1_glide"=NA, "F2_glide"=NA, "F3_glide"=NA); 
png(paste(speak, "_lobanov_trapezoid.png"), width=550, height=550); 
vowelplot(frame, ylim=miny, xlim=minx, shape="vowels", leg="vowels", a.size=0.7, 
title=paste(speak,": ", subseti$GENDER[1], ", ", subseti$LOCATION[1],", ", subseti$ETHNICITY[1], ", ", subseti$AgeGrp[1], ", lobanov normalized")); 
add.spread.vowelplot(frame, mean.points=TRUE, sd.mult=0, color="red", size=0.7);
dev.off()
}
}


#vowel charts per speaker, nearey-style
speakers=levels(can$SPEAKER)
miny=c(max(can$F1nearey), min(can$F1nearey))
minx=c(max(can$F2nearey), min(can$F2nearey))
trapezmachine= function(dataset){
for (speak in speakers) {
print (speak); subseti=subset(dataset, SPEAKER==speak); 
frame=data.frame(speaker_id=subseti$SPEAKER, 
vowel_id=subseti$VOWEL, "context/N"=NA, F1=subseti$F1nearey, F2=subseti$F2nearey, F3=subseti$F3, "F1_glide"=NA, "F2_glide"=NA, "F3_glide"=NA); 
png(paste(speak, "_nearey_trapezoid.png"), width=550, height=550); 
vowelplot(frame, ylim=miny, xlim=minx, shape="vowels", leg="vowels", a.size=0.7, 
title=paste(speak,": ", subseti$GENDER[1], ", ", subseti$LOCATION[1],", ", subseti$ETHNICITY[1], ", ", subseti$AgeGrp[1], ", nearey normalized")); 
add.spread.vowelplot(frame, mean.points=TRUE, sd.mult=0, color="red", size=0.7);
dev.off()
}
}


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



##plotting the shift
canada_speakers=can[can$LOCATION=="WA",]
old_speakers=vowelplotmaker(canada_speakers[canada_speakers$AgeGrp=="Older",])
middle_speakers=vowelplotmaker(canada_speakers[canada_speakers$AgeGrp=="Middle",])
young_speakers=vowelplotmaker(canada_speakers[canada_speakers$AgeGrp=="Younger",])
compute.means(canada_speakers)

##plotting by age
oldmeans=compute.means(old_speakers)
middlemeans=compute.means(middle_speakers)
youngmeans=compute.means(young_speakers)

vowelplot(oldmeans, labels="vowels", 
title="Means for older (dot) vs middle (+) \n and younger (diamond) speakers",  subtitle=paste("respective Ns:",
 nrow(old_speakers),nrow(middle_speakers), nrow(young_speakers), "Labov-normalized"))

add.vowelplot(middlemeans, shape.choice=3)

add.vowelplot(youngmeans, shape.choice=5)

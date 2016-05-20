library(vowels)
library(ggplot2)
library(lme4)

setwd("~/Desktop/plots")

ggvowels=function(dataset, title, normalized_F1, normalized_F2, separator)
{
# we turn aorund the levels of AgeGrp so we can read the plot better
dataset[["AgeGrp"]]=factor(dataset[["AgeGrp"]], c("Younger", "Middle", "Older"));

#these are the levels we iterate over
seps=levels(dataset[[separator]]);

#we set up a dataframe to fill with stuff
totalmeanies=data.frame(
VOWEL=character(), 
F1means=numeric(), 
F2means=numeric(), 
SEPARATOR=character(),
F1sd=numeric(),
F2sd=numeric()
);
# a second dataframe with global means for labeling purposes
labelf1=tapply(dataset[[normalized_F1]], dataset[["VOWEL"]], mean);
labelf2=tapply(dataset[[normalized_F2]], dataset[["VOWEL"]], mean);
labelmeans=data.frame(
VOWEL=names(labelf1), F1=labelf1, F2=labelf2)

#we're done with the dataframe and set up the plot
gg=ggplot(data=dataset, aes_string(x="F2", y="F1"));

#we collect means for each group in the dataframe we set up above
for (i in seps){ 
print (i);
#we construct a dataset for each separator
subseti=dataset[dataset[,separator]==i,];
#print(summary(subseti[subseti$VOWEL=="KIT",])); 


#with the tapplys, we calculate the means and sds for every vowel
averagef1=tapply(subseti[[normalized_F1]], subseti[["VOWEL"]], mean);
averagef2=tapply(subseti[[normalized_F2]], subseti[["VOWEL"]], mean);
stdevf1=tapply(subseti[[normalized_F1]], subseti[["VOWEL"]], sd);
stdevf2=tapply(subseti[[normalized_F2]], subseti[["VOWEL"]], sd);
#we put the whole shebang in a dataframe
#print(averagef1);
#print (averagef2);
meanies=data.frame(
VOWEL=names(averagef1), F1means=averagef1, F2means=averagef2, SEPARATOR=i, F1sd=stdevf1, F2sd=stdevf2);
totalmeanies=rbind(meanies, totalmeanies);
}
write.csv(totalmeanies);
##PLOTTING##
gg=ggplot(data=dataset, aes_string(x="F2", y="F1"));
gg+
scale_y_reverse()+
scale_x_reverse()+
coord_cartesian()+
theme_bw()+
#ggtheme
#theme_classic()+
#we try to add points for the mean for each vowel, just for labeling purposes
geom_text(data=labelmeans, aes(x=F2, y=F1, label=VOWEL), size=3)+
#we add actual datapoints
geom_point(data=totalmeanies, aes(x=F2means, y=F1means, colour=SEPARATOR, label=VOWEL, group=VOWEL), size=6)+
#ah! we need a title
ggtitle(paste(title, "\n"));
ggsave(paste(title,"_",separator,"_",i, ".png", sep=""), width=8, height=5);

return(totalmeanies)
}




##Here be code for the NWAV outline


canada = read.csv("~/Downloads/canada_final_1121.csv", header=T)
summary(canada)
original = subset(canada, LOCATION == "Van")
summary(original)
# 4821 tokens

#removing unpleasant contexts
can=original[!(original$FPE %in% c("nas", "liq")) & !(original$PPE %in% c("liq", "gld")) &
original$OUTLIER == 0,]
can=can[!(can$VOWEL=="TRAP"&can$FOLL_SOUND %in% c("K", "G")),]
summary(can)

#2554 tokens left, 55 speakers

colnames(can)
#### TRAP is, contrary to previous assertions, conditioned by age and ethnicity
### OVERALL
cc=ggvowels(can, "The Vancouver Vowel System by age group", "F1labovstandard", "F2labovstandard", "AgeGrp")
#F1 model
var=can[can$VOWEL == "TRAP", ]
linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

#F2  model
var=can[can$VOWEL == "TRAP", ]
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
confint(linreg)
linreg=lm(F2labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

### AGE
var=can[can$VOWEL == "TRAP", ]
linreg=lm(F1labovstandard~AGE, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AGE, data=var)
summary(linreg)
#with groups
linreg=lm(F1labovstandard~AgeGrp, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AgeGrp, data=var)
summary(linreg)

### ETNICITY
var=can[can$VOWEL == "TRAP", ]
linreg=lm(F1labovstandard~ETHNICITY, data=var)
summary(linreg)
linreg=lm(F2labovstandard~ETHNICITY, data=var)
summary(linreg)

### INTERACTING ETH and AGE
var=can[can$VOWEL == "TRAP", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))



# The DRESS vowel is different from what has been described previously. 
# note that this is copy&paste from TRAP
### OVERALL
#F1 model
var=can[can$VOWEL == "DRESS", ]
print ("F1 overview")
summary(var$F1labovstandard)
print ("F2 overview")
summary(var$F2labovstandard)
print ("speaker overview")
summary(var$ETHNICITY)

linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

#F2  model
var=can[can$VOWEL == "DRESS", ]
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
confint(linreg)
linreg=lm(F2labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

### AGE
var=can[can$VOWEL == "DRESS", ]
linreg=lm(F1labovstandard~AGE, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AGE, data=var)
summary(linreg)
#with groups
linreg=lm(F1labovstandard~AgeGrp, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AgeGrp, data=var)
summary(linreg)

### ETNICITY
var=can[can$VOWEL == "DRESS", ]
linreg=lm(F1labovstandard~ETHNICITY, data=var)
summary(linreg)
linreg=lm(F2labovstandard~ETHNICITY, data=var)
summary(linreg)

### INTERACTING ETH and AGE
var=can[can$VOWEL == "DRESS", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))




#H 3 STRUT is, contrary to previous assertions, conditioned by age and ethnicity
# note that this is copy&paste from DRES
### OVERALL
#F1 model
var=can[can$VOWEL == "STRUT", ]
print ("F1 overview")
summary(var$F1labovstandard)
print ("F2 overview")
summary(var$F2labovstandard)
print ("speaker overview")
summary(var$ETHNICITY)

linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

#F2  model
var=can[can$VOWEL == "STRUT", ]
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
confint(linreg)
linreg=lm(F2labovstandard~scale(AGE)+ETHNICITY, data=var)
summary(linreg)

### AGE
var=can[can$VOWEL == "STRUT", ]
linreg=lm(F1labovstandard~AGE, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AGE, data=var)
summary(linreg)
#with groups
linreg=lm(F1labovstandard~AgeGrp, data=var)
summary(linreg)
linreg=lm(F2labovstandard~AgeGrp, data=var)
summary(linreg)

### ETNICITY
var=can[can$VOWEL == "STRUT", ]
linreg=lm(F1labovstandard~ETHNICITY, data=var)
summary(linreg)
linreg=lm(F2labovstandard~ETHNICITY, data=var)
summary(linreg)

### INTERACTING ETH and AGE
var=can[can$VOWEL == "STRUT", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))

###H 4 A closer look at LOT versus THOUGHT shows that the lower vowel back merger ###is not what it seems to be. 

var=can[can$VOWEL == "LOT", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
summary(var$F1labovstandard)
summary(var$F2labovstandard)
write.csv(tapply(var$F1labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
print ("--------")
write.csv(tapply(var$F2labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))

var=can[can$VOWEL == "THOUGHT", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
summary(var$F1labovstandard)
summary(var$F2labovstandard)
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
write.csv(tapply(var$F1labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
print ("--------")
write.csv(tapply(var$F2labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))

var=can[can$VOWEL == "PALM", ]
var[["AgeGrp"]]=factor(var[["AgeGrp"]], c("Younger", "Middle", "Older"))
summary(var$F1labovstandard)
summary(var$F2labovstandard)
linreg=lm(F2labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
linreg=lm(F1labovstandard~AGE+ETHNICITY, data=var)
summary(linreg)
write.csv(tapply(var$F1labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F1labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))
print ("--------")
write.csv(tapply(var$F2labovstandard, var$AgeGrp, mean))
write.csv(tapply(var$F2labovstandard, list(var$ETHNICITY, var$AgeGrp), mean))

### QUARRY

t.test(var[var$AgeGrp=="Middle"&var$ETHNICITY=="Anglo-Irish Canadian",]$F2labovstandard, var[var$AgeGrp=="Older"&var$ETHNICITY=="Anglo-Irish Canadian",]$F2labovstandard)

# STRUT is, is, contrary to previous assertions, conditioned by age and ethnicity
# A closer look at LOT versus THOUGHT shows that the lower vowel back merger is #not what it seems to be. 




save.image()
setwd("H:/")
library(vowels)

can=read.csv("H:/canada_outliers_cmuvowels_gormancategories_929.csv", header=T)


vowelplotmaker=function(dataset){
vowels=dataset[,c("SPEAKER", "VOWEL", "CONTEXT", "F1", "F2", "F3",
"CONTEXT", "CONTEXT", "CONTEXT")]
vowels$CONTEXT=NA
vowels$CONTEXT.1=NA
vowels$CONTEXT.2=NA
vowels$CONTEXT.3=NA
return(vowels)
}

t=vowelplotmaker(can)
summary(t)

#note that Labov is speaker-extrinsic
g=norm.labov(t)
colnames(g)
summary(g[,4])

colnames(can)
can$F1l=g[,4]
can$F2l=g[,5]

summary(can)

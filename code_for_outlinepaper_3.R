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
ggvowels=function(dataset, title)
{
vowels=levels(dataset[["VOWEL"]]);
#with the tapplys, we calculate the means for every vowel
averagef1=tapply(dataset[["F1labovstandard"]], dataset[["VOWEL"]], mean);
averagef2=tapply(dataset[["F2labovstandard"]], dataset[["VOWEL"]], mean);
#we put the whole shebang in a dataframe
meanies=data.frame(
VOWEL=names(averagef1), F1labovstandard=averagef1, F2labovstandard=averagef2);
print (meanies);
gg=ggplot(data=can, aes(x=F2labovstandard, y=F1labovstandard, color=VOWEL));
gg+
scale_y_reverse()+
scale_x_reverse()+
theme_classic()+
geom_point(data=meanies, aes(x=F2labovstandard, y=F1labovstandard), size=5)+
ggtitle(title);
ggsave("ggplot.png", width=8, height=5);
return(meanies)


}
cc=ggvowels(can, "This is all the data")

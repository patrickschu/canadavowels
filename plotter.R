#this plots vowels
vowels=levels(data$VOWEL)


for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_Location", ".png"), width=800, height=1800); par(mfrow=c(4,2)); subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){
print (cont) ;boxplot(fs$F1n~fs$LOCATION, main=paste(vow, "context: ", cont), ylab="F1n"); boxplot(fs$F2n~fs$LOCATION, main=paste(vow, "context: ", cont), ylab="F2n")}
};dev.off()}


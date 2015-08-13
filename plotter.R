#this plots vowels
vowels=levels(data$VOWEL)


for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_Location", ".png"), width=800, height=1800); par(mfrow=c(4,2)); subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){
print (cont) ;boxplot(fs$F1n~fs$LOCATION, main=paste(vow, "context: ", cont), ylab="F1n"); boxplot(fs$F2n~fs$LOCATION, main=paste(vow, "context: ", cont), ylab="F2n")}
};dev.off()}

#this is a mean plotting machine. Input: Collection of vowels and predictor variable as a str. 

plotmachine=function(vowels, predictor) {
for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=1800); par(mfrow=c(4,2)); 
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){pred=fs[,predictor];
print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont), ylab="F2 (Nearey)")}
};dev.off()}}


#this plots age in the right order
agegroupmachine=function(vowels, predictor) {
for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=1800); par(mfrow=c(4,2)); data$AgeGrp=factor(data$AgeGrp, c("Younger", "Middle", "Older")); print (levels(data$AgeGrp));
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){pred=fs[,predictor];
print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont), ylab="F2 (Nearey)")}
};dev.off()}}



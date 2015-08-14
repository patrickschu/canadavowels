
#this one makes big plots per vowel
plotmachine=function(vowels, predictor) {
#loop over vowels
for (vow in vowels) { 
#set up file and plot parameters
print (vow); png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=1800); par(mfrow=c(4,2)); 
#subset the data to a single vowel; set up the contexts
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
#loop over contexts for this vowel
for (cont in contexts) {
#make a subset of the vowel data per context. it's called fs because it has the formants in it
fs=subseti[subseti$CONTEXT==cont,]; 
#some of them will be zero and mess things up. thus:
if (nrow(fs) > 0){
#count Ns
tokens=nrow(fs)
#we set up the independent variable
pred=fs[,predictor];
#boxplotting
print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont, ", tokens: ", tokens), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont, ", tokens: ", tokens), ylab="F2 (Nearey)")}
};dev.off()}}

agegroupmachine=function(vowels, predictor) {
# we need a different loop for AgeGroups cause we need to order it
for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=1800); par(mfrow=c(4,2)); data$AgeGrp=factor(data$AgeGrp, c("Older", "Middle", "Younger")); print (levels(data$AgeGrp));
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){pred=fs[,predictor];
tokens=nrow(fs);
print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont, ", tokens: ", tokens), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont, ", tokens: ", tokens), ylab="F2 (Nearey)")}
};dev.off()}}


#this one hopefully makes a file for each vowel/context
plotmachine2=function(vowels, predictor) {
#loop over vowels
for (vow in vowels) { 
#set up file and plot parameters
print (vow); 
#subset the data to a single vowel; set up the contexts
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
#loop over contexts for this vowel
for (cont in contexts) {
png(filename=paste(as.character(vow),"_", predictor, "_", cont, ".png"), width=800, height=400);  
#make a subset of the vowel data per context. it's called fs because it has the formants in it
fs=subseti[subseti$CONTEXT==cont,]; 
#some of them will be zero and mess things up. thus:
if (nrow(fs) > 0){
#count Ns
tokens=nrow(fs)
#we set up the independent variable
pred=fs[,predictor];
#boxplotting
par(mfrow=c(1,2)); print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont, ", tokens: ", tokens), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont, ", tokens: ", tokens), ylab="F2 (Nearey)") ;dev.off()}
}}}



agegroupmachine2=function(vowels, predictor) {
# same for age groups
for (vow in vowels) { 
print (vow); png(filename=paste(as.character(vow),"_", predictor, ".png"), width=800, height=1800); par(mfrow=c(4,2)); data$AgeGrp=factor(data$AgeGrp, c("Older", "Middle", "Younger")); print (levels(data$AgeGrp));
subseti=subset(data, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
for (cont in contexts) {
png(filename=paste(as.character(vow),"_", predictor, "_", cont, ".png"), width=800, height=400);
fs=subseti[subseti$CONTEXT==cont,]; 
if (nrow(fs) > 0){pred=fs[,predictor];
tokens=nrow(fs);
par(mfrow=c(1,2)); print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, context: ", cont, ", tokens: ", tokens), ylab="F1 (Nearey)"); boxplot(fs$F2n~pred, main=paste(vow, "F2, context: ", cont, ", tokens: ", tokens), ylab="F2 (Nearey)");dev.off()}
}}}

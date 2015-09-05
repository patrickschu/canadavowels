#this is better than the original

#this one hopefully makes a file for each vowel/context
plotmachine2=function(vowels, predictor, dataset) {
#loop over vowels
for (vow in vowels) { 
#set up file and plot parameters
print (vow); 
#subset the data to a single vowel; set up the contexts
subseti=subset(dataset, VOWEL==vow); contexts=levels(subseti$CONTEXT) ; 
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

##THIS IS FOR GORMANS CATEGORIES


#this is better than the original
canada=read.csv(file.choose(), header=T)
canada=subset(canada, canada$OUTLIER==0)
print (summary(canada))
vowels=levels(canada$VOWEL)
setwd('G://miscprojects//canada//plots')

#this one hopefully makes a file for each vowel/context
plotmachine2=function(vowels, predictor, dataset) {
#loop over vowels
for (vow in vowels) { 
#set up file and plot parameters
print (vow); 
#subset the data to a single vowel; set up the contexts
subseti=subset(dataset, VOWEL==vow); contexts=levels(subseti$PPE) ; 
#loop over contexts for this vowel
for (cont in contexts) {
png(filename=paste(as.character(vow),"_", predictor, "_", cont, ".png"), width=800, height=400); 
print("open device") ;
#make a subset of the vowel data per context. it's called fs because it has the formants in it
fs=subseti[subseti$PPE==cont,]; 
#some of them will be zero and mess things up. thus:
if (nrow(fs) > 0){
#count Ns
tokens=nrow(fs)
#we set up the independent variable
pred=fs[,predictor];
#boxplotting
par(mfrow=c(1,2)); print (cont) ;boxplot(fs$F1n~pred, main=paste(vow, "F1, preceding context: ", cont, ", tokens: ", tokens), ylab="F1 (Nearey)"); 
boxplot(fs$F2n~pred, main=paste(vow, "F2, preceding context: ", cont, ", tokens: ", tokens), ylab="F2 (Nearey)");
}
;dev.off();
print("device closed")
}}}

plotmachine2(vowels, "GENDER", canada)

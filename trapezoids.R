trapezmachine= function(dataset){
for (speak in speakers) {
print (speak); subseti=subset(dataset, SPEAKER==speak); 
frame=data.frame(speaker_id=subseti$SPEAKER, vowel_id=subseti$VOWEL, "context/N"=NA, F1=subseti$F1, F2=subseti$F2, F3=subseti$F3, "F1_glide"=NA, "F2_glide"=NA, "F3_glide"=NA); 
png(paste(speak, "_trapezoid.png")); 
vowelplot(frame, shape="vowels", leg="vowels", a.size=0.7, title=paste(speak,": ", subseti$GENDER[1], ", ", subseti$LOCATION[1],", ", subseti$ETHNICITY[1], ", ", subseti$AgeGrp[1])); 
add.spread.vowelplot(frame, mean.points=TRUE, sd.mult=0, color="red", size=0.7);
dev.off()}}

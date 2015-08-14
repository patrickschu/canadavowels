trapezmachine= function(dataset){
for (speak in speakers) {
print (speak); subseti=subset(dataset, SPEAKER==speak); 
frame=data.frame(speaker_id=subseti$SPEAKER, vowel_id=subseti$VOWEL, "context/N"=NA, F1=subseti$F1, F2=subseti$F2, F3=subseti$F3, "F1_glide"=NA, "F2_glide"=NA, "F3_glide"=NA); png(paste(speak, "_trapezoid.png")); 
vowelplot(frame, shape="vowels", color="speaker", color.choice=c("red", "green", "blue", "yellow", "black", "white", "brown", "gold", "gray")); 
dev.off()}}

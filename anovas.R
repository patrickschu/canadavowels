for (vow in vowels) { 
#this one puts 2 anovas per vowel into a text file
subseti=subset(data, VOWEL==vow); 
#the formulas, for future reference
formula1=F1n~LOCATION+AgeGrp+WORD+ETHNICITY+GENDER; 
formula2=F2n~LOCATION+AgeGrp+WORD+ETHNICITY+GENDER; 
#the anovas
analysis1=aov(formula1, data=subseti); 
analysis2= aov(formula2, data=subseti); 
#open file
sink(paste(vow, ".txt")); 
#convoluted print command
print (vow); cat("\n\n----------\n\n"); print(formula1); print(summary(analysis1)); cat("\n\n----------\n\n"); print(formula2); print(summary(analysis2)); 
sink()}}

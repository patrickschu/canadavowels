#This code is used for the first outline. We remove bad contexts and start plotting by location


#removing unpleasant contexts
#can=original[original$FPE!=c("nas","liq"),]
can=original[!(original$FPE %in% c("nas", "liq")) & original$PPE != "liq",]
summary(can$PPE)
summary(can$FPE)
summary(original$PPE)
summary(original$FPE)

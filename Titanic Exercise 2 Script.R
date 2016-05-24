# Read titanic csv into R as a dataframe 'tito
library(dplyr) # RC: you should include libraries which are required (for tbl_df)
tito<-tbl_df(read.csv(file.choose(),header=TRUE))
# Data exploration
View(tito)
str(tito)
levels(tito$embarked)
summary(tito$age)
levels(tito$cabin)
levels(tito$boat)

# Replace missing Embarked values with 'S'
tito$embarked[tito$embarked==""]<-"S" # it is a good style to surround "<-" by spaces for readibility
summary(tito$embarked)

# Replace missing Age values with mean of column. We cannot remove missing values since 
# they constitute c.20% of the total number of entries.
# tito$age[is.na(tito$age)==1]<-mean(tito$age,na.rm=TRUE) # RC: "==" is not needed...
tito$age[is.na(tito$age)] <- mean(tito$age,na.rm=TRUE)
summary(tito$age)

# Replace missing Boat values with 'NA'
levels(tito$boat)[1]<-"NA"

# Create new column 'has_cabin_number' with binary values 
# coerce Cabin values into character first
tito$cabin<-as.character(tito$cabin)
is.character(tito$cabin)
# create new column - 0 if Cabin has missing value, 1 otherwise
tito$has_cabin_number<-ifelse(tito$cabin=="",0,1)

# Write to csv as 'Titanic_clean'
write.csv(tito,'titanic_clean.csv')

# End of script

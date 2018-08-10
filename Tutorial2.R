# Jenny Bloom 12/27/2017
# Tutorial 2: From http://trevorstephens.com/kaggle-titanic-tutorial/r-part-2-the-gender-class-model/
# Gender-Class Model: Women and Children First

#Set Working Directory, Import and View Datasets
setwd("~/Desktop/Titanic") #Set Working Directory

train <- read.csv("~/Desktop/Titanic/train.csv") #Import Training Dataframe
View(train)

test <- read.csv("~/Desktop/Titanic/test.csv") #Import Test Dataframes
View(test)

# Obtain a summary of sex in the training dataset
summary(train$Sex) #314 passengers are female, 577 passengers are male

# Determine row-wise proportion of each sex that survived, as separate groups. 
# Give proportions in the 1st dimension which stands for the rows (using “2” instead would give you column proportions)
# NOTE: prop.table command by default takes each entry in the table and divides by the total number of passengers
# Prop.table expresses table entries as fraction of marginal table, where 1 is an index to generate margin for rows
prop.table(table(train$Sex, train$Survived), 1) #Females survived: 74.2%; males survived: 18.9%

test$Survived <- 0 #Create Survived column and assign all values 0 for 'everyone does not survive/ everyone dies'
test$Survived[test$Sex == 'female'] <- 1 #Assign persons who are variable sex = female a value of 1 meaning 'survive'

# Build prediction submission for Kaggle.com - all males perish, females saved
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived) #Total number of passengers who did not survive
write.csv(submit, file = 'allmalesperish.csv', row.names = FALSE) #Write submit dataframe to csv for importing to Kaggle.com

# Look into Age as a Predictor of Survivalsurvival
summary(train$Age) #NAs assumed to be mean age

train$Child <- 0 #Create column 'child' and fill with zero values
train$Child[train$Age < 18] <- 1 #Populate column Child with 1 values where age of passenger (row) is less than 18

# Use Aggregate: Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form
# Survived: Target variable
# Child & Sex: Subset variables
# Dataframe: train.csv
# Function: Sum, applied to subsets

aggregate(Survived ~ Child + Sex, data = train, FUN = sum)
# The command above subsets the whole dataframe over the different possible combinations of the age and gender variables 
# and applies the sum function to the Survived vector for each of these subsets. 
# As our target variable is coded as a 1 for survived, and 0 for not, the result of summing is the number of survivors.


# Find the total number of people in each subset:
aggregate(Survived ~ Child + Sex, data = train, FUN = length)
# This provides the total for each group of passengers. 

# Find the proportion of each group that survived. 
# Create a function that takes the subset vector as input and applies both sum and length functions
# and divides to provide a proportion
aggregate(Survived ~ Child + Sex, data = train, FUN = function(x) {sum(x)/length(x)})
# These data show that most females survive and very few males survive. 

# Apply more variables such as class and ticket price.
# Build new columns
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

# Check ticket price and class alongside survival rate
aggregate(Survived ~ Fare2 + Pclass + Sex, data = train, FUN = function(x) {sum(x)/length(x)})
# These data show males survived poorly regardless of class, and females in 3rd class who paid +$20 for tickets survived poorly.

# Check prediction on test dataset based on training data insights on class and ticket cost plus sex.
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

# Create new csv for Kaggle.com submission highlighting women and children survivability
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = 'womenchildren.csv', row.names = FALSE)
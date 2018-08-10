# Jenny Bloom 12/27/2017
# Tutorial 1 from http://trevorstephens.com/kaggle-titanic-tutorial/r-part-1-booting-up/
# Machine Learning in R for comprehension of Random Forest usage in Tabular datasets


#Set Working Directory, Import and View Datasets
setwd("~/Desktop/Titanic") #Set Working Directory

train <- read.csv("~/Desktop/Titanic/train.csv") #Import Training Dataframe
  View(train)

test <- read.csv("~/Desktop/Titanic/test.csv") #Import Test Dataframes
  View(test)

# table command runs through the vector you feed it and counts the occurrence of each value in the table
table(train$Survived) #549 passengers died, 342 passengers survived

# Calculate proportion of those that survived in training data
prop.table(table(train$Survived)) #61.61% died, and 38.38% survived in the training dataset

# Create test survived variable (column) and fill with zero
test$Survived <- rep(0, 418) #zero prediction = everyone dies prediction on test dataset

# Build prediction submission for Kaggle.com
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived) #Total number of passengers who did not survive
write.csv(submit, file = 'theyallperish.csv', row.names = FALSE) #Write submit dataframe to csv for importing to Kaggle.com
# Jenny Bloom 12/28/2017
# Tutorial 3: From http://trevorstephens.com/kaggle-titanic-tutorial/r-part-3-decision-trees/
# Decision Trees

#Set Working Directory, Import and View Datasets
setwd("~/Desktop/Titanic") #Set Working Directory

train <- read.csv("~/Desktop/Titanic/train.csv") #Import Training Dataframe
View(train)

test <- read.csv("~/Desktop/Titanic/test.csv") #Import Test Dataframes
View(test)
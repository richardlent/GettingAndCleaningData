# run_analysis.R 
 
# by Richard A. Lent

# Script submitted for Coursera Getting and Cleaning Data Course Project.
# See README.Rmd and CodeBook.Rmd for further details.

# Download and unzip the data.
# A subfolder of the current working folder called "UCI HAR Dataset" 
# will be created and will be set as the working folder. 
# NOTE: If folder "UCI HAR Dataset" already exists it will be overwritten.
# In that folder, the data of interest are in the "test" and "train" subfolders.
# When execution is complete the script will return to the original working folder.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip", overwrite = TRUE)
setwd("UCI HAR Dataset")

# Read test data, rename variables to feature names.
test <- read.table("test/X_test.txt", stringsAsFactors = TRUE)
features <- read.table("features.txt", stringsAsFactors = TRUE)
colnames(test) <- features[, 2]

# Read test activities and create activity variable using activity labels.
testactivities <- read.table("test/y_test.txt")
testactivities$activity[testactivities[1]==1] <- "walking"
testactivities$activity[testactivities[1]==2] <- "walking_upstairs"
testactivities$activity[testactivities[1]==3] <- "walking_downstairs"
testactivities$activity[testactivities[1]==4] <- "sitting"
testactivities$activity[testactivities[1]==5] <- "standing"
testactivities$activity[testactivities[1]==6] <- "laying"

# Read test subjects and create subjects variable.
testsubjects <- read.table("test/subject_test.txt")
colnames(testsubjects) <- "subjects"

# The block factor distinguishes the test and training datasets.
# Add the block, activity, and subject variables to the test dataset.
test <- cbind(block = "test", activity = testactivities$activity, subject = testsubjects$subjects, test)

# Read training data, rename variables to feature names.
train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
colnames(train) <- features[, 2]

# Read training activities and use activity labels to create
# descriptive activity names to name the activities in the data set.
trainactivities <- read.table("train/y_train.txt")
trainactivities$activity[trainactivities[1]==1] <- "walking"
trainactivities$activity[trainactivities[1]==2] <- "walking_upstairs"
trainactivities$activity[trainactivities[1]==3] <- "walking_downstairs"
trainactivities$activity[trainactivities[1]==4] <- "sitting"
trainactivities$activity[trainactivities[1]==5] <- "standing"
trainactivities$activity[trainactivities[1]==6] <- "laying"

# Read train subjects and create subjects variable.
trainsubjects <- read.table("train/subject_train.txt")
colnames(trainsubjects) <- "subjects"

# Add the block, activity, and subject variables to the train dataset.
train <- cbind(block = "train", activity = trainactivities$activity, subject = trainsubjects$subjects, train)

# Combine the test and training datasets by rows.
alldata <- rbind(test, train)

# Extract only the measurements on the mean and standard deviation.
means <- grepl("mean()", colnames(alldata), fixed = TRUE)
stds <- grepl("std()", colnames(alldata), fixed = TRUE)
keepvars <- means + stds
keepvars[1:3] <- c(1,1,1) # To keep the block, activity, and subject variables.
alldata <- alldata[as.logical(keepvars)]

# Create the tidy dataset.
library(dplyr)
alldatagrouped <- group_by(alldata, block, activity, subject)
tidydata <- summarize_each(alldatagrouped, funs(mean))
tidydata <- arrange(tidydata, activity, subject)

# Rename variables using descriptive variable names.
s <- names(tidydata)

# This loop removes extraneous parentheses and hyphens from the original activity names
# and creates camel case variable names (first letter of each word is capitalized).
for(i in 1:length(s))
{
    s[i] <- sub("std", "Std", s[i], fixed = TRUE)
    s[i] <- sub("mean", "Mean", s[i], fixed = TRUE)
    s[i] <- sub("()", "", s[i], fixed = TRUE)
    s[i] <- gsub("-", "", s[i], fixed = TRUE) 
    
    names(tidydata) <- s
}

# Create a plain-text CSV file of the tidy dataset named tidydata.csv.
# The CSV file can be read back into an R data frame with the command 
# tidydata <- read.csv("tidydata.csv").
# The CSV file can also be opened directly in spreadsheet applications such as
# Microsoft Excel, Apple Numbers, LibreOffice Calc, or Google Sheets in addition to
# many other database and statistical applications.
write.csv(tidydata, file = "tidydata.csv", row.names = FALSE)

# Cleanup.
rm (features, test, testactivities, testsubjects, train, trainactivities, trainsubjects, keepvars, means, stds, alldatagrouped, i, s, url)

# Return to original working folder.
setwd("../")




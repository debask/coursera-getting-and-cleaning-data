### The script that contains all logic for the coursera getting and cleaning data course.

## Load necessary packages
library(dplyr)

## Download and unzip data
filename <- "accDataset.zip"
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

## Step 1: merge the training and the test sets to create one data set.

# Merge all training data into one dataset
trainDataX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainDataY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainDataSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingData <- cbind(trainDataSubject, trainDataY, trainDataX)

# Merge all test data into one dataset
testDataX <- read.table("UCI HAR Dataset/test/X_test.txt")
testDataY <- read.table("UCI HAR Dataset/test/y_test.txt")
testDataSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testDataSubject, testDataY, testDataX)

# Merge training and test datasets into one
data <- rbind(trainingData, testData)

# Add names to total dataset
varNames <- read.table("UCI HAR Dataset/features.txt")
varNames[,2] <- gsub('-mean', 'Mean', varNames[,2])
varNames[,2] <- gsub('-std', 'Std', varNames[,2])
varNames[,2] <- gsub('[-()]', '', varNames[,2])
varNames[,2] <- make.names(varNames[,2], unique = TRUE) # rename duplicate variable names
names(data) <- c("subject", "activity", varNames[,2])

# Add labels to activity factor
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- tolower(activityLabels[,2])
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
data$subject <- as.factor(data$subject)


## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# Select variables that contain the mean or std + the subject ID and activity flag
data <- select(data, subject, activity, contains("mean"), contains("std"))


## Step 3: Use descriptive activity names to name the activities in the data set
## Step 4: Appropriately label the data set with descriptive variable names

# Already done, see above


## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

tidy <- data %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

# Save tidy dataset as csv
write.table(tidy, "tidy.txt", row.names=FALSE)

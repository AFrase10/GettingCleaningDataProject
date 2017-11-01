
#Review criteria 
#--The submitted data set is tidy.
#--The Github repo contains the required scripts.
#--GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables 
#and summaries calculated, along with units, and any other relevant information.
#--The README that explains the analysis files is clear and understandable.
#--The work submitted for this project is the work of the student who submitted it.

#Getting and Cleaning Data Course Project 
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a
# series of yes/no questions related to the project. 
# You will be required to submit: 
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or work that you performed to
#clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.

#One of the most exciting areas in all of data science right now is wearable computing - see for example this article .
#Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
#The data linked to from the course website rep resent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
#A full description is available at the site where the data was obtained:

######  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:

######  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following.

#--Merges the training and the test sets to create one data set.
#--Extracts only the measurements on the mean and standard deviation for each measurement.
#--Uses descriptive activity names to name the activities in the data set
#--Appropriately labels the data set with descriptive variable names.
#--From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.


library(data.table)
library(dplyr)
library(reshape2)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "projectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(url, f)
zipF<-file.choose() 
outDir<-"C:/Users/admin/Desktop" 
unzip(zipF,exdir=outDir)  

# load activity labels + features
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2] <- as.character(activity[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracts mean and standard deviation of variables
sd_mean <- grep("-(mean|std)\\(\\)", features[, 2])
sd_mean.var <- features[sd_mean,2]
sd_mean.var = gsub('-mean', 'Mean', sd_mean.var)
sd_mean.var = gsub('-std', 'Std', sd_mean.var)
sd_mean.var <- gsub('[-()]', '', sd_mean.var)

# arrange train and test separately before combining
train <- read.table("UCI HAR Dataset/train/X_train.txt")[sd_mean]
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivity, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[sd_mean]
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivity, test)

# merge datasets and add labels
mergeData <- rbind(train, test)
colnames(mergeData) <- c("Subject", "Activity", sd_mean.var)

# replaces level (1:6) with descriptive label 
mergeData$Activity <- factor(mergeData$Activity, levels = activity[,1], labels = activity[,2])


mergeData <- melt(mergeData, id = c("Subject", "Activity")) ##reshapes data

## step five. create new table with just mean values for each variable given subject + activity
means <- dcast(mergeData, Subject + Activity ~ variable, mean)
means <- melt(means, id = c("Subject", "Activity"))

# export image of tidied data
install.packages('gridExtra')
library(gridExtra)
grid.table(means[1:10,])

write.table(means, "CleanedData.txt", row.names = FALSE, quote = FALSE)




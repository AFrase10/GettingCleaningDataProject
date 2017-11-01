# Code Book

Generated 1-11-2017 by Adam Fraser 

## Introduction
This code book describes the data and the transformations made in run_analysis.R script. The purpose of this exercise was to obtain and tidy data.
The data examined was the Human Activity Recognition Using Smartphones Dataset, which consists of several measurements of human activity collected by using smart phones. There are 2 sets of data, one for training phase and one for testing
  ### Activities 
- Walking
- Laying
- Walking Upstairs
- Walking Downstairs
- Sitting 
- Standing

  ### Features
Signals recorded to detect human activity. '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
•	tBodyAcc-XYZ
•	tGravityAcc-XYZ
•	tBodyAccJerk-XYZ
•	tBodyGyro-XYZ
•	tBodyGyroJerk-XYZ
•	tBodyAccMag
•	tGravityAccMag
•	tBodyAccJerkMag
•	tBodyGyroMag
•	tBodyGyroJerkMag
•	fBodyAcc-XYZ
•	fBodyAccJerk-XYZ
•	fBodyGyro-XYZ
•	fBodyAccMag
•	fBodyAccJerkMag
•	fBodyGyroMag
•	fBodyGyroJerkMag

##Transformations

One of the objectives was to merge the two data sets: train and test. I constructed data frames for both sets before merging them (mergeData) using cbind().

Another objective was to extract only measurements of mean and standard deviation. This was saved in object sd_mean. 88% of raw data was eliminated by this extraction. I then modified the labels for features/variables to try and make them look a little cleaner (sd_mean.var).

Using descriptive labelling was another objective. The activities were labelled by an assigned number ranging from 1-6. I changed this to instead include the physical term. 
	mergeData$Activity <- factor(mergeData$Activity, levels = activity[,1], labels = activity[,2])

I used the melt function to reshape this data set to make it tidier and easier to follow. Now all the data is aligned in 4 columns. 

I was then required to take my data set, mergeData, to create a new data set which consists of the average of each variable for every activity and every subject. 
	means <- dcast(mergeData, Subject + Activity ~ variable, mean)

I applied the melt function to this new data set and am left with a data frame looking like this. (I selected only the first 10 rows).










---
title: "CodeBook"
author: "Matthew McLean"
date: "Sunday, March 22, 2015"
output: html_document
---

**Study Design**
As mentioned in the README.md, the source data used to produce the tidy data set avg_variable_by_activity_subject.txt is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data set was produced to meet the following requirements:

1. The Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**Preparing the data**
The associated R script **run_analysis.R** contains all the code used to prepare the data.

The bulk of the transformation work was to stitch together the multiple data source files to produce a single data set.
The resulting merged data set was made up of 10299 observations and 83 variables.
The measurements are the mean and standard deviation measurements as provided in the *Human Activity Recognition Using Smartphones Data Set*
For more details about the source files and steps, please see the associated **README.md** file.
run_analysis.R is also commented to explain what it is doing.


**The final data**
The data is a summary by Exercise Activity and Subject/Person.
There are 180 observations of 81 variables in the final output. This is the "wide" option where there is a single row for each instance of an activity/subject with the associated averaged measurements included in each row as separate columns, as according to the tidy data principles.


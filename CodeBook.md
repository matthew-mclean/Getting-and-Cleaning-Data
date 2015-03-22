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

The bulk of the transformation work involved stitching together the multiple data source files to produce a single data set.
The resulting interim merged data set is made up of 10299 observations and 83 variables.
The measurements in the interim merged data set are the mean and standard deviation measurements as provided in the *Human Activity Recognition Using Smartphones Data Set*. These mean and standard deviation measurements are a subset of the full set of 561 measurements available in the source data set.
For more details about the source files and steps, please see the associated **README.md** file.
run_analysis.R is also commented to explain what it is doing.


**The final output data set: avg_variable_by_activity_subject.txt**
The data is a summary by Exercise Activity (activity) and Subject/Person (subject).
There are 180 observations of 81 variables in the final output, with 79 of the variables being the mean and standard deviation measurements, and the other two being the activity and subject. This is the "wide" output option where there is a single row for each instance of an activity/subject with the associated averaged measurements included in each row as separate columns, as according to the tidy data principles. The other output option (not taken) was to produce a narrow data set consisting of the activity, subject, measure_type, measure_value.
The reason the wide option was chosen is to enable simpler analysis when looking across the measurements for a given set of activity/subject values. The wide data set is permissible since the data is dense, i.e. there are no missing values.

**To read the data into a data frame, run the following (assuming the file avg_variable_by_activity_subject.txt is in the working directory):**

 read.table("avg_variable_by_activity_subject.txt", header=TRUE, sep = ",")
---
title: "README"
author: "Matthew McLean"
date: "Sunday, March 22, 2015"
output: html_document
---
#Coursera Getting and Cleaning Data, Course Project


##About the source data

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The direct URL to the source zip file is here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

See the README.txt that comes with the *Human Activity Recognition Using Smartphones Data Set* for details about how the source data is structured.

###Here's a quick summary of the data sources we will be working with:
There are two data sets we need to work with, a training set and a test set, both of which are similarly stuctured.
The training data set ./train/X_train.txt consists of 7352 rows, each is an observation for a particlar subject/person and an exercise activity. Since the first variable is preceded by two spaces, use sep = 
"" to read the data cleanly.
The subject number is provided in the ./train/subject_train.txt file. There are 21 subjects in the training set.
To determine the exercise activity being undertaken by the subject, two files are required, the ./train/y_train.txt - this provides a number from 1 to 6 indicating the paticular activiy for the row, and 
./activity_labels.txt which provides the description for each of the 6 activities.
Each column of ./train/X_train.txt makes up one of the 561 variables or "features". The feature labels are provided in ./features.txt. The "bandsEnergy" feature labels are duplicated, but since these will be 
discarded, it is not an issue.

The test data set has the same overall structure, however the subjects are different people and there are only 9 of them.
Consequently, the test data set in ./test/X_test.txt only has 2947 rows, which matches the number of rows in y_test.txt and subject_test.txt.

In summary:

**Files in Common to both training and test data sets**

File  | Description
------------- | -------------
./features.txt | The column observations (feature) labels
./activity_labels.txt | The description of the activity

**Training Data Set:**

File  | Description
------------- | -------------
./train/X_train.txt  | The main training data set
./train/subject_train.txt  | The training subjects to match to the main data set
./train/y_train.txt | The numeric form of the paticular activiy for the row

**Test Data Set:**

File  | Description
------------- | -------------
./test/X_test.txt  | The main test data set
./test/subject_test.txt  | The test subjects to match to the main data set
./test/y_test.txt | The numeric form of the paticular activiy for the row

The inertia data in ./train/Inertial Signals and ./test/Inertial Signals is not needed for our purposes and will be ignored.


**The following describes how the data has been manipulated to prepare it for our analysis:**

1. First download the relevant files
2. Read the data common to the training and test data sets into data frames
  + Read the features data. I am including the column labels
  + Followed by the activity labels, including the column labels
3. Read the training specific data into data frames
  + Read the training data set and include the column names loaded earlier in step 2.
  + Read the training subjects and label accordingly.
  + Read the training activity class data
4. Read the test specific data
  + Read the test data set and include the column names loaded earlier.
  + Read the test subjects and label accordingly
  + Read the test activity class data
5. Column Merge a new column called DataSet (not required, but included to keep track of the 2 data sets), along with the training data sources
6. The plyr package is used to perform the join, so it needs to be loaded
7. Now we can join the activity labels to our merged training data (it uses the only common column: activity_class)
8. Now we repeat 5. and 7. above for the test data, first merging by column binding
9. Then joining in the activity labels for the test data too
10. We only need the first 4 label columns. The grep function is used to filter on just the mean and standard deviation features for test and trainings data sets
11. Now we merge the training and the test sets to create one data set
12. I then check to ensure there is no missing data
13. reshape2 is needed for melt and dcast, so this is loaded
14. The data is "melted" and we include just what is needed, the activity and subject and the features. subsetting is used to restrict measure.vars to the required indices of the column names
15. Now we can dcast the melted data and get the average of the features by activity and subject.This creates the wide form of the data in accordance with the tidy data principles. 
16. Finally the final tidy data can be written out to file.

**To read the data into a data frame, run the following (assuming the file avg_variable_by_activity_subject.txt is in the working directory):**

 read.table("avg_variable_by_activity_subject.txt", header=TRUE, sep = ",")

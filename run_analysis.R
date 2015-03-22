## 1. First download the relevant files:
  setwd("~/Data Science/Getting and Cleaning Data/Course Project")
  dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(dataset_url, "Smartphone_Data_Set.zip")
  unzip("Smartphone_Data_Set.zip", exdir = "Smartphone_Data_Set")
  setwd("~/Data Science/Getting and Cleaning Data/Course Project/Smartphone_Data_Set/UCI HAR Dataset")

## 2. Read the data common to the training and test data sets:
  ## read the features data. I am including the column labels
    features <- read.table("features.txt", sep = " ", col.names = c("number","feature"))
  ## followed by the activity labels, including the column labels
    activity_labels <- read.table("activity_labels.txt", sep = " ", col.names = c("activity_class","activity"))

## 3. Read the training specific data:
  ## Read the training data set and include the column names loaded earlier.  
    X_train <- read.table("./train/X_train.txt", header = FALSE, sep = "", col.names = as.character(features$feature))
  ## Read the training subjects and label accordingly.  
    subject_train <- read.table("./train/subject_train.txt", col.name = c("subject"))
  ## Read the training activity class data
    y_train <- read.table("./train/y_train.txt ", col.name = c("activity_class"))

## 4. Read the test specific data:
  ## Read the test data set and include the column names loaded earlier.  
    X_test <- read.table("./test/X_test.txt", header = FALSE, sep = "", col.names = as.character(features$feature))
  ## Read the test subjects and label accordingly.  
    subject_test <- read.table("./test/subject_test.txt", col.name = c("subject"))
  ## Read the test activity class data
    y_test <- read.table("./test/y_test.txt ", col.name = c("activity_class"))

## 5. Column Merge a new column called DataSet (not required, but included to keep track of the 2 data sets), along with the training data sources:
  train_merge <- cbind(DataSet = rep("Training", times = nrow(y_train)), y_train,subject_train,X_train)

## 6. plyr is needed for join
  library(plyr)
## 7. Now we can join the activity labels to our merged training data (it uses the only common column: activity_class):
  train_merge <- join(activity_labels,train_merge)

## 8. Now we repeat 5. and 7. above for the test data, first merging by column binding
  test_merge <- cbind(DataSet = rep("Test", times = nrow(y_test)), y_test,subject_test,X_test)

## 9. Then joining in the activity labels
  test_merge <- join(activity_labels,test_merge)

## 10. We only need the first 4 label columns and the mean and standard deviation features for test and train data sets:
  test_mean_sd <- test_merge[,c(1:4,grep("mean",names(test_merge)),grep("std",names(test_merge)))]
  train_mean_sd <- train_merge[,c(1:4,grep("mean",names(train_merge)),grep("std",names(train_merge)))]

## 11. Now we merge the training and the test sets to create one data set:
  combined_set_mean_sd <- rbind(test_mean_sd,train_mean_sd)

## 12. Just a check to ensure no missing data:  
  all(colSums(is.na(combined_set_mean_sd))==0) ##there is no missing data.

## 13. reshape2 is needed for melt and dcast:
  library(reshape2)

## 14. The data is "melted" and we include just what is needed, the activity and subject and the features:
  melt_mean_sd <- melt(combined_set_mean_sd,id=c("activity","subject"),measure.vars=names(combined_set_mean_sd)[5:length(names(combined_set_mean_sd))])

## 15. Now we can dcast into the wide form of the averaged data:
  avg_variable_by_activity_subject <- dcast(melt_mean_sd, activity + subject ~ variable,mean)

## 16. Finally the final tidy data can be written out:  
  setwd("~/Data Science/Getting and Cleaning Data/Course Project")
  write.table(avg_variable_by_activity_subject, file = "avg_variable_by_activity_subject.txt", sep = ",", row.name=FALSE) 

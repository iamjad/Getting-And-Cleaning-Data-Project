# Introduction
This repository provides R code that performs cleaning and tidy of Human Activity Recognition Using Smartphones Dataset. It loads and merges training and test datasets and extracts average values of mean and standard deviation measurements. It creates final dataset in the file human-activity-recognization-analyzed.txt. 

The raw data is available here.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Required Libraries

Install following R libraries before executing run_analysis.R script.

- dplyr
- stringr

# Methodology

Following methodology is applied on raw data to clean and tidy the data. 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

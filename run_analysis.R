##########################################################################################################

# Coursera Getting and Cleaning Data Course Project

# Author: iamjad
# Date: 2015-06-12
##########################################################################################################

library(dplyr)
library(stringr)

# load features.txt that has column names for X_train.txt and X_test.txt sets.
features <- read.table("features.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(features) <- c("Id", "FeatureName")
#Remove special characters from column names to make it more descriptive. 
features$FeatureName <- unlist(lapply(features$FeatureName, function(x) {
	x <- str_replace_all(x, "[[:punct:]]", "")
}))

# load activity labels
activity_labels <- read.table("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(activity_labels) <- c("Id", "Label")

# Step 1 Preparing the merge of train and test sets. Step #4 is also accomplished here as it uses features names for variable columns
subject_test <- read.table("test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
activities_test <- read.table("test/y_test.txt", header = FALSE, stringsAsFactors = FALSE)
test <- read.table("test/X_test.txt", header = FALSE, stringsAsFactors = FALSE, fill = TRUE, numerals = "no.loss", colClasse = rep("numeric"), col.names = features$FeatureName)

subject_train <- read.table("train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
activities_train <- read.table("train/y_train.txt", header = FALSE, stringsAsFactors = FALSE)
train <- read.table("train/X_train.txt", header = FALSE, stringsAsFactors = FALSE, fill = TRUE, numerals = "no.loss", colClasse = rep("numeric"), col.names = features$FeatureName)

# combine the two data set
traintest_set <- rbind.fill(test, train)
traintest_subject_set <- rbind.fill(subject_test, subject_train)
traintest_activities_set <- rbind.fill(activities_test, activities_train)

# Step #2. Extract mean and standard deviation of each measurement.
colName <- names(traintest_set)
traintest_subset <- traintest_set[, grep("mean|std", colName)] #filter on column names that has mean or std in the column name.

#Step #3. Add activities column in traintest set and create activity labels using file "activity_labels.txt"
traintest_subset$activity <- unlist(lapply(traintest_activities_set$V1, function(x) {
	select(filter(activity_labels, Id == x), Label)
}))

# Step 5. Calculate Average of each measurement for each subject and activity.
traintest_subset$subject <- traintest_subject_set$V1

traintest_subset_grouped <- traintest_subset %>% group_by(subject, activity)
result_df <- aggregate(traintest_subset_grouped[, 1:79], list(Activity = traintest_subset_grouped$activity, Subject = traintest_subset_grouped$subject), mean)
write.table(result_df, file = "human-activity-recognization-analyzed.txt", row.names = FALSE)

# remove variables

rm(traintest_subset)
rm(traintest_subset_grouped)
rm(result_df)

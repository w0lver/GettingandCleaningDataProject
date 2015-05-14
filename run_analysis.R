# This is an R script called run_analysis.R that does the following: 
#
# Merges the training and the test sets to create one data set.
# 1. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 2. Uses descriptive activity names to name the activities in the data set
# 3. Appropriately labels the data set with descriptive variable names. 
# 4. From the merged data set, creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject

# load dplyr library functions
library(dplyr)

# load features file into data frame
features_raw <- read.table("./UCI HAR Dataset/features.txt")

# remove index column from features
features_df <- features_raw[ c(2) ]

# convert features from data frame to vector
features <- as.vector(t(features_df))

# load activity labels file into data frame
activity_labels_raw <- read.table("./UCI HAR Dataset/activity_labels.txt")

# remove index column from features
activity_labels_df <- activity_labels_raw[ c(2) ]

# convert features from data frame to vector
activity_labels <- as.vector(t(activity_labels_df))

# load x test into data frame
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

# load y test into data frame
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# load subject test into data frame
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# add features names into column names for data frame x test
names(x_test) = features

# create boolean vector of the features that match "std" or "mean" via grep and regex
filter_features <- grepl("mean|std", features)

# subset data frame by using filter features boolean
filtered_x_test = x_test[,filter_features]

# create table of activity type based on activity code
activity_type <- activity_labels[y_test$V1]

# convert y_test in a vector
y_test_vector <- as.vector(t(y_test))

# creating new data frame with the activity type and code
labeled_y_test = data.frame(activity_code = cbind(y_test_vector), activity_type = cbind(activity_type))

# add labels to labeled_y_test and subjects
names(labeled_y_test) = c("activity_code", "activity_type")
names(subject_test) = "subject"

# combined all test data
all_test_data <- cbind(subject_test, filtered_x_test, labeled_y_test)

# load train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# add features names into column names for data frame x train 
names(x_train) = features

# subset x train by using filter features boolean features vector
filtered_x_train = x_train[,filter_features]

# create table of activity type based on activity code
activity_type <- activity_labels[y_train$V1]

# convert y_train in a vector
y_train_vector <- as.vector(t(y_train))

# creating new data frame with the activity type and code
labeled_y_train = data.frame(activity_code = cbind(y_train_vector), activity_type = cbind(activity_type))

# add labels to labeled_y_train and subjects
names(labeled_y_train) = c("activity_code", "activity_type")
names(subject_train) = "subject"

# combined all train data
all_train_data <- cbind(subject_train, filtered_x_train, labeled_y_train)

# combine test and train data
all_data <- rbind(all_test_data, all_train_data)

# reorder columns of all data moving activity_type next to subject
all_data <- all_data[c(1,82,2:81)]

# convert data columns to numeric
all_data[, 3:82] <- sapply(all_data[, 3:82], as.numeric)

# group the data by subject and activity type
grouped <- group_by(all_data, subject, activity_type)

# summarize all the rows by the groups
final_data <- grouped %>% summarise_each(funs(mean))

# write final data
write.table(final_data, file = "./final_data.txt", row.name=FALSE)

# script complete






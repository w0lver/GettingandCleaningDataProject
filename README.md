# GettingandCleaningDataProject
## Getting and Cleaning Data Course Project for Coursera - Ross Rankin

This script performs the following:
<i>(Note this script requires the Samsung UCI HAR Dataset to be it the working directory)</i>
> Loads dplyr library functions >
> Loads features file into data frame
> Removes index column from features
> Converts features from data frame to vector
> Loads activity labels file into data frame
> Removes index column from features
> Converts features from data frame to vector
> Loads x test into data frame
> Loads y test into data frame
> Loads subject test into data frame
> Adds features names into column names for data frame x test
> Creates boolean vector of the features that match "std" or "mean" via grep and regex
> Subsets data frame by using filter features boolean
> Creates table of activity type based on activity code
> Converts y_test in a vector
> Creates new data frame with the activity type and code
> Adds labels to labeled_y_test and subjects
> Combines all test data
> Loads train data
> Adds features names into column names for data frame x train 
> Subsets x train by using filter features boolean features vector
> Creates table of activity type based on activity code
> Converts y_train in a vector
> Creates new data frame with the activity type and code
> Adds labels to labeled_y_train and subjects
> Combines all train data
> Combines test and train data
> Reorders columns of all data moving activity_type next to subject
> Converts data columns to numeric
> Groups the data by subject and activity type
> Summarizes all the rows by the groups
> Writes final data



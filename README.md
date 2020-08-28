# GettingCleaningData

Purpose: demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

run_alaysis.R performs the following:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


To reduce clutter a function, merge_data(), was used to perform the following steps...

merge_data() reads the test and train sets
    X_test = X_test.txt
    y_test = y_test.txt
    subject_test = subject_test.txt
    X_train = X_train.txt
    y_train = y_train.txt
    subject_train = subject_train.txt
    
merge_data() reads the activity ID and features (column names) of the test/train data    
    features = features.txt
    activity = activity_labels.txt
    
merge_data() row and column binds the data into a single data.table 
    all_data = merged data
    
merge_data() also sets the column names and replaces the activity code with the activity description.

lastly, merge_data() extracts only the mean and standard deviation data into a data_tabele
    mean_std_data = merged mean and std data frame

average_data = data is grouped (subject, activity) and summarized by mean

tidy tables are written to the data directory
    tidy_mean_std_data.txt
    tidy_summary_mean_std_data.txt

Required R Packages:

The following packages are required for run_analysis.R: data.table, dplyr

CodeBook:
dataMaid package was used to create Codebook

Source for data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
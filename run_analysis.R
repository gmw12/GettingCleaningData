library(data.table)
library(dplyr)

# data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# and unzipped into "data" folder in working directory

# Merges the training and the test sets to create one data set
#load features are column names
# load activity reference

merge_data <- function()   {
    
    X_test <- fread("./data/test/X_test.txt")
    y_test <- fread("./data/test/y_test.txt")
    subject_test <- fread("./data/test/subject_test.txt")
    
    X_train <- fread("./data/train/X_train.txt")
    y_train <- fread("./data/train/y_train.txt")
    subject_train <- fread("./data/train/subject_train.txt")
    
    features <- fread("./data/features.txt")
    
    activity <- fread("./data/activity_labels.txt")
    
    all_data <- cbind(rbind(subject_test, subject_train), 
                      rbind(y_test, y_train), 
                      rbind(X_test, X_train))
    
    names(all_data) <- c("subject", "activity", features$V2)

    
    #Uses descriptive activity names to name the activities in the data set
    all_data$activity <- unlist(lapply(all_data$activity, function(x) activity$V2[match(x, activity$V1)]  ) )
    
    #Extracts only the measurements on the mean and standard deviation for each measurement.
    mean_std_data <<- select(all_data, contains("subject"), contains("activity"),
                             contains("mean"), contains("std"), -contains("freq"),
                             -contains("angle"))
    
    # clean column names, by removing "()", replacing "-" with "_", and removing "BodyBody" with "Body"
    names(mean_std_data) <<- gsub("\\(\\)", "", colnames(mean_std_data))
    names(mean_std_data) <<- gsub("-", "_", colnames(mean_std_data))
    names(mean_std_data) <<- gsub("BodyBody", "Body", colnames(mean_std_data))
    
}

merge_data()


#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
average_data <- mean_std_data %>% 
    group_by(subject, activity) %>%
    summarise_all(mean) %>%
    arrange(subject, activity)



#write tables
write.table(average_data, file="./data/tidy_summary_mean_std_data.txt", row.names = FALSE)


write.csv(average_data, file="./data/tidy_summary_mean_std_data.csv", row.names = FALSE)




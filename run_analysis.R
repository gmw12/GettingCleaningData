library(data.table)
library(dplyr)


# Merges the training and the test sets to create one data set
#load features are column names
# load activity reference
X_test <- fread("./data/test/X_test.txt")
y_test <- fread("./data/test/y_test.txt")
X_train <- fread("./data/train/X_train.txt")
y_train <- fread("./data/train/y_train.txt")

features <- fread("./data/features.txt")

activity <- fread("./data/activity_labels.txt")

all_data <- cbind(rbind(y_test, y_train), rbind(X_test, X_train))
names(all_data) <- c("activity", features$V2)


#Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data <- select(all_data, matches("activity|mean|std"))

#Uses descriptive activity names to name the activities in the data set
mean_std_data$activity <- lapply(mean_std_data$activity, function(x) activity$V2[match(x, activity$V1)]  )


#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
average_data <- mean_std_data %>% 
    group_by(activity) %>%
    summarise_all(mean)






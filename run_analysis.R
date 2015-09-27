setwd("G:/Study Materials-IIT Guwahati/Sem 5/Data Analysis - John Hopkins University/Getting and Cleaning Data/UCI HAR Dataset")

# Reading the .txt files into tables.

test <- read.table("./test/X_test.txt", sep="")
train <- read.table("./train/X_train.txt",sep="")
test_labels <- read.table("./test/y_test.txt",sep = "\n")
train_labels <- read.table("./train/y_train.txt",sep = "\n")
features <- read.table("./features.txt",sep="\n")
activity_names <- read.table("./activity_labels.txt",sep ="")
colnames(activity_names) <- c("activity_labels","activity")
subject_test <- read.table("./test/subject_test.txt", sep = "\n")
subject_train <- read.table("./train/subject_train.txt", sep = "\n")

# Merging the test and train sets
merged <- rbind(test, train)

# Adding column names to the merged test and train data.  
colnames(merged) <- as.character(features[[1]])

# Merging the activity labels for test and train sets. 
merged_labels <- rbind(test_labels, train_labels)
colnames(merged_labels) <- c("activity_labels")

# Merging the subject labels for test and train sets.
merged_subject <- rbind(subject_test, subject_train)
colnames(merged_subject) <- c("subject_label")

# selecting only those variables which correspond to mean or standard deviation. 
# () has been escaped to make sure columns like fBodyAcc-meanFreq()-X are not selected
merged_mean_std <- merged[,grepl("mean\\()|std\\()",names(merged))]

# Creating a data frame consisting of subject labels, merged test and train sets for
# mean and standard deviation variables, and activity labels.
data <- data.frame(merged_subject, merged_mean_std, merged_labels)

# Adding names of activities. 
merged_activity_data <- merge(data, activity_names, by="activity_labels")

#Calculating average of each variable for each activity and each subject.
grouping <- group_by(merged_activity_data, subject_label, activity_labels)
summarized_data <- summarise_each(grouping, funs(mean))

# Writing the table to the working directory. 
# Variable Names have been included at the top with col.names = TRUE
write.table(summarized_data, file="summarized_data.txt",row.name=FALSE, col.names=TRUE)

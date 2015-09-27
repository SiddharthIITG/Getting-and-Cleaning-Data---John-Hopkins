# Reading train and test data into tables.
train_data <- read.table("./data/train/X_train.txt",sep="")
train_labels <- read.table("./data/train/y_train.txt",sep = "\n")
train_subject <- read.table("./data/train/subject_train.txt", sep = "\n")

test_data <- read.table("./data/test/X_test.txt", sep="")
test_labels <- read.table("./data/test/y_test.txt",sep = "\n")
test_subject <- read.table("./data/test/subject_test.txt", sep = "\n")

# Merging the test and train sets
merged_data <- rbind(test_data, train_data)

# Merging the activity labels for test and train sets. 
merged_labels <- rbind(test_labels, train_labels)
names(merged_labels) <- c("activity_labels")

# Merging the subject labels for test and train sets.
merged_subject <- rbind(test_subject, train_subject)
names(merged_subject) <- c("subject_label")

features <- read.table("./data/features.txt",sep="\n")
activity_names <- read.table("./data/activity_labels.txt",sep ="")
names(activity_names) <- c("activity_labels","activity")

# Adding column names to the merged test and train data.  
names(merged_data) <- as.character(features[[1]])

# selecting only those variables which correspond to mean or standard deviation. 
# () has been escaped to make sure columns like fBodyAcc-meanFreq()-X are not selected.
merged_mean_std <- merged_data[,grepl("mean\\()|std\\()",names(merged_data))] 

names(merged_mean_std) <- gsub("-", "", names(merged_mean_std))
names(merged_mean_std) <- gsub("mean", "Mean", names(merged_mean_std)) 
names(merged_mean_std) <- gsub("std", "Std", names(merged_mean_std)) 
names(merged_mean_std) <- gsub("\\(\\)", "", names(merged_mean_std)) 
 
# Creating a data frame consisting of subject labels, merged test and train sets for
# mean and standard deviation variables, and activity labels.
subset_data <- data.frame(merged_subject, merged_mean_std, merged_labels)
write.table(subset_data, file = "merged_data.txt", row.name=FALSE, col.names=TRUE)

# Adding names of activities. 
merged_activity_data <- merge(subset_data, activity_names, by="activity_labels")

#Calculating average of each variable for each activity and each subject.
grouping <- group_by(merged_activity_data, subject_label, activity_labels)
summarized_data <- summarise_each(grouping, funs(mean))

# Writing the table to the working directory. 
# Variable Names have been included at the top with col.names = TRUE
write.table(summarized_data, file="summarized_data.txt",row.name=FALSE, col.names=TRUE)

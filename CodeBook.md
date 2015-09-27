## Getting and Cleaning Data Course Project CodeBook
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
* The site from where data was obtained 
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* The data for the project
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The run_analysis.R script performs the following steps to clean the data:
  * Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *train_Data*, *train_labels* and *train_subject* variables respectively.
  * Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in *test_Data*, *test_labels* and *test_subject* variables respectively.
  * Concatenate *test_data* to *train_data* to generate a 10299x561 data frame, *merged_data*; concatenate *test_label* to *train_label* to generate a 10299x1 data frame, *merged_labels*; concatenate *test_subject* to *train_subject* to generate a 10299x1 data frame, *merged_subject*.
  * Read the features.txt file from the "/data" folder and store the data in a variable called *features*. 
  * Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called *activity_names*.
  * Name the columns of *activity_names* as "activity_labels" and "activity".
  * Name the columns of *merged_data*, making them equal to the value of the first column of features. 
  * Create a 10299x66 data frame *merged_mean_std* by subsetting the *merged_data* data frame to variables which are either mean or standard deviation values using grepl.
  * Clean the column names of the data frame *merged_mean_std*. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
  * Create a 10299x68 data frame *subset_data* which includes subject labels, 66 mean and standard deviation variables and activity labels.
  * Create a 10299x69 data frame *merged_activity_data* by merging *subset_data* and *activity_names* by the activity_labels column.
  * Group the data frame *merged_activity_data* by subject_label and activity_labels using group_by function of dplyr package.
  * Finally generate a 180x69 data frame, *summarized_data*, with the average of each measurement for each activity and each subject, by using the summarize_each function of dplyr package.
  * Write the result out to "summarized_data.txt" file in current working directory.

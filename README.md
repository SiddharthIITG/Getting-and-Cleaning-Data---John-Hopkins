# Course Project Getting and Cleaning Data John Hopkins

This file describes how run_analysis.R script works.
* Download and unzip the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder "data".
* Make sure the folder "data" and the run_analysis.R script are both in the current working directory.
* Run source("run_analysis.R") command.
* Two outputs will be genrated in the working directory.
 *merged_data.txt : it contains a data frame subset_data with 10299x68 dimension.
 *summarized_data.txt : it contains a data frame called summarized_data with 180x69 dimension.
* use data <- read.table("summarized_data.txt", sep="") command in RStudio to read the file.
 

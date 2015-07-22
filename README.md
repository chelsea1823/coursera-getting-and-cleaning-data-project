# Getting and Cleaning Data- Course Project 

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Download the dataset and unzip it if it does not exist in the working directory
2. Load the activity and feature 
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Merge the two datasets, and label the new dataset with descriptive vairable names
5. Converts the activity and subject columns into factors
6. Label the activity columns with descriptive names, by loading the activity label data.
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
8. The end result is shown in the file tidy.txt.


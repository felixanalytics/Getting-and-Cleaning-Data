---
title: "Getting and Cleaning Data Peer Graded Assignment Code Book"
output: github_document
---
*Data obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
*Data for the assignment from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*The run_analysis.R script performs the following steps to clean the data:
1. Reads x_train.txt, y_train.txt and subject_train.txt from the "./train" folder and stores them into trainData, trainLabel and trainSubject variables, respectively.

2. Reads x_test.txt, y_test.txt and subject_test.txt from the "./test" folder and stores them in testData, testLabel and testSubject variables, respectively.

3. Joins testData to trainData to generate a dataframe named joinData; Joins testLabel to trainLabel to generate a dataframe named joinLabel; Joins testSubject to trainSubject to generate a dataframe named joinSubject.

4. Reads the features.txt file and stores the data in a variable named features. The mean and standard deviation are only extracted resulting in a columnar list of 66 aligned with a subset of joinData.

5. Cleans the column names of the subset. Removes the "()" and "-" symbols in the names, as well as capitalizes the first letter of "Mean" and "Std".

6. Reads the activity_labels.txt file and stores the data in a variable named activity.

7. Cleans the activity names in the second column of activity by making all names lower case. If the name has an underscore between letters, it removes the underscore and capitalizes the letter immediately after the underscore.

8. Transforms the values of joinLabel according to the activity dataframe.

9. Combines the joinSubject, joinLabel and joinData by column to get a new clean dataframe named cleanData. Properly names the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1.

10. Writes the cleanData out to "merged_data.txt" in current working directory.

11. Generates a second independent tidy data set with the average of each measurement for each activity and each subject. There are 30 unique subjects and 6 unique activities, which result in a 180 combinations. Then, for each combination, it calculates the mean of each measurement accounting for its corresponding combination. Initializing the result dataframe and performing the two for-loops, a dataframe of 180 rows and 68 columns is produced.

12. Writes the result out to "data_with_means.txt" in current working directory. 
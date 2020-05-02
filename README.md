# tidydatasethw
Assignment submission for Coursera: Getting and Cleaning Data

=========================================================================================
This script cleans data from the Human Activity Recognition Using Smartphones Dataset (Version 1.0) and 
returns a tidy data set containing averages of all variables grouped by activity and subject.

Input data files:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window 
sample. Its range is from 1 to 30 (same description for test set).
=========================================================================================
Cleaning Steps:
1. Read all relevant test and train data sets
2. Merges test and train sets into one set
3. Extracts relevant data, that is the variables that contain MEAN or STD data
4. Appropriately labels the data set with descriptive variable names from Activity_Labels data file
5. Creates an independent tidy data set with the average of each variable for each activity and each subject.

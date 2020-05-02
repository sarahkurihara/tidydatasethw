##You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
##    each variable for each activity and each subject.

# Read test and train data sets
TrainData <- read.table("test/X_test.txt")
TrainLabels <- read.table("test/y_test.txt")
TestData <- read.table("train/X_train.txt")
TestLabels <- read.table("train/y_train.txt")
ActivityLables <- read.table("activity_labels.txt")
FeatureNames <- read.table("features.txt")
FeatureNamesVector <- as.character(FeatureNames)
TrainSubjectNames <- read.table("train/subject_train.txt")
TestSubjectNames <- read.table("test/subject_test.txt")

# Merge test and train sets
StackedData <- rbind(TestData, TrainData)
StackedLabels <- rbind(TestLabels, TrainLabels)
StackedLabels <- merge(StackedLabels, ActivityLables)
StackedNames <- rbind(TestSubjectNames, TrainSubjectNames)

# Extract Relevant Data
Indexes <- grep("mean|std", FeatureNames[,2])
StackedFiltered <- StackedData[,Indexes]

# Appropiately label the data set with descriptive variable names
names(StackedFiltered) <- FeatureNames[Indexes,2]
StackedFiltered <- cbind(StackedFiltered, "Activity" = StackedLabels[,2], "Subject" = StackedNames[,1])

# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
GroupedSF <- group_by(StackedFiltered, Activity, Subject)
GroupedSFAvg <- summarise_all(GroupedSF, mean)


##You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
##    each variable for each activity and each subject.

# Read train data
TrainData <- read.table("train/X_train.txt")
TrainSubjects <- read.table("train/subject_train.txt")

#Read test data
TestData <- read.table("test/X_test.txt")
TestSubjects <- read.table("test/subject_test.txt")

# Merge test and train sets
StackedData <- rbind(TrainData, TestData)
StackedSubjects <- rbind(TrainSubjects, TestSubjects)
colnames(StackedSubjects) <- "subjects"

#Get Variable names
Variables <- read.table("features.txt")
Variables <- Variables[2]
names(Variables) <- "Features"

# Extract Relevant Data
Indexes <- grep("mean|std", Variables$Features)
StackedData <- StackedData[,Indexes]

# Appropiately label the data set with descriptive variable names
names(StackedData) <- Variables[Indexes,1]

# Bind Data and Subjects
StackedData <- cbind(StackedData, StackedSubjects)

#Get Activity Numbers
TrainActivity <- read.table("train/y_train.txt")
TestActivity <- read.table("test/y_test.txt")
StackedActivity <- rbind(TrainActivity, TestActivity)
names(StackedActivity) <- "activity"

#Get Activity Labels
ActivityLabels <- read.table("activity_labels.txt")
ActivityLabels <- ActivityLabels[2]
names(ActivityLabels) <- "labels"

#Merge Activity numbers with Activity labels
StackedActivity$activity = sapply(StackedActivity$activity, 
                                  function(x) {ActivityLabels$labels[x]}
                                  )

# Combine columns
StackedData <- cbind(StackedData, StackedActivity)

# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
df = StackedData %>%
  group_by(activity, subjects) %>%
  summarise_all(mean)

# write output to wd
write.table(df, file = "tidydataset.txt", row.names = FALSE)

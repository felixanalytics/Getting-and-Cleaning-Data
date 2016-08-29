# 1. Merges the training and the test sets to create one data set.
# setwd("C:/Users/manny/Desktop/Coursera/Getting and Cleaning Data/Peer Graded Assignment")
trainData <- read.table("./train/X_train.txt")
dim(trainData) # [1] 7352  561
head(trainData)
trainLabel <- read.table("./train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./train/subject_train.txt")
testData <- read.table("./test/x_test.txt")
dim(testData) #[1] 2947  561
testLabel <- read.table("./test/y_test.txt")
table(testLabel)
testSubject <- read.table("./test/subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData) #[1] 10299   561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) #[1] 10299     1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) #[1] 10299     1

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./features.txt")
dim(features) #[1] 561   2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) #[1] 66
joinData <- joinData[, meanStdIndices]
dim(joinData) #[1] 10299    66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # Remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # Capitalize "M" in Mean
names(joinData) <- gsub("std", "Std", names(joinData)) # Capitalize "S" in Std
names(joinData) <- gsub("-", "", names(joinData)) # Remove "-" in column names 

# 3. Uses descriptive activity names to name the activities in the data set.
activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) 
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) 
activityLabel <- activity[joinLabel[, 1], 2] 
joinLabel[, 1] <- activityLabel 
names(joinLabel) <- "activity" 



# 4. Appropriately labels the data set with descriptive variable names.
names(joinSubject) <- "subject" 
cleanData <- cbind(joinSubject, joinLabel, joinData) 
dim(cleanData) #[1] 10299    68
write.table(cleanData, "merged_data.txt") # Write first dataset

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) #[1] 30
activityLen <- dim(activity)[1] #[1] 6
columnLen <- dim(cleanData)[2] #[1] 68
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanData)
row <- 1
for(i in 1:subjectLen) { 
        for(j in 1:activityLen) { 
                 result[row, 1] <- sort(unique(joinSubject)[, 1])[i] 
                 result[row, 2] <- activity[j, 2] 
                 bool1 <- i == cleanData$subject 
                 bool2 <- activity[j, 2] == cleanData$activity 
                 result[row, 3:columnLen] <- colMeans(cleanData[bool1&bool2, 3:columnLen]) 
                 row <- row + 1 
             } 
}
head(result)
write.table(result, "data_with_means.txt") # Write second dataset




#
# 1. Merge the training and test sets to create one data set
# Assuming that the dataset has already been downloaded and extracted
# Please check README.md for download details
# Set the working directory; this may change depending on your save location
setwd("~/Documents/R /data/UCI HAR Dataset")

# Read data from the .txt files
features <- read.table("./features.txt", header = FALSE)
activityType <- read.table("./activity_labels.txt", header = FALSE)
subjectTrain <- read.table("./train/subject_train.txt", header = FALSE)
xTrain <- read.table("./train/X_train.txt", header = FALSE)
yTrain <- read.table("./train/y_train.txt", header = FALSE)

# Assigning column names to the data in the tables 
colnames(activityType) <- c("activityId","activityType")
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"

# Creating "trainset", a dataset containing the merged columns of yTrain, subjectTrain and  xTrain
trainSet <- cbind(yTrain,subjectTrain,xTrain)

# Reading data from the test files
subjectTest <- read.table("./test/subject_test.txt")
xTest <- read.table("./test/X_test.txt", header = FALSE)
yTest <- read.table("./test/y_test.txt", header = FALSE)

# Assigning column names to the test data
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

# Creating "testset", a data set containing the merged columns of yTest, subjectTest and xTest
testSet <- cbind(yTest,subjectTest,xTest)

# Combining trainset and testset data to create a final dataset
finalSet <- rbind(trainSet,testSet)

# Create a vector for the column names from finalSet, that can be used to extract the 
# mean and std. deviation
colNames <- colnames(finalSet)

# 2. Extracting only the measurements on the mean and standard deviation on each measurement

# Creating a logical vector that returns TRUE for Id, mean() and stddev() columns and false for all other columns
measurementVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames)
                      & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset the finalSet table based on the measurementVector to keep only required columns
finalSet <- finalSet[measurementVector==TRUE]

# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalSet dataset with the activityType data to provide descriptive names
finalSet <- merge(finalSet,activityType, by="activityId", all.x = TRUE)

# Updating the colNames vector to include the changes made above
colNames <- colnames(finalSet)

# 4. Appropriately label the dataset with descriptive activity names

# Using a for loop to clean up the variable names
for (i in 1:length(colNames)){
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","Freq",colNames[i])
  colNames[i] = gsub("[Gg]ravity","Gravity",colNames[i])
  colNames[i] = gsub("[Bb]ody[Bb]ody|[Bb]ody","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("[Bb]odyaccjerkmag","BodyAccJerkMag",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Reassigning the new descriptive columns to colNames
colnames(finalSet) = colNames

# 5. Create a second, independant tidy data set with the average of each variable for each activity and each subject

# Creating a subset of the finalSet table without the activityType column
finalSetSub <- finalSet[,names(finalSet) != "activityType"]

# Using the aggregate() function to summarize the data by the mean of each variable for each activity and subject
tidySet <- aggregate(finalSetSub[,names(finalSetSub) != c("activityId","subjectId")], by=list(activityId=finalSetSub$activityId,subjectId=finalSetSub$subjectId),mean)

# Merging the activityTypes with tidySet again to provide descriptive names
tidySet <- merge(tidySet,activityType,by="activityId",all.x=TRUE)

# Exporting the tidySet dataset
write.table(tidySet, "./tidyDataset.txt",row.names=TRUE, sep="\t")



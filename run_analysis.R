# cleaning data obtained from data from wearable computing devices

# load packages needed
library("data.table")
library("reshape2")


# assumes data is already unzipped to working directory

# get the working directory
path <- file.path(getwd(), "UCI HAR Dataset")


# read the data files
xTrain <- data.table(read.table(file.path(path, "train", "X_train.txt")))
yTrain <- fread(file.path(path, "train", "y_train.txt"))
subjectTrain <- fread(file.path(path, "train", "subject_train.txt"))

xTest <- data.table(read.table(file.path(path, "test", "X_test.txt")))
yTest <- fread(file.path(path, "test", "y_test.txt"))
subjectTest <- fread(file.path(path, "test", "subject_test.txt"))

# combine training data
training <- cbind(subjectTrain, yTrain, xTrain)

# combine test data
testing <- cbind(subjectTest, yTest, xTest)

# combine training and test data to one set
allData <- rbind(training, testing)
setnames(allData, 1:2, c("subject", "activity"))

# get the column names from the features file
features <- fread(file.path(path, "features.txt"))
setnames(features, 1:2, c("featureID", "featureName"))

## subset features on the mean and standard deviation 
features <- features[grepl("mean\\(\\)|std\\(\\)", features$featureName)]
features <- features[, featureCode:=paste0("V", featureID)]

# subset the mean and standard deviation
allData <- allData[,c("subject", "activity", features$featureCode) , with = FALSE]

# use descriptive activity names to name the activities in the data set
activities <- fread(file.path(path, "activity_labels.txt"))
setnames(activities, 1:2, c("activity", "activityName"))

allData <- merge(activities, allData, by = "activity", all = TRUE)
allData <- allData[, activity:=subject]
allData <- allData[, subject:=NULL]
setnames(allData, 1:2, c("subject", "activity"))


# Appropriately label the data set with descriptive variable names
# using the feature file as a source
descriptiveNames <- features$featureName
setnames(allData, 3:68, descriptiveNames)

# create independent tidy data set

# melt the feature vector into one variable to make the 
# data set in the long form rather than the wide form
setkey(allData, subject, activity)
allData <- melt(allData, key(allData), variable.name = "feature")

# split the feature variable into multiple variables
f <- allData$feature
allData$domain <- ifelse(grepl("^t", f), "Time", 
                            ifelse(grepl("^f", f), "Freq", NA))
allData$instrument <- ifelse(grepl("Acc", f, ignore.case=TRUE), 
                              "Accelerometer",
                              ifelse(grepl("Gyro", f, ignore.case=TRUE), 
                                  "Gyroscope", NA))
allData$acceleration <- ifelse(grepl("Body", f, ignore.case=TRUE), "Body",
                              ifelse(grepl("Gravity", f, 
                                  ignore.case=TRUE), "Gravity", NA)) 
allData$jerk <- ifelse(grepl("Jerk", f, ignore.case=TRUE), "Jerk", NA)
allData$magnitude <- ifelse(grepl("Mag", f, ignore.case=TRUE), 
                              "Magnitude", NA)    
allData$axis <- ifelse(grepl("X$", f), "X", 
                          ifelse(grepl("Y$", f), "Y", 
                                 ifelse(grepl("Z$", f), "Z", NA)))
allData$statistics <- ifelse(grepl("mean", f), "Mean",
                                ifelse(grepl("std", f), 
                                       "Standard Deviation", NA))

# move the value variable to the end
setcolorder(allData, c(1:3, 5:11, 4))

# remove the feature variable as it is no longer needed
allData <- allData[, feature := NULL]

# create an independent tidy data set with the average of each
# variable for each subject/activity

# get the average of the measurements and the count of measurements
setkey(allData, subject, activity, domain, instrument, acceleration, jerk, 
       magnitude, axis, statistics)
tidyData <- allData[, list(measurements = .N, average = mean(value)), 
                    by = key(allData)]

# write the data to a text file
write.table(tidyData, "tidy_data.txt", row.names = FALSE)




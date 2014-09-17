
## Get data
## Measurements
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
xall <- rbind(xtrain,xtest)

## Activities
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
yall <- rbind(ytrain,ytest)
## Replacing numbers with activity labels
newyall <- data.frame(labels$V2[match(yall$V1,labels$V1)])
colnames(newyall) <- "activity"

## Subjects
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subjecttrain,subjecttest)
colnames(subject) <- "subject"

## Free unused space
xtrain <- NULL
xtest <- NULL

## Get columns names
features <- read.table("UCI HAR Dataset/features.txt")
interstingfeatures1 <- grep("mean\\(", features$V2)
interstingfeatures2 <- grep("std\\(", features$V2)
interestingfeatures <- c(interstingfeatures1,interstingfeatures2)

## Interesting names (not neccessery)
## itnames <- subset(features, features$V1 %in% interestingfeatures)

## Free unused space
interstingfeatures1 <- NULL
interstingfeatures2 <- NULL

## Naming columns in dataframe
colnames(xall) <- features$V2

## Extracting desired columns to the new dataframe
xextract <- xall[interestingfeatures]

## Adding activities to data frame
newxall <- cbind(newyall, xextract)

## Adding subject to data frame
newxallwithsubject <- cbind(subject, newxall)

## Final tidy dataframe
activity_labels <- data.table(newxallwithsubject)
act_lab <- activity_labels[, lapply(.SD, mean), by = c("activity","subject")]
write.table(act_lab, file = "activity_average.txt",row.names=FALSE)

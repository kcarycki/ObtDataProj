
## Get data measurements

The data is obtained from:


Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

Descriptions of variables, subjects and activities are in files from dataset:
features.txt
activity_labels.txt
features_info.txt

Some informations are included in README.txt from dataset.



```r
library(data.table)
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
xall <- rbind(xtrain,xtest)
```

## Get activities


```r
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
yall <- rbind(ytrain,ytest)
```

## Replace numbers with activity labels


```r
newyall <- data.frame(labels$V2[match(yall$V1,labels$V1)])
colnames(newyall) <- "activity"
```

## Get subjects


```r
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subjecttrain,subjecttest)
colnames(subject) <- "subject"
```

## Free unused space


```r
xtrain <- NULL
xtest <- NULL
```

## Get columns names


```r
features <- read.table("UCI HAR Dataset/features.txt")
interstingfeatures1 <- grep("mean\\(", features$V2)
interstingfeatures2 <- grep("std\\(", features$V2)
interestingfeatures <- c(interstingfeatures1,interstingfeatures2)
```

Descriptive variable names extracted from dataset and used in project


```r
itnames <- subset(features, features$V1 %in% interestingfeatures)
itnames
```

```
##      V1                          V2
## 1     1           tBodyAcc-mean()-X
## 2     2           tBodyAcc-mean()-Y
## 3     3           tBodyAcc-mean()-Z
## 4     4            tBodyAcc-std()-X
## 5     5            tBodyAcc-std()-Y
## 6     6            tBodyAcc-std()-Z
## 41   41        tGravityAcc-mean()-X
## 42   42        tGravityAcc-mean()-Y
## 43   43        tGravityAcc-mean()-Z
## 44   44         tGravityAcc-std()-X
## 45   45         tGravityAcc-std()-Y
## 46   46         tGravityAcc-std()-Z
## 81   81       tBodyAccJerk-mean()-X
## 82   82       tBodyAccJerk-mean()-Y
## 83   83       tBodyAccJerk-mean()-Z
## 84   84        tBodyAccJerk-std()-X
## 85   85        tBodyAccJerk-std()-Y
## 86   86        tBodyAccJerk-std()-Z
## 121 121          tBodyGyro-mean()-X
## 122 122          tBodyGyro-mean()-Y
## 123 123          tBodyGyro-mean()-Z
## 124 124           tBodyGyro-std()-X
## 125 125           tBodyGyro-std()-Y
## 126 126           tBodyGyro-std()-Z
## 161 161      tBodyGyroJerk-mean()-X
## 162 162      tBodyGyroJerk-mean()-Y
## 163 163      tBodyGyroJerk-mean()-Z
## 164 164       tBodyGyroJerk-std()-X
## 165 165       tBodyGyroJerk-std()-Y
## 166 166       tBodyGyroJerk-std()-Z
## 201 201          tBodyAccMag-mean()
## 202 202           tBodyAccMag-std()
## 214 214       tGravityAccMag-mean()
## 215 215        tGravityAccMag-std()
## 227 227      tBodyAccJerkMag-mean()
## 228 228       tBodyAccJerkMag-std()
## 240 240         tBodyGyroMag-mean()
## 241 241          tBodyGyroMag-std()
## 253 253     tBodyGyroJerkMag-mean()
## 254 254      tBodyGyroJerkMag-std()
## 266 266           fBodyAcc-mean()-X
## 267 267           fBodyAcc-mean()-Y
## 268 268           fBodyAcc-mean()-Z
## 269 269            fBodyAcc-std()-X
## 270 270            fBodyAcc-std()-Y
## 271 271            fBodyAcc-std()-Z
## 345 345       fBodyAccJerk-mean()-X
## 346 346       fBodyAccJerk-mean()-Y
## 347 347       fBodyAccJerk-mean()-Z
## 348 348        fBodyAccJerk-std()-X
## 349 349        fBodyAccJerk-std()-Y
## 350 350        fBodyAccJerk-std()-Z
## 424 424          fBodyGyro-mean()-X
## 425 425          fBodyGyro-mean()-Y
## 426 426          fBodyGyro-mean()-Z
## 427 427           fBodyGyro-std()-X
## 428 428           fBodyGyro-std()-Y
## 429 429           fBodyGyro-std()-Z
## 503 503          fBodyAccMag-mean()
## 504 504           fBodyAccMag-std()
## 516 516  fBodyBodyAccJerkMag-mean()
## 517 517   fBodyBodyAccJerkMag-std()
## 529 529     fBodyBodyGyroMag-mean()
## 530 530      fBodyBodyGyroMag-std()
## 542 542 fBodyBodyGyroJerkMag-mean()
## 543 543  fBodyBodyGyroJerkMag-std()
```


## Free unused space


```r
interstingfeatures1 <- NULL
interstingfeatures2 <- NULL
```

## Naming columns in dataframe


```r
colnames(xall) <- features$V2
```


## Extracting desired columns to the new dataframe


```r
xextract <- xall[interestingfeatures]
```

## Adding activities to data frame


```r
newxall <- cbind(newyall, xextract)
```

## Adding subject to data frame


```r
newxallwithsubject <- cbind(subject, newxall)
```

## Final tidy dataframe


```r
activity_labels <- data.table(newxallwithsubject)
act_lab <- activity_labels[, lapply(.SD, mean), by = c("activity","subject")]
```


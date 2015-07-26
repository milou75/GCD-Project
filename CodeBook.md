**============================================================**

**Code Book - Coursera - Getting and Cleaning Data - Course Project**

**===========================================================**

This Code Book is organized with 3 sections:

- 1) Output Data Set Overview
- 2) Input Measurements data and dataset
- 3) Output Data Set Details

# 1) Output Data Set Overview

File : Final_DS_Summary.txt

Overall Structure : 180 rows with 68 columns.

Each of the 180 rows provides features information associated with a (Subject, Activity) pair. There are (only) 6 activities for each of the 30 subjects.

For each row (i.e., a subject-activity pair as defined by columns #1 and #2), columns #3 to #68 contain mean values of all the measurements of the individual (66) features for the given  subject-activity pair.

See below information about the input measurement data and then details about the output dataset.

# 2) Input Measurement Data and Dataset

Original measurement data were provided as input to the project.  (561 variables, 10299 observations split in two sets : test and train). 

Data were output from an accelerometer and gyroscope embedded in a Samsung smartphone. All values were pre-processed and are numeric within [-1,1] range.

The README.txt and features_info.txt provided with the original dataset (under UCI HAR Dataset directory) fully define the different variables. Please refer to those files for more details about the input data.

Only mean and standard deviation related features were extracted from the project input data (observations of 66 variables for 10299 subject-activity). For reference, below is a list of Features selected for the project and their column position in the original dataset  : 

- 1             tBodyAcc-mean()-X
- 2             tBodyAcc-mean()-Y
- 3             tBodyAcc-mean()-Z
- 4              tBodyAcc-std()-X
- 5              tBodyAcc-std()-Y
- 6              tBodyAcc-std()-Z
- 41         tGravityAcc-mean()-X
- 42         tGravityAcc-mean()-Y
- 43         tGravityAcc-mean()-Z
- 44          tGravityAcc-std()-X
- 45          tGravityAcc-std()-Y
- 46          tGravityAcc-std()-Z
- 81        tBodyAccJerk-mean()-X
- 82        tBodyAccJerk-mean()-Y
- 83        tBodyAccJerk-mean()-Z
- 84         tBodyAccJerk-std()-X
- 85         tBodyAccJerk-std()-Y
- 86         tBodyAccJerk-std()-Z
- 121          tBodyGyro-mean()-X
- 122          tBodyGyro-mean()-Y
- 123          tBodyGyro-mean()-Z
- 124           tBodyGyro-std()-X
- 125           tBodyGyro-std()-Y
- 126           tBodyGyro-std()-Z
- 161      tBodyGyroJerk-mean()-X
- 162      tBodyGyroJerk-mean()-Y
- 163      tBodyGyroJerk-mean()-Z
- 164       tBodyGyroJerk-std()-X
- 165       tBodyGyroJerk-std()-Y
- 166       tBodyGyroJerk-std()-Z
- 201          tBodyAccMag-mean()
- 202           tBodyAccMag-std()
- 214       tGravityAccMag-mean()
- 215        tGravityAccMag-std()
- 227      tBodyAccJerkMag-mean()
- 228       tBodyAccJerkMag-std()
- 240         tBodyGyroMag-mean()
- 241          tBodyGyroMag-std()
- 253     tBodyGyroJerkMag-mean()
- 254      tBodyGyroJerkMag-std()
- 266           fBodyAcc-mean()-X
- 267           fBodyAcc-mean()-Y
- 268           fBodyAcc-mean()-Z
- 269            fBodyAcc-std()-X
- 270            fBodyAcc-std()-Y
- 271            fBodyAcc-std()-Z
- 345       fBodyAccJerk-mean()-X
- 346       fBodyAccJerk-mean()-Y
- 347       fBodyAccJerk-mean()-Z
- 348        fBodyAccJerk-std()-X
- 349        fBodyAccJerk-std()-Y
- 350        fBodyAccJerk-std()-Z
- 424          fBodyGyro-mean()-X
- 425          fBodyGyro-mean()-Y
- 426          fBodyGyro-mean()-Z
- 427           fBodyGyro-std()-X
- 428           fBodyGyro-std()-Y
- 429           fBodyGyro-std()-Z
- 503          fBodyAccMag-mean()
- 504           fBodyAccMag-std()
- 516  fBodyBodyAccJerkMag-mean()
- 517   fBodyBodyAccJerkMag-std()
- 529     fBodyBodyGyroMag-mean()
- 530      fBodyBodyGyroMag-std()
- 542 fBodyBodyGyroJerkMag-mean()
- 543  fBodyBodyGyroJerkMag-std()

# 3) Output Data Set Details
 
Structure : Column id / Column Label / Data Type / Values or Values Range / Comment

1 / Subject / numeric / 1..30 /
subject_id for each of the 30 individuals taking part in the experiment.

2 / Activity / character string / WALKING, WALKING_UPSTAIRS,  WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING /
Reflects the (only) 6 activities performed by the subjects during the experiments (video recorded during experiments)

3 to 68 / cf. Feature List below with column position / numeric / [-1,1] /
For each from the Feature List below (col #3 to #68) the value reflect the mean value of the feature when subject #i (i in 1..30) was performing one of the 6 activities. Native experiment results were provided in the input dataset (10299 observations in total).

- 3            Mean - tBodyAcc-mean()-X
- 4            Mean - tBodyAcc-mean()-Y
- 5            Mean - tBodyAcc-mean()-Z
- 6             Mean - tBodyAcc-std()-X
- 7             Mean - tBodyAcc-std()-Y
- 8             Mean - tBodyAcc-std()-Z
- 9         Mean - tGravityAcc-mean()-X
- 10        Mean - tGravityAcc-mean()-Y
- 11        Mean - tGravityAcc-mean()-Z
- 12         Mean - tGravityAcc-std()-X
- 13         Mean - tGravityAcc-std()-Y
- 14         Mean - tGravityAcc-std()-Z
- 15       Mean - tBodyAccJerk-mean()-X
- 16       Mean - tBodyAccJerk-mean()-Y
- 17       Mean - tBodyAccJerk-mean()-Z
- 18        Mean - tBodyAccJerk-std()-X
- 19        Mean - tBodyAccJerk-std()-Y
- 20        Mean - tBodyAccJerk-std()-Z
- 21          Mean - tBodyGyro-mean()-X
- 22          Mean - tBodyGyro-mean()-Y
- 23          Mean - tBodyGyro-mean()-Z
- 24           Mean - tBodyGyro-std()-X
- 25           Mean - tBodyGyro-std()-Y
- 26           Mean - tBodyGyro-std()-Z
- 27      Mean - tBodyGyroJerk-mean()-X
- 28      Mean - tBodyGyroJerk-mean()-Y
- 29      Mean - tBodyGyroJerk-mean()-Z
- 30       Mean - tBodyGyroJerk-std()-X
- 31       Mean - tBodyGyroJerk-std()-Y
- 32       Mean - tBodyGyroJerk-std()-Z
- 33          Mean - tBodyAccMag-mean()
- 34           Mean - tBodyAccMag-std()
- 35       Mean - tGravityAccMag-mean()
- 36        Mean - tGravityAccMag-std()
- 37      Mean - tBodyAccJerkMag-mean()
- 38       Mean - tBodyAccJerkMag-std()
- 39         Mean - tBodyGyroMag-mean()
- 40          Mean - tBodyGyroMag-std()
- 41     Mean - tBodyGyroJerkMag-mean()
- 42      Mean - tBodyGyroJerkMag-std()
- 43           Mean - fBodyAcc-mean()-X
- 44           Mean - fBodyAcc-mean()-Y
- 45           Mean - fBodyAcc-mean()-Z
- 46            Mean - fBodyAcc-std()-X
- 47            Mean - fBodyAcc-std()-Y
- 48            Mean - fBodyAcc-std()-Z
- 49       Mean - fBodyAccJerk-mean()-X
- 50       Mean - fBodyAccJerk-mean()-Y
- 51       Mean - fBodyAccJerk-mean()-Z
- 52        Mean - fBodyAccJerk-std()-X
- 53        Mean - fBodyAccJerk-std()-Y
- 54        Mean - fBodyAccJerk-std()-Z
- 55          Mean - fBodyGyro-mean()-X
- 56          Mean - fBodyGyro-mean()-Y
- 57          Mean - fBodyGyro-mean()-Z
- 58           Mean - fBodyGyro-std()-X
- 59           Mean - fBodyGyro-std()-Y
- 60           Mean - fBodyGyro-std()-Z
- 61          Mean - fBodyAccMag-mean()
- 62           Mean - fBodyAccMag-std()
- 63  Mean - fBodyBodyAccJerkMag-mean()
- 64   Mean - fBodyBodyAccJerkMag-std()
- 65     Mean - fBodyBodyGyroMag-mean()
- 66      Mean - fBodyBodyGyroMag-std()
- 67 Mean - fBodyBodyGyroJerkMag-mean()
- 68  Mean - fBodyBodyGyroJerkMag-std() 
     








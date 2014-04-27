The Tidy Data is generated from the UCI HAR DATASET 


The original data was collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


Here are the data provided by the instructor to work on for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset includes several files but we will work only on the following files:

1. './features.txt'           : List of all features (variable names).
2. './activity_labels.txt'    : Links the class labels with their activity name.

3. './train/X_train.txt'      : Training set.
4. './train/y_train.txt'      : Training labels (activity IDs).
5. './train/subject_train.txt': Training subject labels (IDs).

6. './test/X_test.txt'        : Test set.
7. './test/y_test.txt'        : Test labels (activity IDs).
8. './test/subject_test.txt'  : Test subject labels (IDs).

You must downloded those files into the working directory withn the same hirearchal structure.

The major steps to generate the tidy data are:

step 1. Invoke the function 'checkfiles' to verify the existance of 8 working files 

step 2. Invoke the function 'get_mean_std' to extract the mean and standard deviation 
        measurments from the merged dataset of both training ang test data, we obtain
        (10299 observations x 561 features). 
        During that, The functions 'read_data' and 'read_names. will be invoked to
        read the training and test data the merge them and to read the featues names
        and labels the extracted data set of means `mean()` and standard deviation 
        `std()`. We have used a regular expression patern to select features where 
        their names includes mean() or std(). We ignore features with names containing           
        meanFreq regarding to their description in the "featrues_info.txt" file. 
        We obtain a dataset of 10299 observations x 66 featues (mean() | std()

step 3. Invoke the function 'get_tidy' that works on the extracted mean and standrad 
        deviation features (result of step 2.) to calculate the average of each 
        variable for each activity and each subject.
        We have used the function 'split' to split the mean and std dataset according 
        to the activity labels the the subject labels, We then used the functions 
        'sapply' and 'colMeans' to calculate the mean of each activity and subject 
        group combination (180 (activity, subject) x 66 (mean | std featues)). 
        The result of sapply is a matrix with features in rows and activity+subject
        in columns, as we need to include activity and subject labels within the 
        matrix which will coerce the measurement values to the 'character' data type. 
        Therefore we decided to tronspose the matrix( swap row and columns) the add
        activity and subject labels in front of tidy data columns and converting it
        to a data frame.
        During that, We have used the function 'read_names' to get the activity names
        and use them instead of activity labels to have more descriptive data.

step 4. Save the calculated tidy data into the working directory in the text file
        'tidy_data.txt'

The result is the tidy data which is a data frame as follow:
column  1    : contains the activity names,
column  2    : contains the subject labels,
columns 3:68 :contain the averages for the 66 mean and standard deviation features. 


## Feature Description
======================

The features selected for this database come from the accelerometer and gyroscope 3-axial 
raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) 
were captured at a constant rate of 50 Hz. Then they were filtered using a median filter 
and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove 
noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth 
filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean
 norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, 
fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
Naming abreviations:
- prefix 't'  : Time)
- prefix 'f'  : Frequency domain signals)
- 'BodyAcc'   : Body gravity acceleration signals
- 'GravityAcc': Gravity acceleration signals
- 'Jerk'      : Application of the Jerk signals
- 'Mag'       : Euclidean norm magnitude of these three-dimensional signals
- 'Gyro'      : gyroscope signals
- 'mean()'    : it is a mean value
- 'mean()'    : it is a standard deviation value

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation









DATA DICTIONARY
===============

## Activities:

   Activicty code | Activity name
   -----------------------------------------
         1       |  WALKING

         2       |  WALKING_UPSTAIRS

         3       |  WALKING_DOWNSTAIRS

         4       |  SITTING

         5       |  STANDING

         6       |  LAYING



## Subjects:

   Subject Labels from 1 to 30


## Features Variables:

   Feature Code  | Feature Name
   -----------------------------------------
         1       |  tBodyAcc-mean()-X
         2       |  tBodyAcc-mean()-Y
         3       |  tBodyAcc-mean()-Z
         4       |  tBodyAcc-std()-X
         5       |  tBodyAcc-std()-Y
         6       |  tBodyAcc-std()-Z
         7       |  tGravityAcc-mean()-X
         8       |  tGravityAcc-mean()-Y
         9       |  tGravityAcc-mean()-Z
        10       |  tGravityAcc-std()-X
        11       |  tGravityAcc-std()-Y
        12       |  tGravityAcc-std()-Z
        13       |  tBodyAccJerk-mean()-X
        14       |  tBodyAccJerk-mean()-Y
        15       |  tBodyAccJerk-mean()-Z
        16       |  tBodyAccJerk-std()-X
        17       |  tBodyAccJerk-std()-Y
        18       |  tBodyAccJerk-std()-Z
        19       |  tBodyGyro-mean()-X
        20       |  tBodyGyro-mean()-Y
        21       |  tBodyGyro-mean()-Z
        22       |  tBodyGyro-std()-X
        23       |  tBodyGyro-std()-Y
        24       |  tBodyGyro-std()-Z
        25       |  tBodyGyroJerk-mean()-X
        26       |  tBodyGyroJerk-mean()-Y
        27       |  tBodyGyroJerk-mean()-Z
        28       |  tBodyGyroJerk-std()-X
        29       |  tBodyGyroJerk-std()-Y
        30       |  tBodyGyroJerk-std()-Z
        31       |  tBodyAccMag-mean()
        32       |  tBodyAccMag-std()
        33       |  tGravityAccMag-mean()
        34       |  tGravityAccMag-std()
        35       |  tBodyAccJerkMag-mean()
        36       |  tBodyAccJerkMag-std()
        37       |  tBodyGyroMag-mean()
        38       |  tBodyGyroMag-std()
        39       |  tBodyGyroJerkMag-mean()
        40       |  tBodyGyroJerkMag-std()
        41       |  fBodyAcc-mean()-X
        42       |  fBodyAcc-mean()-Y
        43       |  fBodyAcc-mean()-Z
        44       |  fBodyAcc-std()-X
        45       |  fBodyAcc-std()-Y
        46       |  fBodyAcc-std()-Z
        47       |  fBodyAccJerk-mean()-X
        48       |  fBodyAccJerk-mean()-Y
        49       |  fBodyAccJerk-mean()-Z
        50       |  fBodyAccJerk-std()-X
        51       |  fBodyAccJerk-std()-Y
        52       |  fBodyAccJerk-std()-Z
        53       |  fBodyGyro-mean()-X
        54       |  fBodyGyro-mean()-Y
        55       |  fBodyGyro-mean()-Z
        56       |  fBodyGyro-std()-X
        57       |  fBodyGyro-std()-Y
        58       |  fBodyGyro-std()-Z
        59       |  fBodyAccMag-mean()
        60       |  fBodyAccMag-std()
        61       |  fBodyBodyAccJerkMag-mean()
        62       |  fBodyBodyAccJerkMag-std()
        63       |  fBodyBodyGyroMag-mean()
        64       |  fBodyBodyGyroMag-std()
        65       |  fBodyBodyGyroJerkMag-mean()
        66       |  fBodyBodyGyroJerkMag-std()
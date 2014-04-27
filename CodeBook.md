## The Tidy Data is generated from the UCI HAR DATASET
--------------------------------------------------------

<p>The original data was collected from the accelerometers from the Samsung Galaxy
S Smartphone. A full description is available at the site where the data was
obtained: 
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">Human activity recognition using Smartphone</a> </p>
 
<p>Here are the data provided by the instructor to work on for the project: 
<a href="https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions"> The data project files</a></p>

<p>The dataset includes several files but we will work only on the following files:</p>

<ol>
<li>`./features.txt`           : List of all features (variable names).</li>
<li>`./activity_labels.txt`    : Links the class labels with their activity name.</li>
<li>`./train/X_train.txt`      : Training set.</li>
<li>`./train/y_train.txt`      : Training labels (activity IDs).</li>
<li>`./train/subject_train.txt`: Training subject labels (IDs).</li>
<li>`./test/X_test.txt`        : Test set.</li>
<li>`./test/y_test.txt`        : Test labels (activity IDs).</li>
<li>`./test/subject_test.txt`  : Test subject labels (IDs).</li>
</ol>
<p>You must download those files into the working directory within the same hierarchal structure.</p>

<h2> The major steps to generate the tidy data are:</h2>

<p><strong> step 1.</strong> Invoke the function `checkfiles` to verify the existence of 8 working files </p>

<p><strong> step 2.</strong> Invoke the function `get_mean_std` to extract the mean and standard deviation measurements from the merged dataset of both training and test data, we obtain (`10299 observations x 561 features`). </p>
<p>During that, the functions `read_data` and `read_names`. will be invoked to read the training and test data the merge them and to read the features names and labels the extracted data set of means `mean()` and standard deviation `std()`. We have used a regular expression pattern to select features where their names includes `mean()` or `std()`. We ignore features with names containing meanFreq regarding to their description in the `featrues_info.txt` file. </p>
<p>We obtain a dataset of `10299 observations x 66 features` (`mean()` | `std()`)</p>

<p><strong> step 3.</strong> Invoke the function 'get_tidy' that works on the extracted mean and standard deviation features (result of `step 2`) to calculate the average of each variable for each activity and each subject. 
We have used the function 'split' to split the mean and std dataset according to the activity labels the the subject labels, We then used the functions 'sapply' and 'colMeans' to calculate the mean of each activity and subject group combinations which gives a matrix of (180 (activity, subject) x 66 (mean | std features)). 
The result of `sapply` is a `matrix` with features in rows and activity subject in columns, as we need to include activity and subject labels within the matrix which will coerce the measurement values to the `character` data type. Therefore we decided to `transpose` the matrix (swapping rows and columns) the add activity and subject labels in front of tidy data columns and converting into a data frame.
During that, we have used the function `read_names` to get the activity names and use them instead of activity labels to have more descriptive data.</p>

<p><strong> step 4.</strong> Save the calculated tidy data into the working directory in the text file 'tidy_data.txt'</p>

<p> <strong>The result is the tidy data which is a data frame as follow:</strong></p>
<p>   column  1    : contains the activity names,</p>
<p>   column  2    : contains the subject labels,</p>
<p>   columns 3:68 : contain the averages for the 66 mean and standard deviation features. </p>

## Feature Description
----------------------
<p>The features selected for this database come from the `accelerometer` and
`gyroscope` 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals
(prefix `t` to denote `time`) were captured at a constant rate of 50 Hz. Then
they were filtered using a median filter and a 3rd order low pass Butterworth
filter with a corner frequency of 20 Hz to remove noise. Similarly, the
acceleration signal was then separated into `body and gravity acceleration
signals` (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth 
filter with a corner frequency of 0.3 Hz. </p>

<p>Subsequently, the body linear acceleration and angular velocity were derived in
time to obtain `Jerk signals` (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the
`magnitude` of these three-dimensional signals were calculated using the `Euclidean
norm` (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, 
tBodyGyroJerkMag).</p> 

<p>Finally a Fast Fourier Transform (FFT) was applied to some of these signals
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
fBodyGyroMag, fBodyGyroJerkMag. (Note the `f` to indicate frequency domain
signals). </p>

<p>These signals were used to estimate variables of the feature vector for each
pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.</p>

<p>Naming convention:</p>
<ul>
<li>- prefix `t`  : Time)</li>
<li>- prefix `f`  : Frequency domain signals)</li>
<li>- `BodyAcc`   : Body gravity acceleration signals</li>
<li>- `GravityAcc`: Gravity acceleration signals</li>
<li>- `Jerk`      : Application of the Jerk signals</li>
<li>- `Mag`       : Euclidean norm magnitude of these three-dimensional signals</li>
<li>- `Gyro`      : gyroscope signals</li>
<li>- `mean()`    : it is a mean value</li>
<li>- `mean()`    : it is a standard deviation value</li>
</ul>

<p>tBodyAcc-XYZ </p>
<p>tGravityAcc-XYZ </p>
<p>tBodyAccJerk-XYZ </p>
<p>tBodyGyro-XYZ </p>
<p>tBodyGyroJerk-XYZ </p>
<p>tBodyAccMag </p>
<p>tGravityAccMag </p>
<p>tBodyAccJerkMag </p>
<p>tBodyGyroMag </p>
<p>tBodyGyroJerkMag </p>
<p>fBodyAcc-XYZ </p>
<p>fBodyAccJerk-XYZ </p>
<p>fBodyGyro-XYZ </p>
<p>fBodyAccMag </p>
<p>fBodyAccJerkMag </p>
<p>fBodyGyroMag </p>
<p>fBodyGyroJerkMag </p>

<p>The set of variables that were estimated from these signals are: </p>
<p>`mean()`: Mean value</p>
<p>`std()`: Standard deviation</p>


## DATA DICTIONARY
------------------

## Activities:
   Activity labels are from `1` to `6`
   
   Activicty code | Activity name
   -----------------------------------------
         1        |  WALKING
         2        |  WALKING_UPSTAIRS
         3        |  WALKING_DOWNSTAIRS
         4        |  SITTING
         5        |  STANDING
         6        |  LAYING


## Subjects:

   Subject Labels from `1` to `30`


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
## Preparing the dataset and script:

<p>Clone this repository tidy_data in the working directory by doing:</p>

<strong> <p>`git clone https://github.com/kkhalil/tidy_data.git`</p> </strong>

<p>Normally, we will have the R script file `run_analysis.R` and others working files.</p>

<p>Change your working directory to the `tidy_data` directory which must contain run_analysis.R and the following 8 text files:</p>

<ol>
<li><strong>`./features.txt`</strong> : List of all features (variable names).</li>
<li><strong>`./activity_labels.txt`</strong> : Links the class labels with their activity name.</li>
<li><strong>`./train/X_train.txt`</strong> : Training set.</li>
<li><strong>`./train/y_train.txt`</strong> : Training labels (activity IDs).</li>
<li><strong>`./train/subject_train.txt`</strong>: Training subject labels (IDs).</li>
<li><strong>`./test/X_test.txt`</strong> : Test set.</li>
<li><strong>`./test/y_test.txt`</strong> : Test labels (activity IDs).</li>
<li><strong>`./test/subject_test.txt`</strong> : Test subject labels (IDs).</li>
</ol>

<p>Verify the existence of those file within the specified structure.</p>

<p>If one of those files does not exist, download the dataset provided by the instructor from: 
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">Human activity recognition using Smartphone</a>
and then extract it into a directory that you use as a working directory. After that, copy the file `run_analysis.R` into this directory.</p>
 
<strong>Note:</strong> Be sure that your working directory contains the run_analysis.R file and the other 8 data files.

## Run the script:

<p>Run Rscript `<working-directory>/run_analysis.R` or open the file `run_analysis.R` with `RStudio` and chande the working directory, then source the file and invoke the function `create_tidy_data()` which will return the 
`tidy_data` or `NULL` if any of the 8 data file does not exist.

<p>The tidy dataset should be created in the working directory as a text file named `tidy_data.txt`</p>

## The major steps to generate the tidy data are:

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
<p> <strong>column 1 </strong> : contains the activity names,</p>
<p> <strong>column 2 </strong> : contains the subject labels,</p>
<p> <strong>columns 3:68</strong> : contain the averages for the 66 mean and standard deviation features. </p>

<strong><p>Please look at the `CodeBook.md` file for more information on features and dataset.</p>
<p>Please look at the script `run_analysis.R` for more explanation about the script.</p></strong>

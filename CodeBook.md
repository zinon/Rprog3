Codebook
========

### Data Processing 

A description of all transformation steps is given below. Data are processed by the `run_analysis.R` code, which is also responsible to create an new tidy dataset.

1. For each of the training and test datasets found in the corresponding subdirectories, do the following 
   a. Read the feature names from the `features.txt` file (cached data are used if necessary)
   b. Read the `X` values (aka 'set') and subset according to the interesting variables. These are columns the representing only the mean and standard deviation values.
   c. Attached the result to the `combinedData` in the `getDataset` function
   d. Associate additional columns to represent activity ID's. Then subject IDs reading from `y_<dataset>.txt` (aka `lables`) and `subject_<dataset>.txt` (aka `subjects`)files respectively.
   e. Bind the result to the `combinedData` and return to the call function.
   f. Read the `activity_labels.txt`:
   
   `1 WALKING
   2 WALKING_UPSTAIRS
   3 WALKING_DOWNSTAIRS
   4 SITTING
   5 STANDING
   6 LAYING`
   and associate an additional column with descriptive activity names as specified in that file.
   g. Return the resulting `combinedData`

2. Merge the training and the test sets using the `getMergedData` function to create one data set.

3. Now, we want to convert data from a wide format to a long format. Many functions in R expect data to be in a long format rather than a wide format. We thus use the 'reshape2' package which provides two major methods, the `melt()` and `dcast()` (for data-frames). A good instructive reference is: http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/ .

4. Melt the dataset by specifying the *Subject* and *Activity* names as the only identification variables.

5. Use the result from the melting process to recast with the *Activity* name and *Subject* as the only IDs. The `mean` is preferred as the aggregator function.

6. The re-casted dataset `processedData` can be used for further analysis.

7. Save the result as `processedData.txt` in the current working directory.


### Data Source

- [Original data source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- [Original data description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Variables

The data for this data set was derived from sources mentioned in the "Original data" section of this document. 
Part of the description below has been taken from the original data description.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are:
- mean: Mean value
- std: Standard deviation
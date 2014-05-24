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
   g. Return the resulting `combinedData`.

2. Merge the training and the test sets using the `getMergedData` function to create one data set.

3. Now, we want to convert data from a wide format to a long format. Many functions in R expect data to be in a long format rather than a wide format. We thus use the 'reshape2' package which provides two major methods, the `melt()` and `dcast()` (for data-frames). A good instructive reference is: http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/ .

4. Melt the dataset by specifying the *Subject* and *Activity* names as the only identification variables.

5. Use the result from the melting process to recast with the *Activity* name and *Subject* as the only IDs. The `mean` is preferred as the aggregator function.

6. The re-casted dataset `processedData` can be used for further analysis.

7. Save the result as `processedData.txt` in the current working directory.


### Data Source

One of the most exciting areas in all of data science right now is wearable computing.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website and also below, represent data collected from the accelerometers 
from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

- [Original data source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- [Original data description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Variables Meaning

The "Data Source" section above describes the origin from which the data set was derived. Part of the description below has been taken from the original data description.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals *tAcc-XYZ* and *tGyro-XYZ*. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (*tBodyAcc-XYZ* and *tGravityAcc-XYZ*) using another 
low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (*tBodyAccJerk-XYZ* and *tBodyGyroJerk-XYZ*).
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (*tBodyAccMag*, *tGravityAccMag*, *tBodyAccJerkMag*, 
*tBodyGyroMag8, *tBodyGyroJerkMag*).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing *fBodyAcc-XYZ*, *fBodyAccJerk-XYZ*, *fBodyGyro-XYZ*, *fBodyAccJerkMag*, *fBodyGyroMag*, *fBodyGyroJerkMag*. Note the 'f' to indicate frequency domain signals.

These signals were used to estimate variables of the feature vector for each pattern: *-XYZ8 is used to denote 3-axial signals in the *X*, *Y* and *Z* 
directions.

The set of variables that were estimated from the signals mentioned before are:
- The mean value `...-mean()-..`
- The standard deviation `...-std()-..`


### Variables Used

List of variables used:
```
     V1                          V2
1     1           tBodyAcc-mean()-X
2     2           tBodyAcc-mean()-Y
3     3           tBodyAcc-mean()-Z
4     4            tBodyAcc-std()-X
5     5            tBodyAcc-std()-Y
6     6            tBodyAcc-std()-Z
41   41        tGravityAcc-mean()-X
42   42        tGravityAcc-mean()-Y
43   43        tGravityAcc-mean()-Z
44   44         tGravityAcc-std()-X
45   45         tGravityAcc-std()-Y
46   46         tGravityAcc-std()-Z
81   81       tBodyAccJerk-mean()-X
82   82       tBodyAccJerk-mean()-Y
83   83       tBodyAccJerk-mean()-Z
84   84        tBodyAccJerk-std()-X
85   85        tBodyAccJerk-std()-Y
86   86        tBodyAccJerk-std()-Z
121 121          tBodyGyro-mean()-X
122 122          tBodyGyro-mean()-Y
123 123          tBodyGyro-mean()-Z
124 124           tBodyGyro-std()-X
125 125           tBodyGyro-std()-Y
126 126           tBodyGyro-std()-Z
161 161      tBodyGyroJerk-mean()-X
162 162      tBodyGyroJerk-mean()-Y
163 163      tBodyGyroJerk-mean()-Z
164 164       tBodyGyroJerk-std()-X
165 165       tBodyGyroJerk-std()-Y
166 166       tBodyGyroJerk-std()-Z
201 201          tBodyAccMag-mean()
202 202           tBodyAccMag-std()
214 214       tGravityAccMag-mean()
215 215        tGravityAccMag-std()
227 227      tBodyAccJerkMag-mean()
228 228       tBodyAccJerkMag-std()
240 240         tBodyGyroMag-mean()
241 241          tBodyGyroMag-std()
253 253     tBodyGyroJerkMag-mean()
254 254      tBodyGyroJerkMag-std()
266 266           fBodyAcc-mean()-X
267 267           fBodyAcc-mean()-Y
268 268           fBodyAcc-mean()-Z
269 269            fBodyAcc-std()-X
270 270            fBodyAcc-std()-Y
271 271            fBodyAcc-std()-Z
345 345       fBodyAccJerk-mean()-X
346 346       fBodyAccJerk-mean()-Y
347 347       fBodyAccJerk-mean()-Z
348 348        fBodyAccJerk-std()-X
349 349        fBodyAccJerk-std()-Y
350 350        fBodyAccJerk-std()-Z
424 424          fBodyGyro-mean()-X
425 425          fBodyGyro-mean()-Y
426 426          fBodyGyro-mean()-Z
427 427           fBodyGyro-std()-X
428 428           fBodyGyro-std()-Y
429 429           fBodyGyro-std()-Z
503 503          fBodyAccMag-mean()
504 504           fBodyAccMag-std()
516 516  fBodyBodyAccJerkMag-mean()
517 517   fBodyBodyAccJerkMag-std()
529 529     fBodyBodyGyroMag-mean()
530 530      fBodyBodyGyroMag-std()
542 542 fBodyBodyGyroJerkMag-mean()
543 543  fBodyBodyGyroJerkMag-std()
```



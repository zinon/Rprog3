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

3. Now, we want to convert data from a wide format to a long format. Many functions in R expect data to be in a long format rather than a wide format. We thus use the 'reshape2' package which provides two major methods, the `melt()` and `dcast()` (for data-frames). 

4. Melt the dataset by specifying the *Subject* and *Activity* names as the only identification variables.

5. Use the result from the melting process to recast with the *Activity* name and *Subject* as the only IDs. The `mean` is preferred as the aggregator function.

6. The re-casted dataset `processedData` can be used for further analysis.

7. Save the result as `processedData.txt` in the current working directory.


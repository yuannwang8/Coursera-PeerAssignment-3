# Programming Assignment

The run_analysis.R script fulfils the requirements of the Peer Assignment for the Coursera
"Data Gathering" Class The purpose of this script is to 

1. merge the training and test data sets provided 
2. extract only the measurements on the mean and standard deviation for each feature measured 
3. provide appropriately descriptive activity names to each observation 
4. label each observation in the dataset with the appropriate activity name 
5. create a second tidy data set with the average of each variable for 
each activity and each subject

## Note: the following steps are done before running this script
1. The data set is downloaded from the URL specified
URL<-c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
2. This folder is unzipped and placed in its own folder.
3. This R script is also placed in the same folder.
4. This folder is set as the working directory for R.

## Script details: There are 6 steps in the script

1. Read the features list from features_info.txt into the global environment. Select only Mean and STD readings.  This is done using grep on "mean" and "std".  "meanFreq" as a variable was excluded as it is not explicitly called for in the question.
2. Read the 6 different activities from activity_labels.txt into the global environment.
3. Create the data set containing subject, activity and data.  We do this for the test set, then the train set.  Then we merge these two sets to form the final data set.
4. Add the activity name to the database based on the categorical activity code.
5. Create a new tidy data set using melt and dcast from the reshape2 package.

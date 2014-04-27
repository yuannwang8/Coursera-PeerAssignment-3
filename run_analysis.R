## Programming Assignment

## Assumptions: the following steps are done before running this script

# 1. The data set is downloaded from the URL specified
# URL<-c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
# 2. This folder is unzipped and placed in its own folder.
# 3. This R script is also placed in the same folder.
# 4. This folder is set as the working directory for R.

# Step 1.  Read the features list from features_info.txt and select only Mean and STD readings
features.name<-read.table("features.txt")
features.mean.std<-intersect(grep("mean|std",features.name[,2]),grep("meanFreq",features.name[,2], invert=TRUE))
features.short<-features.name[features.mean.std,]

# Step 2.  Read the 6 different activities from activity_labels.txt
activity.name<-read.table("activity_labels.txt")
colnames(activity.name)<-c("activity.code","activity.name")

# Step 3.  Create the data set containing subject, activity and data
# Step 3.1 Let's start with the Test Data set

data<-read.table("test/subject_test.txt")
data[,2]<-read.table("test/y_test.txt")
colnames(data)<-c("subject","activity.code")

featuredata<-read.table("test/X_test.txt")
featuredata<-featuredata[,features.mean.std]
colnames(featuredata)<-features.short[,2]

# this is the test data binded
data.test<-cbind(data,featuredata)

# Step 3.2 now do the same for the train data
data<-read.table("train/subject_train.txt")
data[,2]<-read.table("train/y_train.txt")
colnames(data)<-c("subject","activity.code")

featuredata<-read.table("train/X_train.txt")
featuredata<-featuredata[,features.mean.std]
colnames(featuredata)<-features.short[,2]

# this is the train data binded
data.train<-cbind(data,featuredata)

# Step 3.3 now create the combined database
full.data<-rbind(data.test,data.train)

# Step 4. now apply the activity name to the activity code
full.data<-merge(full.data,activity.name,by="activity.code")

# Step 5.  Write this into a csv file for safety purposes
write.csv(full.data, "merged.csv",row.names=FALSE)

## Step 6: now create a new tidy dataset with the average of each variable for each activity and each subject
## use melt and cast

library(reshape2)
bb<-as.character(features.short[,2])
full.melt<-melt(full.data,id=c("subject","activity.name"),measure.vars=bb)
tidy.data<-dcast(full.melt, subject + activity.name ~ variable, mean)

# save file for submission
write.table(tidy.data,"tidy.txt",sep="\t", row.names=FALSE)

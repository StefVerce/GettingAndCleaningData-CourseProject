## -----------------------------------------------------------------------
## run_analysis.R
## -----------------------------------------------------------------------
## Getting and Cleaning Data - Coursera - Johns Hopkins University
## -----------------------------------------------------------------------
## Stephane Vercellotti - Nov.2014
## -----------------------------------------------------------------------
## README.md on GitHub describes this script
## (https://github.com/StefVerce/GettingAndCleaningData-CourseProject/blob/master/README.md)
## -----------------------------------------------------------------------

## -------------------------------------------------------------------
## 0. Preliminary steps
## -------------------------------------------------------------------
## it is assumed here that files are downloaded and unzipped into a
## common directory
## -------------------------------------------------------------------

## loading library plyr BEFORE dplyr
library(plyr)  
library(dplyr)
## setting the path
path="C:/Stéphane/Coursera/Data Science/3-GettingAndCleaningData/CourseProject"
setwd(path)
## -------------------------------------------------------------------
## 1. Merges the training and the test datasets 
## -------------------------------------------------------------------

## read data sets
x_train       <- read.table("X_train.txt")                                 # X_train
y_train       <- read.table("y_train.txt", col.names="activity_id")        # y_train + renaming column name
x_test        <- read.table("X_test.txt")                                  # X_test
y_test        <- read.table("y_test.txt", col.names="activity_id")         # y_test + renaming column name
subject_train <- read.table("subject_train.txt", col.names="subject")      # subject_train + renaming column name
subject_test  <- read.table("subject_test.txt", col.names="subject")       # subject_test  + renaming column name
features      <- read.table("features.txt", col.names=c("id","feature"))   # read and rename the columns to "id","feature"

## Gather data frame using Row binding  
df_x       <- rbind(x_train,x_test)              # Gather x train and test by rows 
df_y       <- rbind(y_train,y_test)              # Gather y train and test by rows
df_subject <- rbind(subject_train,subject_test)  # Gather subject train and test

## -------------------------------------------------------------------
## 2. keep only measurements on the mean and standard deviation
## -------------------------------------------------------------------

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2]) # use regular expression and get index vector

df_x <- df_x[, mean_and_std_features] # subset the desired columns
# equivalend to df_x <- subset(df_x,select=mean_and_std_features)

names(df_x) <- features[mean_and_std_features, 2] # correct the column names

##
## build the dataset using column binding to gather the 3 main components
## Subjects + Activities + Measures
##
df_data <- cbind(df_subject,df_y,df_x)

## -------------------------------------------------------------------
## 3. Descriptive activity names
## -------------------------------------------------------------------

activity_labels <- read.table("activity_labels.txt", col.names=c("activity_id","activity"))

## Join on activity_id in order to get the activity names
df_data <- arrange(join(df_data,activity_labels), activity_id)

## -------------------------------------------------------------------
## 4. Labels the data set
## -------------------------------------------------------------------

df_data <- subset(df_data, select=-activity_id)             # Get rid of useless activity_id column
df_data <- subset(df_data, select=c(1,68,2:67))             # Move activity as the 2nd col. of the data frame

## Descriptive variables names
names(df_data) <- tolower(names(df_data))                   # lower case
names(df_data) <- gsub("-|\\()","",colnames(df_data))       # remove characters ":" ")"
names(df_data) <- gsub("bodybody","body",names(df_data))    # correct erroneous duplicate body string
names(df_data) <- gsub("tbody","timebody",names(df_data))   # 
names(df_data) <- gsub("fbody","freqbody",names(df_data))   #
names(df_data) <- gsub("acc","acceleration",names(df_data)) #
names(df_data) <- gsub("gyro","gyroscope",names(df_data))   #
names(df_data) <- gsub("mag","magnitude",names(df_data))    #
    
## -------------------------------------------------------------------
## 5. Aggregating tidy data set and writing file
## -------------------------------------------------------------------

df_tidy <- df_data %>% 
                group_by(subject,activity) %>% 
                   summarise_each(funs(mean))

##
## Output the tidy grouped dataset into a file in the current directory
##
write.table(df_tidy, "HumanActivityRecognitionDataset.txt", row.names = FALSE, sep = "\t")




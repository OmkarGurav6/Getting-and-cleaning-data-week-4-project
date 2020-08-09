
#Creating new directory
dir.create("Project")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Downloading zip file
download.file(url,"Project.zip",mode = "wb")

#Unzipping file into project directory
unzip("Project.zip",exdir = "Project")

#Checking files  
list.files("Project",recursive = TRUE)

#Setting working directory to UCI HAR Dataset
setwd("./UCI HAR Dataset")

#Reading test tables
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

#Reading train tables
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

#Reading features data
features <- read.table("features.txt")

#Reading activity labels data
activity_labels <- read.table("activity_labels.txt")

#Assigning column names
colnames(X_test) <- features[,2]
colnames(y_test) <- "activity_ID"
colnames(subject_test) <- "Subject_ID"

colnames(X_train) <- features[,2]
colnames(y_train) <- "activity_ID"
colnames(subject_train) <- "Subject_ID"

colnames(activity_labels) <- c("activity_ID","activity_name")

#Merging train and test data
all_train_data <- cbind(y_train,subject_train,X_train)
all_test_data <- cbind(y_test,subject_test,X_test)
final_data <- rbind(all_train_data,all_test_data)

#Storing column names
column_names <- colnames(final_data)
mean_and_std <- (grepl("activity_ID",column_names) | 
                grepl("Subject_ID",column_names) |
                grepl("mean..",column_names) |
                grepl("std...",column_names) )

#Subsetting dataset for mean and std
subset_mean_and_std <- final_data[,mean_and_std == TRUE]

#Setting activity names
subset_with_activity_names <- merge(subset_mean_and_std,activity_labels,
                                                                        by = "activity_ID",all.x = TRUE)
library(dplyr)
#Creating new dataset
td <- subset_with_activity_names %>% 
      #grouping dataset with activity name and subject ID
      group_by(activity_name,Subject_ID) %>%
      #Applying mean function to each column
      summarise_each(mean) %>%
      #Reorder according to subject ID and activity ID
      arrange(Subject_ID,activity_ID)

#Writting tidy dataset into txt file
write.table(td,"Tidy_dataset.txt",row.names = FALSE)


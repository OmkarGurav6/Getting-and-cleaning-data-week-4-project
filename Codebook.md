# This is the code book for the project

## About the source data
The source data is from data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here is the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 
## About R script
File with R code "run_analysis.R" performs following steps :   
1. Create a new directory called "Project".       
2. Download data from the link above and unzip it into working directory of R Studio.   
3. List recursively all files in "Project" directory.    
4. Set working directory to UCI HAR Dataset to work with other files more efficiently.   
5. Reading files    
    1. Reading testing tables      
    2. Reading training tables       
    3. Reading features vector     
    4. Reading activity labels       
6. Assigning appropriate names to columns of testing tables, training tables and activity labels.        
7. Merging all data in one dataset.     
8. Storing column names in a variable and subsetting variable using grepl() to match "mean.." and "std..".     
9. Subsetting dataset for mean and std using above variable.     
10. Meging above dataset with activity_labels to give activity names using common column activity_ID.        
11. Loading dplyr package.(if not installed,first install it using install.packages() and then load it.)
12. Create new dataset by applying group_by(), summarise_each() and arrange() on above dataset using %>% operator.     
13. Writting tidy dataset in txt file.     


## About variables:      

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `X_data`.

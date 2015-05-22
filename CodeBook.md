#Getting and Cleaning Data Course Project

##**Waheed Khan**
=================================================

* The data can be downloaded from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip      
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in train.data.set, train.data.label and train.data.subject variables respectively.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in test.data.set, test.data.label and test.data.subject variables respectively.  
 3. Concatenate test and train data sets to generate data tables complete.data.set,complete.data.subjects and complete.data.labels
 4. Read the features.txt file from the current working folder and store the data in a data table called features.dt. I extracted  measurements on the mean and standard deviation and stored them in extracted.data.set.
 5. Clean the column names of the subset. I removed the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.   
 6. Read the activity_labels.txt file from the current working folder and store the data in activities.data.set.  
 7. Clean the activity names in the second column of activities.data.set.  
 8. Combine the complete.data.subjects, complete.data.labels and extracted.data.set by column to get a new cleaned 10299x81 data table, cleaned.data. Properly name the first two columns as , "Subject" and "Activity".
 9. Write the *cleaned.data* out to "cleaned_data.txt" file in current working directory.  
 10. Finally,I generated a second independent tidy data set with the mean of each measurement for each activity and each subject and stored in data table result. 
 11) The data table result is generated and written to file dataset2.txt
 
© Waheed Khan 2015.

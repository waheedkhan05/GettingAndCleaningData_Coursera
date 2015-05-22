Getting and Cleaning Data Course Project
Waheed Khan
email: waheedkhan05@yahoo.com
========================================
This file describes how the script works.
1) First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
* Make sure to make folder UCI HAR Dataset as current working directory so that the files features.txt,activity_labels.txt and folders test and train are accessible.
* I have used data table instead of simple data frame so there is a dependency on data.table. Make sure to download and install data.table package.
2) Use source("run_analysis.R") command in RStudio or run the script after you have setup the working directory explained in step 1.
* The script file will run and will output messages as it progresses.
3)After successful completion, you will find two output files are generated in the current working directory:
  - cleaned_data.txt: it contains a data table called cleaned.data with 10299*81 dimensions.
  - cleaned_data2.txt : it contains a data frame called result with 180*81 dimensions.

© Waheed Khan 2015 All Rights reserved.
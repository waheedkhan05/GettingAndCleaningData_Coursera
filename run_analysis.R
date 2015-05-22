# This is the course Project of Getting and Cleaning Data

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if(require("data.table")) {
    library("data.table")
}else 
{
    print("data.table package is required, trying to install package ...")
    install.packages("data.table")
}

if(file.exists("test") & file.exists("train"))
{
    message("TASK 1: Merges the training and the test sets to create one data set.")
    # Reading the datasets    
    # TEST DATA
    message("Reading datasets of test data ...")
    test.data.set <- data.table(read.table("test/X_test.txt"))
    message("reading test data set complete.")
    test.data.label <- data.table(read.table("test/y_test.txt"))
    message("reading test label data set complete.")
    test.data.subject <- data.table(read.table("test/subject_test.txt"))
    message("reading test subject data set complete.")

    # TRAINING DATA
    message("Reading datasets of train data ...")
    train.data.set <- data.table(read.table("train/X_train.txt"))
    message("reading train data set complete.")
    train.data.label <- data.table(read.table("train/y_train.txt"))
    message("reading train label data set complete.")
    train.data.subject <- data.table(read.table("train/subject_train.txt"))
    message("reading train subject data set complete.")

    # Merging both datasets
    message("Now merging test and train data set ...")
    complete.data.set <- rbind(test.data.set,train.data.set)
    
    complete.data.subjects <- rbind(test.data.subject,train.data.subject)
    message("merging test and train data set completed.")
    
    complete.data.labels <- rbind(test.data.label,train.data.label)
    message("merging test and train labels set completed.")
    
    message("============ TASK 1 completed ===================")
    
    message("TASK 2: Extracts only the measurements on the mean and standard deviation for each measurement. ")
    # Extracts only the measurements on the mean and standard deviation for each measurement.     
    message("reading features ...")
    features.dt <- data.table(read.table("features.txt"))
    selected.indices <- grep("mean|std",features.dt$V2)
    message("Extracting the mean and standard deviation measurements.")
    extracted.data.set <- complete.data.set[,.SD,.SDcols=selected.indices]
    
    message("============ TASK 2 completed ===================")
    
    # Setting descriptive names of the columns
    message("TASK 3 : Setting descriptive names of the columns")
    cleaned.column.names <- gsub("\\(\\)","",features.dt[selected.indices,V2])
    cleaned.column.names <- gsub("mean","Mean",cleaned.column.names)
    cleaned.column.names <- gsub("std","Std",cleaned.column.names)
    cleaned.column.names <- gsub("-","",cleaned.column.names)
    setnames(extracted.data.set,names(extracted.data.set),cleaned.column.names)
    
    message("============ TASK 3 completed ===================")
    
    
    message("TASK 4 : Appropriately labels the data set with descriptive variable names.")
    activities.data.set <- read.table("activity_labels.txt")
    activitiesCols <- gsub("_","",activities.data.set[,"V2"])
    activitiesCols <- tolower(activitiesCols)
    substring(text = activitiesCols,8,8) <- toupper(substring(activitiesCols,8,8))
    activitiesCols[5] <- tolower(substring(activitiesCols[5],1,8))
    substring(text = activitiesCols,1,1) <- toupper(substring(activitiesCols,1,1))
    
    message("============ TASK 4 completed ===================")
    
    complete.data.labels$V1 <- transform(complete.data.labels,V1=activitiesCols[complete.data.labels$V1])   
    message("Naming columns ... ")
    setnames(complete.data.subjects,"V1","Subject")
    setnames(complete.data.labels,"V1","Activity")
    message("Building cleaned data set .... ")
    cleaned.data <- cbind(complete.data.subjects,complete.data.labels,extracted.data.set)
    message("Previewing the dataset generated before writing :")
    head(cleaned.data)
    cleaned.data.filename <- "cleaned_data.txt"
    message(paste("writing cleaned data to file ",cleaned.data.filename," ..."))
    write.table(cleaned.data, cleaned.data.filename ,row.name=FALSE)
    
    message(paste("A file ",cleaned.data.filename," with the cleaned data has been created in the working directory."))
    
    message("============ TASK 5 completed ===================")
    
    message("TASK 6: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.")
    
    subject.levels <- levels(as.factor(cleaned.data$Subject))
    activity.levels <- levels(as.factor(cleaned.data$Activity))
    result <- matrix(NA, nrow=length(subject.levels)*length(activity.levels), ncol=ncol(cleaned.data)) 
    result <- as.data.frame(result)
    setnames(result,colnames(result),colnames(cleaned.data))
    row <- 1
    message("Creating another data set ...")
    for(i in 1:length(subject.levels)) {
        for(j in 1:length(activity.levels)) {
            result[row, 1] <- as.numeric(subject.levels[i])
            result[row, 2] <- as.character(activity.levels[j])
            bool1 <- i == cleaned.data$Subject
            bool2 <- activity.levels[j] == cleaned.data$Activity
            result[row, 3:ncol(cleaned.data)] <- colMeans(cleaned.data[bool1&bool2, 3:ncol(cleaned.data),with=F])
            row <- row + 1
        }
    }
    message("Previewing the dataset generated before writing :")
    head(result)
    another.dataset.filename <- "dataset2.txt"
    message(paste("Writing the dataset to file ",another.dataset.filename," ..."))
    write.table(result, another.dataset.filename ,row.name=FALSE)
    message(paste("A file ",another.dataset.filename," with the cleaned data has been created in the working directory."))
    message("============ TASK 6 completed ===================")
} else
{
    stop("The directory is not a valid data directory. Please make sure the files features.txt,activity_labels.txt and directories test and train are available in present working directory.")
}
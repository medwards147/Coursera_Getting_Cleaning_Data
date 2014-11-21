run_analysis <- function { 
                        
        # get the file url
        fileUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        # create a temporary directory
        td = tempdir()
        # create the placeholder file
        tf = tempfile(tmpdir=td, fileext=".zip")
        # download into the placeholder file
        download.file(fileUrl, tf)
        
        # create a list of files
        fnames = unzip(tf, list = TRUE)$Name
        # unzip the files to the temporary directory
        unzip(tf, files=fnames, exdir=td, overwrite=TRUE)
        # fpath is the full path to the extracted files
        fpath = file.path(td, fnames)
        
        # Files needed
        directoryName <- "UCI HAR Dataset"
        testFile <- paste(td, directoryName, "test/X_test.txt", sep = "/" )
        trainFile <- paste(td, directoryName, "train/X_train.txt", sep = "/" )
        featuresFile  <- paste(td, directoryName, "features.txt", sep = "/" )
        testLabelFile <- paste(td, directoryName, "test/y_test.txt", sep = "/" )
        trainLabelFile <- paste(td, directoryName, "train/y_train.txt", sep = "/" )
        testSubjectFile <- paste(td, directoryName, "test/subject_test.txt", sep = "/" )
        trainSubjectFile <- paste(td, directoryName, "train/subject_train.txt", sep = "/" )
        
        # Read files
        xtest <- read.table(testFile , header = FALSE)
        xtrain <- read.table(trainFile, header = FALSE)
        features <- readLines(featuresFile)
        ytest <- read.table(testLabelFile)
        ytrain <- read.table(trainLabelFile)
        testsub <- read.table(testSubjectFile)
        trainsub <- read.table(trainSubjectFile)
        
        rm(testFile, trainFile, featuresFile, testLabelFile, trainLabelFile, testSubjectFile, trainSubjectFile)
        
        # load libraries
        library(plyr); library(dplyr); 
        
        # combine x data
        xdat <- rbind(xtest,xtrain)
        
        # fix features to remove the number labels in front
        splitNames <- strsplit(features, " " )
        secondElement <- function(x) {x[2]}
        features <- sapply(splitNames, secondElement)
        
        # add features as column names
        names(xdat) <- features
        
        # Step 2 from instructions
        # Extracts only the measurements on the mean and standard deviation for each measurement
        # filter out data for only mean and std obs, create a logical vector where TRUE is mean or std
        filterindex <- grepl("mean|std", features)
        xdat <- xdat[,filterindex]
        
        # Create vector for Activity labels, could of read in file provided but this works...
        activities <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")       
        
        # Step 3 from instructions
        # Uses descriptive activity names to name the activities in the data set
        # combine y data and add a column to match the activity label with the #
        ydat <- rbind(ytest, ytrain)
        ydat[,2] <- activities[ydat[,1]]
        names(ydat) <- c("ActivityID", "ActivityLabel")
        
        # combine subjet data by row
        subjects <- rbind(testsub, trainsub)
        names(subjects) <- "subjects"
        
        # Step 1 from instructions
        # Merges the training and the test sets to create one data set
        # Combine subject, ydata, and xdata by col
        combined <- cbind(subjects, ydat, xdat)    

        # Step 4 from instructions
        # Appropriately label the data set with descriptive variable names
        names(combined) <- gsub("-mean\\(\\)", "Mean", names(combined ) )
        names(combined) <- gsub("-std\\(\\)", "StdDev", names(combined) ) 
        names(combined) <- gsub("^t", "Time", names(combined ) )
        names(combined) <- gsub("^f", "Freq", names(combined ) )
        names(combined) <- gsub("BodyBody", "Body", names (combined ) )
        names(combined) <- gsub("-", "", names(combined) )
        names(combined) <- gsub("\\(\\)", "", names(combined ) )
        
        # Step 5 from instructions
        # From the data set in step 4, creates a second, independent tidy data 
        #   set with the average of each variable for each activity and each subject
        # Need to create a melted dataframe so I can use subject and activity as id variables
       
        # load reshape2
        library(reshape2)
        
        # Create the melted data, first 3 names of combined are the ids, all other names are measured
        melted <- melt(combined, id = names(combined)[1:3], measure.vars = names(combined)[-(1:3)] )
        
        tidy <- dcast(melted, subjects + ActivityLabel ~ variable, mean)
        
        # Return will be the write to a file. Writes to your wd
        write.table(tidy, file = "./tidy.txt")
        
}
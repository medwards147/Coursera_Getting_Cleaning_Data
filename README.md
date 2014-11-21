CourseraGettingAndCleaningProject
=================================
**Description of Repo**
This repo contains:
- run_analysis.R : a function that returns a tidy.txt file to your working directory. 
- tidy.txt : data that contains the average for each variable (see codebook) for each activitity by subject.
- CodeBook.md : a R markdown file that provides the description of variables used to create tidy.txt

**How does run_analysis.R work?**

**Step 1.** Downloads the zip file from the URL provided and extracts the contents to a temporary directory. 

**Step 2.** Assigns variables to the following files:
- X_test.txt
- X_train.txt
- features.txt
- y_test.txt
- y_train.txt
- subject_test.txt
- subject_train.txt

**Step 3.** Combines the x data (Test and train), adds column names, and filters out only mean and standard deviation variables

**Step 4.** Combines y data(test and train), adds a column that shows Acitivity Descriptions (i.e. Walking)

**Step 5.** Combines subject(test and train)

**Step 6.** Merges the x data, y data, and subjects data into one data frame

**Step 7.** Renames the variables by removing unwated characters (i.e. "-" and "()" ) and clarifying labels (i.e. "t" = "Time" )

**Step 8.** Uses reshape2 package to create a melted dataframe in order to use dcast to create a wide tidy data set by acitivity
and by subject with means for each variable. 

---
title: "CodeBook"
author: "Max"
date: "Friday, November 21, 2014"
output: html_document
---
Data
---
- Data used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Data source: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

---
Repo Files
---
- run_analysis.R : a function that returns a tidy.txt file to your working directory. 
- tidy.txt : data that contains the average for each variable (see codebook) for each activitity by subject.
- CodeBook.md : a R markdown file that provides the description of variables used to create tidy.txt

---
Data Transformation using run_analysis.R
---
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

---
Tidy Data Variable Descriptions
---
Subject: The subject performing an activity (30 subjects total performing 6 activities)
AcitivityLabel: The activity being performed (Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstars)
Measurements: There were 79 total measurements which are the means of each subject performing an acitivity.  The following format was used (bracketed means start of new word):
- (Frequency or Time)(Body or Gravity Created Motion)(Measuring Devise Used and Motion Type)(Mean or Standard Deviation)(X, Y, or Z axis)
- For example, TimeBodyAccMeanX is the Time due to Body Motion using Accelerometer Mean along X Axis

---
Glossary of Variable Abbreviations that are not obvious
---
- Freq = Freqency
- Acc = Accelerometer
- Gyro = Gyroscope
- StdDev = Standard Deviation
- Mag = Magnititude

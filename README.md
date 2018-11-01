# Getting and Cleaning Data

## Summary

This repository prepares a tidy data set using the raw data set **Human Activity Recognition Using Smarphones**, and comprises the R script used to transform the data and a code book with a description of the variables included. 

## Raw data
The raw data was sourced from the Human Activity Recognition Using Smartphones Dataset version 1.0, which can be found in this [link](http://http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data registers the results from an experiment conducted on a group of 30 volunteers within the ages of 19-48, which each performed six activities (Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs) while wearing a Samsung Galaxy S II. The results comprise information of 3-axial linear acceleration and 3-axial angular velocity.

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova; Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws ; www.smartlab.ws

## Data Analysis
The raw data has been transformed using the R script run_analysis.R included in this repository into a tidy data set reflecting the average of the Mean and the Standard Deviation of various variables for each subject and each activity. Please refer to the Code Book for a complete overview and description of these variables. 

##Script

### Function Arguments
When uploading the data from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), please save the unzipped folder in a working directory of your choice. The default name for this folder is UCI_HAR_Dataset.  

The function has the following arguments. As these are character strings, remember to use quotation marks.

- BaseDirectory: The location of UCI_HAR_Dataset.
- TestDirectory: UCI_HAR_Dataset/Test
- TrainDirectory: UCI_HAR_Dataset/Train

For example: 

- BaseDirectory: "C:\Users\Andy\Documents\DataScience\Assignment\UCI_HAR_Dataset"
- TestDirectory: "C:\Users\Andy\Documents\DataScience\Assignment\UCI_HAR_Dataset\Test"
- TrainDirectory: "C:\Users\Andy\Documents\DataScience\Assignment\UCI_HAR_Dataset\Train"

### Function Output
The script returns the tidy data set previously mentioned as xtable2, which is printed in R and also saved in the global environment. This tidy data set is a table of 180 observations (six activities per 30 people) for 69 variables. 

THe repository includes a .txt version of this table. Please save it in your working directory and use the following code to read it into R:

    xtable2<-read.table("xtable2.txt", header = TRUE); View(xtable2)


## Code book
The Code book contains a description of the variables included in the tidy data set and the transformations perfomed on the raw data set. 
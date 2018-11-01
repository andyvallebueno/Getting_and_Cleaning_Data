run_analysis<-function(basedirectory, testdirectory, traindirectory) {
  install.packages("dplyr")
  library(dplyr)
  
  ## 1. Merge training and test sets
  
  ##    1.1 Read data 
  setwd(basedirectory)
  features<-read.table("features.txt", header = FALSE, stringsAsFactors = FALSE)
  activityl<-read.delim("activity_labels.txt", header = FALSE)
  
  setwd(testdirectory)
  s_test<-read.delim("subject_test.txt", header = FALSE)
  x_test<-read.delim("X_test.txt", header = FALSE)
  y_test<-read.delim("y_test.txt", header = FALSE)
  
  setwd(traindirectory)
  s_train<-read.delim("subject_train.txt", header = FALSE)
  x_train<-read.delim("X_train.txt", header = FALSE)
  y_train<-read.delim("Y_train.txt", header = FALSE)
  
  featurest<-tbl_df(features)
  activitylt<-tbl_df(activityl)
  
  ##    1.2 Add labels
  xtestlabel<-cbind(s_test, y_test)
  xtest<-cbind(xtestlabel, x_test)
  colnames(xtest)<-c("Subject", "Activity", "Data")
  xtestt<-tbl_df(xtest)
  
  xtrainlabel<-cbind(s_train, y_train)
  xtrain<-cbind(xtrainlabel, x_train)
  colnames(xtrain)<-c("Subject", "Activity", "Data")
  xtraint<-tbl_df(xtrain)
  
  ##    1.3 Merge
  x_testt<-mutate(xtestt, Status = "Test")
  x_traint<-mutate(xtraint, Status = "Train")
  xtable<-bind_rows(x_testt, x_traint)
  
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement
  ##    2.1 Find position of mean() and std() in features vector
  feat<-features[,2]
  mean<-grep("mean()", feat, fixed=TRUE)
  std<-grep("std()", feat, fixed=TRUE)
  both<-c(mean, std)
  J<-1:length(both)
  
  ##    2.2 Create table
  for (j in J) {
    position<-both[j]
    variablename<-feat[position]
    
    xtable<-mutate(xtable, variablename = 0)
    xtable<-rename(xtable, !!variablename:= variablename)
  }
  
  ##    2.3 Add values 
  I<-1:nrow(xtable)
  
    for (i in I) {
      K<-xtable[i,"Data"]
      K<-as.character(K)
      K<-strsplit(K, " ")
      K<-unlist(K)
      K<-subset(K, K != "")
      K<-K[both] 
      
      for (j in J) {
        xtable[i,j+4]<-K[j]
      }
    }
  
  xtable<-select(xtable, -Data)
  
  ## 3. Uses descriptive activity names to name the activities in the data set
  activities<-c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
  I<-I[-1]
  
  xtable[1,2]<-activities[pull(xtable[1,2])]
  
  for (i in I) {
    xtable[i,2]<-activities[as.numeric(pull(xtable[i,2]))]
  }
  
  ## 4. Appropriately labels the data set with descriptive variable names
  Names<-c("Subject ID", "Activity", "Test/Train", "Mean - Time domain representation of body acceleration on the X axis of the phone", "Mean - Time domain representation of body acceleration on the Y axis of the phone", "Mean - Time domain representation of body acceleration on the Z axis of the phone", "Mean - Time domain representation of gravity acceleration on the X axis of the phone", "Mean - Time domain representation of gravity acceleration on the Y axis of the phone", "Mean - Time domain representation of gravity acceleration on the Z axis of the phone", "Mean - Time domain representation of body acceleration from jerk on the X axis of the phone", "Mean - Time domain representation of body acceleration from jerk on the Y axis of the phone", "Mean - Time domain representation of body acceleration from jerk on the Z axis of the phone", "Mean - Time domain representation of body angular velocity on the X axis of the phone", "Mean - Time domain representation of body angular velocity on the Y axis of the phone", "Mean - Time domain representation of body angular velocity on the Z axis of the phone", "Mean - Time domain representation of body angular velocity from jerk on the X axis of the phone", "Mean - Time domain representation of body angular velocity from jerk on the Y axis of the phone", "Mean - Time domain representation of body angular velocity from jerk on the Z axis of the phone", "Mean - Time domain representation of body acceleration magnitude", "Mean - Time domain representation of gravity acceleration magnitude", "Mean - Time domain representation of body acceleration from jerk magnitude", "Mean - Time domain representation of body angular velocity magnitude", "Mean - Time domain representation of body angular velocity from jerk magnitude", "Mean - Frequency domain representation of body acceleration on the X axis of the phone", "Mean - Frequency domain representation of body acceleration on the Y axis of the phone", "Mean - Frequency domain representation of body acceleration on the Z axis of the phone", "Mean - Frequency domain representation of body acceleration from jerk on the X axis of the phone", "Mean - Frequency domain representation of body acceleration from jerk on the Y axis of the phone", "Mean - Frequency domain representation of body acceleration from jerk on the Z axis of the phone", "Mean - Frequency domain representation of body angular velocity on the X axis of the phone", "Mean - Frequency domain representation of body angular velocity on the Y axis of the phone", "Mean - Frequency domain representation of body angular velocity on the Z axis of the phone", "Mean - Frequency domain representation of body acceleration magnitude", "Mean - Frequency domain representation of body acceleration from jerk magnitude", "Mean - Frequency domain representation of body angular velocity magnitude", "Mean - Frequency domain representation of body angular velocity from jerk magnitude", "Standard Deviation - Time domain representation of body acceleration on the X axis of the phone", "Standard Deviation - Time domain representation of body acceleration on the Y axis of the phone", "Standard Deviation - Time domain representation of body acceleration on the Z axis of the phone", "Standard Deviation - Time domain representation of gravity acceleration on the X axis of the phone", "Standard Deviation - Time domain representation of gravity acceleration on the Y axis of the phone", "Standard Deviation - Time domain representation of gravity acceleration on the Z axis of the phone", "Standard Deviation - Time domain representation of body acceleration from jerk on the X axis of the phone", "Standard Deviation - Time domain representation of body acceleration from jerk on the Y axis of the phone", "Standard Deviation - Time domain representation of body acceleration from jerk on the Z axis of the phone", "Standard Deviation - Time domain representation of body angular velocity on the X axis of the phone", "Standard Deviation - Time domain representation of body angular velocity on the Y axis of the phone", "Standard Deviation - Time domain representation of body angular velocity on the Z axis of the phone", "Standard Deviation - Time domain representation of body angular velocity from jerk on the X axis of the phone", "Standard Deviation - Time domain representation of body angular velocity from jerk on the Y axis of the phone", "Standard Deviation - Time domain representation of body angular velocity from jerk on the Z axis of the phone", "Standard Deviation - Time domain representation of body acceleration magnitude", "Standard Deviation - Time domain representation of gravity acceleration magnitude", "Standard Deviation - Time domain representation of body acceleration from jerk magnitude", "Standard Deviation - Time domain representation of body angular velocity magnitude", "Standard Deviation - Time domain representation of body angular velocity from jerk magnitude", "Standard Deviation - Frequency domain representation of body acceleration on the X axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration on the Y axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration on the Z axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration from jerk on the X axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration from jerk on the Y axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration from jerk on the Z axis of the phone", "Standard Deviation - Frequency domain representation of body angular velocity on the X axis of the phone", "Standard Deviation - Frequency domain representation of body angular velocity on the Y axis of the phone", "Standard Deviation - Frequency domain representation of body angular velocity on the Z axis of the phone", "Standard Deviation - Frequency domain representation of body acceleration magnitude", "Standard Deviation - Frequency domain representation of body acceleration from jerk magnitude", "Standard Deviation - Frequency domain representation of body angular velocity magnitude", "Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude")
  names(xtable)<-Names
  
  ## xtable is the final table including all data on mean and standard deviation
  xtable<-mutate_at(xtable, grep("domain", colnames(xtable), value = TRUE), funs(as.numeric))
   
  
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  
  xtable2 <- group_by(xtable, `Subject ID`, Activity, `Test/Train`)
  xtable2<-summarize_at(xtable2, grep("domain", colnames(xtable2), value = TRUE), funs(mean))
  Namestidy<-c("Subject ID", "Activity", "Test/Train", "Average of Mean - Time domain representation of body acceleration on the X axis of the phone", "Average of Mean - Time domain representation of body acceleration on the Y axis of the phone", "Average of Mean - Time domain representation of body acceleration on the Z axis of the phone", "Average of Mean - Time domain representation of gravity acceleration on the X axis of the phone", "Average of Mean - Time domain representation of gravity acceleration on the Y axis of the phone", "Average of Mean - Time domain representation of gravity acceleration on the Z axis of the phone", "Average of Mean - Time domain representation of body acceleration from jerk on the X axis of the phone", "Average of Mean - Time domain representation of body acceleration from jerk on the Y axis of the phone", "Average of Mean - Time domain representation of body acceleration from jerk on the Z axis of the phone", "Average of Mean - Time domain representation of body angular velocity on the X axis of the phone", "Average of Mean - Time domain representation of body angular velocity on the Y axis of the phone", "Average of Mean - Time domain representation of body angular velocity on the Z axis of the phone", "Average of Mean - Time domain representation of body angular velocity from jerk on the X axis of the phone", "Average of Mean - Time domain representation of body angular velocity from jerk on the Y axis of the phone", "Average of Mean - Time domain representation of body angular velocity from jerk on the Z axis of the phone", "Average of Mean - Time domain representation of body acceleration magnitude", "Average of Mean - Time domain representation of gravity acceleration magnitude", "Average of Mean - Time domain representation of body acceleration from jerk magnitude", "Average of Mean - Time domain representation of body angular velocity magnitude", "Average of Mean - Time domain representation of body angular velocity from jerk magnitude", "Average of Mean - Frequency domain representation of body acceleration on the X axis of the phone", "Average of Mean - Frequency domain representation of body acceleration on the Y axis of the phone", "Average of Mean - Frequency domain representation of body acceleration on the Z axis of the phone", "Average of Mean - Frequency domain representation of body acceleration from jerk on the X axis of the phone", "Average of Mean - Frequency domain representation of body acceleration from jerk on the Y axis of the phone", "Average of Mean - Frequency domain representation of body acceleration from jerk on the Z axis of the phone", "Average of Mean - Frequency domain representation of body angular velocity on the X axis of the phone", "Average of Mean - Frequency domain representation of body angular velocity on the Y axis of the phone", "Average of Mean - Frequency domain representation of body angular velocity on the Z axis of the phone", "Average of Mean - Frequency domain representation of body acceleration magnitude", "Average of Mean - Frequency domain representation of body acceleration from jerk magnitude", "Average of Mean - Frequency domain representation of body angular velocity magnitude", "Average of Mean - Frequency domain representation of body angular velocity from jerk magnitude", "Average of Standard Deviation - Time domain representation of body acceleration on the X axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration on the Y axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration on the Z axis of the phone", "Average of Standard Deviation - Time domain representation of gravity acceleration on the X axis of the phone", "Average of Standard Deviation - Time domain representation of gravity acceleration on the Y axis of the phone", "Average of Standard Deviation - Time domain representation of gravity acceleration on the Z axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the X axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the Y axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the Z axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity on the X axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity on the Y axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity on the Z axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the X axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the Y axis of the phone", "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the Z axis of the phone", "Average of Standard Deviation - Time domain representation of body acceleration magnitude", "Average of Standard Deviation - Time domain representation of gravity acceleration magnitude", "Average of Standard Deviation - Time domain representation of body acceleration from jerk magnitude", "Average of Standard Deviation - Time domain representation of body angular velocity magnitude", "Average of Standard Deviation - Time domain representation of body angular velocity from jerk magnitude", "Average of Standard Deviation - Frequency domain representation of body acceleration on the X axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration on the Y axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration on the Z axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the X axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the Y axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the Z axis of the phone", "Average of Standard Deviation - Frequency domain representation of body angular velocity on the X axis of the phone", "Average of Standard Deviation - Frequency domain representation of body angular velocity on the Y axis of the phone", "Average of Standard Deviation - Frequency domain representation of body angular velocity on the Z axis of the phone", "Average of Standard Deviation - Frequency domain representation of body acceleration magnitude", "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk magnitude", "Average of Standard Deviation - Frequency domain representation of body angular velocity magnitude", "Average of Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude")
  names(xtable2)<-Namestidy
  
  ## Final tidy data set is xtable 2, printed and stored in global environment
  xtable2<<-xtable2
  xtable2
}
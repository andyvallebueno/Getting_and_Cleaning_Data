# Human Activity Recognition Using Smartphones

## Raw dataset
The Human Activity Recognition Using Smartphones Dataset (Version 1.0) is used as the raw data set.

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova; Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws; www.smartlab.ws

This raw data set reflects the results of experiments "carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist." With the phone's accelerometer and gyroscope, information on 3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. "The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data." [1]

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used." [1]

###Variables from the raw data set

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

"Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

"Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

"These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions." 
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
[1]

A set of variables was then estimated from these signals including mean and standard deviation.

## Transformation
The transformation comprised in the R script run_analysis.R uses this raw data and transforms it into a tidy data set named xtable2. 

1. It begins by reading the features, activity_labels, subject_test, x_test, y_test, subject_train, x_train and y_train files from the raw data set into R. This is included as step 1.1 in the script. 
2. The function then adds labels to the x_test and x_train tables by binding together these tables with the respective subject and Y files, so as to include the subject ID and activity type per observation. These are inclulded as two columns to the left of the x_test and x_train tables. This is included as step 1.2 in the script. 
3. The function then merges the train and test data by adding a new column (Test/Train in the final output) which specifies whether the observation is related to the Test or Train dataset. After this column is added, the function binds the rows from each dataset together. This is included as step 1.3 in the script.
4. The function then extracts from this large table the measurements that are related to Mean or Standard Deviation. From the features vector, it finds these variables (2.1 in R script) and creates a new table with only these variables (2.2 in R script). The function then adds the values to the new table by reading each row of the previous table and extracting from the character string only those values related to the Mean and Standard Deviation (2.3 in R script). 
5. The function then uses the activities file to read through each observation of the new table and assign the name of the correct activity as per the number specified in the table (3.0 in R script).
6. The function then appropriately lavels the new data table with descriptive variable names. For this step, variable names were expanded to be readable. For example, fBodyBodyGyroJerkMag-std() was described as Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude. For an easier read, at the beginning of each variable the table specifies whether the value is a Mean or Standard Deviation. This was step 4.0 in the R script.
7. A new dataset is created from this table by grouping the table by activity and subject ID, and then calculating the mean of all the variables per activity and subject. This final dataset is also relabeled to reflect that now each column (with the exception of Subject ID, Activity and Test/Train) is the average of its previous variable values. For example, Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude from the previous point is now Average of Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude. This is step 5.0 in the R script. This final data table is called xtable2, and is printed and saved to the global environment.

## Variables: Column, name and description


 [1] "Subject ID" Numeric value between 1 and 30 specifying the ID of the subject who performed the activity.                                                                                                               
 [2] "Activity" Character value specifying the activity performed by the subject.                                                                                                                
 [3] "Test/Train" Character value specifying the classification of the subject.                                                                                                               
 [4] "Average of Mean - Time domain representation of body acceleration on the X axis of the phone" Numeric value                          
 [5] "Average of Mean - Time domain representation of body acceleration on the Y axis of the phone" Numeric value                            
 [6] "Average of Mean - Time domain representation of body acceleration on the Z axis of the phone" Numeric value                            
 [7] "Average of Mean - Time domain representation of gravity acceleration on the X axis of the phone" Numeric value                         
 [8] "Average of Mean - Time domain representation of gravity acceleration on the Y axis of the phone" Numeric value                         
 [9] "Average of Mean - Time domain representation of gravity acceleration on the Z axis of the phone" Numeric value                         
[10] "Average of Mean - Time domain representation of body acceleration from jerk on the X axis of the phone" Numeric value                  
[11] "Average of Mean - Time domain representation of body acceleration from jerk on the Y axis of the phone" Numeric value                  
[12] "Average of Mean - Time domain representation of body acceleration from jerk on the Z axis of the phone" Numeric value                  
[13] "Average of Mean - Time domain representation of body angular velocity on the X axis of the phone" Numeric value                        
[14] "Average of Mean - Time domain representation of body angular velocity on the Y axis of the phone" Numeric value                        
[15] "Average of Mean - Time domain representation of body angular velocity on the Z axis of the phone" Numeric value                        
[16] "Average of Mean - Time domain representation of body angular velocity from jerk on the X axis of the phone" Numeric value              
[17] "Average of Mean - Time domain representation of body angular velocity from jerk on the Y axis of the phone" Numeric value              
[18] "Average of Mean - Time domain representation of body angular velocity from jerk on the Z axis of the phone" Numeric value              
[19] "Average of Mean - Time domain representation of body acceleration magnitude" Numeric value                                             
[20] "Average of Mean - Time domain representation of gravity acceleration magnitude"  Numeric value                                         
[21] "Average of Mean - Time domain representation of body acceleration from jerk magnitude"  Numeric value                                  
[22] "Average of Mean - Time domain representation of body angular velocity magnitude"  Numeric value                                        
[23] "Average of Mean - Time domain representation of body angular velocity from jerk magnitude" Numeric value                               
[24] "Average of Mean - Frequency domain representation of body acceleration on the X axis of the phone" Numeric value                       
[25] "Average of Mean - Frequency domain representation of body acceleration on the Y axis of the phone" Numeric value                       
[26] "Average of Mean - Frequency domain representation of body acceleration on the Z axis of the phone" Numeric value                       
[27] "Average of Mean - Frequency domain representation of body acceleration from jerk on the X axis of the phone" Numeric value             
[28] "Average of Mean - Frequency domain representation of body acceleration from jerk on the Y axis of the phone" Numeric value             
[29] "Average of Mean - Frequency domain representation of body acceleration from jerk on the Z axis of the phone" Numeric value             
[30] "Average of Mean - Frequency domain representation of body angular velocity on the X axis of the phone" Numeric value                   
[31] "Average of Mean - Frequency domain representation of body angular velocity on the Y axis of the phone" Numeric value                   
[32] "Average of Mean - Frequency domain representation of body angular velocity on the Z axis of the phone" Numeric value                   
[33] "Average of Mean - Frequency domain representation of body acceleration magnitude" Numeric value                                        
[34] "Average of Mean - Frequency domain representation of body acceleration from jerk magnitude" Numeric value                              
[35] "Average of Mean - Frequency domain representation of body angular velocity magnitude" Numeric value                                    
[36] "Average of Mean - Frequency domain representation of body angular velocity from jerk magnitude" Numeric value                          
[37] "Average of Standard Deviation - Time domain representation of body acceleration on the X axis of the phone" Numeric value              
[38] "Average of Standard Deviation - Time domain representation of body acceleration on the Y axis of the phone" Numeric value              
[39] "Average of Standard Deviation - Time domain representation of body acceleration on the Z axis of the phone" Numeric value              
[40] "Average of Standard Deviation - Time domain representation of gravity acceleration on the X axis of the phone" Numeric value           
[41] "Average of Standard Deviation - Time domain representation of gravity acceleration on the Y axis of the phone" Numeric value           
[42] "Average of Standard Deviation - Time domain representation of gravity acceleration on the Z axis of the phone" Numeric value            
[43] "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the X axis of the phone"  Numeric value   
[44] "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the Y axis of the phone"  Numeric value   
[45] "Average of Standard Deviation - Time domain representation of body acceleration from jerk on the Z axis of the phone" Numeric value    
[46] "Average of Standard Deviation - Time domain representation of body angular velocity on the X axis of the phone"    Numeric value       
[47] "Average of Standard Deviation - Time domain representation of body angular velocity on the Y axis of the phone"    Numeric value       
[48] "Average of Standard Deviation - Time domain representation of body angular velocity on the Z axis of the phone"           Numeric value
[49] "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the X axis of the phone"  Numeric value  
[50] "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the Y axis of the phone"  Numeric value  
[51] "Average of Standard Deviation - Time domain representation of body angular velocity from jerk on the Z axis of the phone"  Numeric value  
[52] "Average of Standard Deviation - Time domain representation of body acceleration magnitude"    Numeric value                            
[53] "Average of Standard Deviation - Time domain representation of gravity acceleration magnitude"          Numeric value                   
[54] "Average of Standard Deviation - Time domain representation of body acceleration from jerk magnitude"  Numeric value                    
[55] "Average of Standard Deviation - Time domain representation of body angular velocity magnitude"    Numeric value                        
[56] "Average of Standard Deviation - Time domain representation of body angular velocity from jerk magnitude"   Numeric value               
[57] "Average of Standard Deviation - Frequency domain representation of body acceleration on the X axis of the phone"  Numeric value         
[58] "Average of Standard Deviation - Frequency domain representation of body acceleration on the Y axis of the phone"  Numeric value        
[59] "Average of Standard Deviation - Frequency domain representation of body acceleration on the Z axis of the phone"  Numeric value        
[60] "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the X axis of the phone" Numeric value  
[61] "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the Y axis of the phone" Numeric value  
[62] "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk on the Z axis of the phone" Numeric value  
[63] "Average of Standard Deviation - Frequency domain representation of body angular velocity on the X axis of the phone" Numeric value     
[64] "Average of Standard Deviation - Frequency domain representation of body angular velocity on the Y axis of the phone" Numeric value     
[65] "Average of Standard Deviation - Frequency domain representation of body angular velocity on the Z axis of the phone" Numeric value     
[66] "Average of Standard Deviation - Frequency domain representation of body acceleration magnitude" Numeric value                          
[67] "Average of Standard Deviation - Frequency domain representation of body acceleration from jerk magnitude" Numeric value                
[68] "Average of Standard Deviation - Frequency domain representation of body angular velocity magnitude"  Numeric value                     
[69] "Average of Standard Deviation - Frequency domain representation of body angular velocity from jerk magnitude" Numeric value 


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

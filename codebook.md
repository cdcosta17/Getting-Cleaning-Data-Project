##Codebook for the Human Activity Recognition Dataset

The data from the [UCI Machine Learning Repositiory](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), that was built from the data of 30 test subjects who performed
activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.


<h2>Dataset Information</h2>
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

<h2>Attribute Information </h2>
For each record in the dataset it is provided: 
1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
2. Triaxial Angular velocity from the gyroscope. 
3. A 561-feature vector with time and frequency domain variables. 
4. Its activity label. 
5. An identifier of the subject who carried out the experiment.

<h3> Variable information</h3> 
1. **features**: contains the contents of the features.txt file, which holds the correct names of the data in the x_test and x_train datasets
2. **activityType**: contains the data from activity_labels.txt 
3. **xTrain**: contains data from X_train.txt
4. **yTrain**: contains data from y_train.txt
5. **subjectTrain**: contains the data from subject_train.txt
6. **trainSet**: contains merged data from xTrain,yTrain and subjectTrain
7. **xTest**: contains data from X_test.txt
8. **yTest**: contains data from y_test.txt
9. **subjectTest**: contaons data from subject_test.txt
10. **testSet**: contains merged data from xTest, yTest and subjectTest
11. **finalSet**: contains data combined from trainSet and testSet
12. **measurementVector**: a logical vector that returns true for only columns with Id, mean and standard deviation. It is used to subset the columns containing the means and standard deviations
12. **colNames**: a vector containing the column names in the finalSet dataset
13. **finalSetSub**: contains a subset of the finalSet data set and excludes the activityType column
14. **tidySet**: contains the aggregated data by the means of each variable for each activity and each subject

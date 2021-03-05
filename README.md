# Description
The script for prepare tidy dataset. This tidy dataset contains values for
preprocessed accelerometer and gyroscope signal characteristics
(mean values and standard deviation) in X, Y, Z projections and
their magnitudes: body acceleration, gravity acceleration, body jerk,
angular jerk, rotation position.
These characteristics were averaged for each pair of subject (30 persons)
and activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING).

# How to run
    install.packages("dplyr")
    install.packages("codebook")
    source("run_analysis.R")
Tested on Windows 10, RStudio 1.4, R 4.0.3

# Project structure
    .
    └── human-activity-recognition
        ├── data
        │   ├── raw
        |   │   └── UCI HAR Dataset
        |   │       ├── activity_labels.txt
        |   │       ├── features_info.txt
        |   │       ├── features.txt
        |   │       ├── README.txt
        |   │       ├── test
        |   │           ├── Inertial Signals
        |   │           |   ├── body_acc_x_test.txt
        |   │           |   ├── body_acc_y_test.txt
        |   │           |   ├── body_acc_z_test.txt
        |   │           |   ├── body_gyro_x_test.txt
        |   │           |   ├── body_gyro_y_test.txt
        |   │           |   ├── body_gyro_z_test.txt
        |   │           |   ├── total_acc_x_test.txt
        |   │           |   ├── total_acc_y_test.txt
        |   │           |   └── total_acc_z_test.txt
        |   │           ├── subset_test.txt
        |   │           ├── X_test.txt
        |   │           └── y_test.txt
        |   │       └── train
        |   │           ├── Inertial Signals
        |   │           |   ├── body_acc_x_train.txt
        |   │           |   ├── body_acc_y_train.txt
        |   │           |   ├── body_acc_z_train.txt
        |   │           |   ├── body_gyro_x_train.txt
        |   │           |   ├── body_gyro_y_train.txt
        |   │           |   ├── body_gyro_z_train.txt
        |   │           |   ├── total_acc_x_train.txt
        |   │           |   ├── total_acc_y_train.txt
        |   │           |   └── total_acc_z_train.txt
        |   │           ├── subset_train.txt
        |   │           ├── X_train.txt
        |   │           └── y_train.txt
        │   └── processed
        │       └── tidy.csv
        ├── README.md
        ├── CodeBook.md
        ├── run_analyses.R
        ├── utils.R
        └── .gitign 

# Processing process
1. Merges the training and the test sets to create one data set and
   appropriately labels the data set with descriptive variable names.
2. Extracts only the measurements on the mean and standard deviation
   for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set
   with the average of each variable for each activity and each subject.
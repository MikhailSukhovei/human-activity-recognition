library(dplyr)

source("utils.R")


# Read and unzip the data to ./data/raw directory
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (file.exists(file.path(".", "data", "raw", "UCI HAR Dataset"))) {
    message("data has already been loaded")
} else {
    message("start loading data...")
    load_unpack_zip(data_url)
    message("data loaded successfully")
}

# file paths (see project structure in README.md)
data_path <- file.path(".", "data", 'raw', "UCI HAR Dataset")
processed_path <- file.path(".", "data", 'processed')

X_train_path <- file.path(data_path, "train", "X_train.txt")
y_train_path <- file.path(data_path, "train", "y_train.txt")
X_test_path <- file.path(data_path, "test", "X_test.txt")
y_test_path <- file.path(data_path, "test", "y_test.txt")

subject_train_path <- file.path(data_path, "train", "subject_train.txt")
subject_test_path <- file.path(data_path, "test", "subject_test.txt")

features_path <- file.path(data_path, "features.txt")
activity_labels_path <- file.path(data_path, "activity_labels.txt")

# 1. Merges the training and the test sets to create one data set and
#    appropriately labels the data set with descriptive variable names.
subject_train <- read.table(subject_train_path)
X_train <- read.table(X_train_path)
y_train <- read.table(y_train_path)

subject_test <- read.table(subject_test_path)
X_test <- read.table(X_test_path)
y_test <- read.table(y_test_path)

train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
all_data <- rbind(train_data, test_data)

col_names <- c("subject", "activity_label", read.table(features_path)$V2)
names(all_data) <- col_names

# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement.
mean_cols <- grep("mean\\(\\)", names(all_data))
std_cols <- grep("std\\(\\)", names(all_data))

all_data <- all_data[ , c(1:2, mean_cols, std_cols)]

# 3. Uses descriptive activity names to name the activities in the data set.
activity_names <- read.table(activity_labels_path)$V2

all_data$activity_label <- activity_names[all_data$activity_label]

# 4. Appropriately labels the data set with descriptive variable names.
# The characters "(", ")" and "-" cannot be written to the .csv file.
names(all_data) <- gsub("\\(\\)", "", names(all_data))
names(all_data) <- gsub("-", ".", names(all_data))

# For some reason, there are some functions called "... BodyBody ...". This is
# probably a bug because there is no such type of names in features_info.txt 
names(all_data) <- gsub("BodyBody", "Body", names(all_data))

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
num_features <- dim(all_data)[2]
tidy_data <- all_data %>%
    group_by(subject, activity_label) %>%
    summarise_at(.vars = names(.)[3:num_features], .funs = c("mean"))

# Save the data
if (!dir.exists(processed_path)) {
    dir.create(processed_path)
}
write.csv(tidy_data,
          file = file.path(processed_path, "tidy.csv"),
          row.names = FALSE)

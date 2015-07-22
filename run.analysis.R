library(reshape2)

# dowload and unzip file 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(fileUrl,destfile <- './data/project.zip',method = 'curl')
if(!file.exists("UCI HAR Dataset")) {unzip("./data/project.zip")}

# load activity labels and features 
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
ActivityLabels[,2] <- as.character(ActivityLabels[,2])

# extract measurements on mean&std
Features <- read.table("UCI HAR Dataset/features.txt")
FeaturesIndex <- grep(".*mean.*|.*std.*",Features[,2])   #index 
FeaturesWanted <- Features[FeaturesIndex, 2]
FeaturesWanted <- gsub("-mean","Mean",FeaturesWanted)
FeaturesWanted <- gsub("-std","Std",FeaturesWanted)
FeaturesWanted <- gsub("[()-]","",FeaturesWanted)

# Load train_data and combine
TrainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
TrainMeasure <- read.table("UCI HAR Dataset/train/X_train.txt")[FeaturesIndex] #pick wanted columns
TrainActivity <- read.table("UCI HAR Dataset/train/y_train.txt")
Train <- cbind(TrainSubject, TrainActivity, TrainMeasure)

# Load test_data and combine
TestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
TestMeasure <- read.table("UCI HAR Dataset/test/X_test.txt")[FeaturesIndex]
TestActivity <- read.table("UCI HAR Dataset/test/y_test.txt")
Test <- cbind(TestSubject, TestActivity, TestMeasure)

# Combine train&test data and label with descriptive variable names
mergedData <- rbind(Train, Test)
colnames(mergedData) <- c("Subject","Activity",FeaturesWanted)

# Factorize activity&subject and
# uses descriptive activity names to name the activities in the data set
mergedData$Subject <- as.factor(mergedData$Subject)
mergedData$Activity <- factor(mergedData$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])

# create a tidy data 
mergedData.melted <-  melt(mergedData,id = c("Subject","Activity"))
mergedData.mean <- dcast(mergedData.melted, Subject+Activity ~ variable, mean)

# create a table 
write.table(mergedData.mean, file = "tidy.txt", row.names = FALSE, quote = FALSE) 



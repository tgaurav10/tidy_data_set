test_x <- read.table("test/X_test.txt")   //reads the data from the test set
train_x <- read.table("train/X_train.txt")  //reads the data from the training set
test_sub <- read.table("test/subject_test.txt") //reads the subjects from the test set
train_sub <- read.table("train/subject_train.txt")  //reads the subjects from the training set
test_y <- read.table("test/y_test.txt") //reads the activity labels from the test set
train_y <- read.table("train/y_train.txt") //reads the activity labels from the training set
features <- read.table("features.txt")  //reads the features

colnames(test_x) <- features[,2]  //changes the column names to descriptive variable names
colnames(train_x) <- features[,2] //changes the column names to descriptive variable names 

test <- data.frame(Subject= test_sub[,1], Activity= test_y[,1], test_x[,grepl("*-(mean|std)",colnames(test_x))])
//extracts only those variables which contain the mean and std values

train <- data.frame(Subject= train_sub[,1], Activity= train_y[,1], train_x[,grepl("*-(mean|std)",colnames(train_x))])
//extracts only those variables which contain the mean and std values

dat <- rbind(test, train) //row binds the training and test data sets

act <- read.table("activity_labels.txt")  //reads in the activity names

dat <- merge(act,dat,by.x=1,by.y=2) //merges them on same indexes for the activites

colnames(dat)[2]="Activity" //changes the column name (in the act object) to "Activity" from "v1"

dat[1] <- NULL //drops the now redundant "Activities" column

write.table(dat,file=file("tidy_data.txt","wb"))  //finally writes the object to the file

//this is for the fifth part
library(reshape2) //loading necessary packages
dataMelt <- melt(dat, id=c("Activity","Subject"), measure.vars=colnames(dat)[3:81]) 
//reshaping data according to the variables and their values

ActivityCast <- dcast(dataMelt, Activity ~ variable, mean) //calculating the mean of the variables for each activity

SubjectCast <- dcast(dataMelt, Subject ~ variable, mean) //calculating the mean of the variables for each subject

test_x <- read.table("test/X_test.txt")
train_x <- read.table("train/X_train.txt")
test_sub <- read.table("test/subject_test.txt")
train_sub <- read.table("train/subject_train.txt")
test_y <- read.table("test/y_test.txt")
train_y <- read.table("train/y_train.txt")
features <- read.table("features.txt")
colnames(test_x) <- features[,2]
colnames(train_x) <- features[,2]
test <- data.frame(Subject= test_sub[,1], Activity= test_y[,1], test_x[,grepl("*-(mean|std)",colnames(test_x))])
train <- data.frame(Subject= train_sub[,1], Activity= train_y[,1], train_x[,grepl("*-(mean|std)",colnames(train_x))])
dat <- rbind(test, train)
act <- read.table("activity_labels.txt")
dat <- merge(act,dat,by.x=1,by.y=2)
colnames(dat)[2]="Activity"
dat[1] <- NULL
write.table(dat,file=file("tidy_data.txt","wb"))
library(reshape2)
dataMelt <- melt(dat, id=c("Activity","Subject"), measure.vars=colnames(dat)[3:81])
ActivityCast <- dcast(dataMelt, Activity ~ variable, mean)
SubjectCast <- dcast(dataMelt, Subject ~ variable, mean)
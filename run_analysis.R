#read the data files and combine into a single set
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
test<-read.table("./UCI HAR Dataset/test/X_test.txt")

#combine into a single data set
dataset<-rbind(train, test)

#read and label the features
features<-read.table("./UCI HAR Dataset//features.txt")
colnames(features)<-c("Id", "Name")

#find the indexes of the mean and stdev columns 
selcols<-features[grep("mean()|std()", features$Name),c(1:2)]

#build the mainset from larger dataset and apply the column names 
mainset<-dataset
colnames(mainset)<-features[,2]
#extract just the mean and stdev columns from the dataset
mainset<-mainset[, selcols[,1]]

#read labels
activity_labels<-read.table("./UCI HAR Dataset//activity_labels.txt")

#apply and merge train and test activities labels 
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
y_train$Activity<-activity_labels[y_train$V1,2]
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
y_test$Activity<-activity_labels[y_test$V1,2]
y_t <- rbind(y_train, y_test)

#combine the labels with the main dataset
labeled_set<-cbind(Activity=y_t$Activity, mainset)

#read subject data and join with the labeled_set to form the final set
subj_train<-read.table("./UCI HAR Dataset/train//subject_train.txt")
subj_test<-read.table("./UCI HAR Dataset/test//subject_test.txt")
subj<-rbind(subj_train, subj_test)
final_set<-data.table(cbind("Subject"=subj[,1], labeled_set))
tidy_set<-final_set[, lapply(.SD,mean), by=list(Activity, Subject)]
#finally, sort the tidy_set by activity and subject to make it easier to read
tidy_set<-tidy_set[order(tidy_set$Activity, tidy_set$Subject)]
#write the set to a file
write.table(x = tidy_set, file = "./tidy_set.txt", row.name=F, sep=",")


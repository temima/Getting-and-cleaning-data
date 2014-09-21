run_analysis<-function(){

#read test and train data from local file
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
x_features<-read.table("./UCI HAR Dataset/features.txt")

#combine test and training by first binding the test and training sets respectively by columns and then rbinding the 2 sets together
test<-cbind.data.frame(x_test,subject_test,y_test)
train<-cbind.data.frame(x_train,subject_train,y_train)
all_data=rbind.data.frame(test,train)

names(all_data)[length(all_data)-1]="Subject"
names(all_data)[length(all_data)]="Activity"

#extracted only columns measuring mean or std related data using grep on "mean and "std" and then indexing to select the relevant columns
x_features<-x_features[,2]
mean_std_cols<-grep("mean|std",x_features,ignore.case=TRUE)
almost_tidy_data<-all_data[,c(mean_std_cols,length(all_data)-1,length(all_data))]


#assigned descriptive activity levels to the different activities using the "factor" function
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
almost_tidy_data$Activity<-factor(almost_tidy_data$Activity,levels=activity_labels[,1],labels=activity_labels[,2])

#named variables using the feature names given in the feature file (using same index i used for selecting mean and std related variables so features match the variables.)
names(almost_tidy_data)[1:(length(almost_tidy_data)-2)]<-c(as.character(x_features[mean_std_cols]))

#create tidy dataset by melting the data with "subject" and "Activity" as factors and then using dcast
library(reshape2)
melted_data <- melt(almost_tidy_data, id=c("Subject","Activity"),measure.vars=names(almost_tidy_data)[1:86])
tidy_data<-dcast(z, Subject+Activity ~ variable, mean)
}
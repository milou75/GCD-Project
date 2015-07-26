########################################################################
## Step 0 - Getting (unzipped) Dataset in UCI-HAR-Dataset Directory (under working directory)
########################################################################
if (file.exists("./DOWNLOADED")){unlink("./DOWNLOADED", recursive=TRUE)}
dir.create("DOWNLOADED")
if (file.exists("./TEMP")){unlink("./TEMP", recursive=TRUE)}
dir.create("TEMP")
library(reshape2) #to be used in Step 5

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./DOWNLOADED/UCI-HAR-Dataset.zip",method="curl")
unzip("./DOWNLOADED/UCI-HAR-Dataset.zip", exdir=".")

## Note : DOWNLOADED Directory is left for reference only
rm(fileUrl)

########################################################################
## Step 1 -Merging Datasets
########################################################################

# Step 1 Substep 0 - Load 6 Tables in Memory (Prefix S10 stands for Step 1 Substep 0)
S10_subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
S10_X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
S10_y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
S10_subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
S10_X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
S10_y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

## Step 1 - Substep 1 - Merge "Horizontally" Subject, Activity (y file)
##                      and X File for both training and tests sets
S11_subject_y_X_train<-cbind(S10_subject_train, S10_y_train, S10_X_train)
S11_subject_y_X_test<-cbind(S10_subject_test, S10_y_test, S10_X_test)

## Step 1 - Substep 2 - Merge "Vertically" (i.e., Concatenate)
#                       training and tests sets in a full set
S12_fullDS<-rbind(S11_subject_y_X_train,S11_subject_y_X_test)
## All Observations are now together in an object but not sorted by subject_id

## Step 1 - Substep 3 and 4 - Reorder the FullDS based on the subject id
##                      and keep order of observations for each subject.
##
## Substep 3) Insert an (absolute) obs_id column at the left of the DF.
##    (obs_id in column 1. Sequential values (1:nrow of the full DS)
obs_id<-matrix(1:nrow(S12_fullDS), nrow=nrow(S12_fullDS))
S13_fullDS<-cbind(obs_id, S12_fullDS)
#
## Substep 4) Reorder the Full DS by
##    1) Subject id (1 to 30) and then
##    2) by obs_id (in order to maintain the initial order of observations
##       for each subject.) 
#
# Next line creates a permutation vector by Subject_Id (Col #2)
# and obs_id (Col #1) 
DS_order<-order(S13_fullDS[,2], S13_fullDS[,1])
# Next Line applies the permutaion vector and creates the Full Ordered DS
Full_Ordered_DS<-S13_fullDS[DS_order,]

# Remove temporaryobjects
rm(S10_subject_train)
rm(S10_X_train)
rm(S10_y_train)
rm(S10_subject_test)
rm(S10_X_test)
rm(S10_y_test)
rm(S11_subject_y_X_train)
rm(S11_subject_y_X_test)
rm(S12_fullDS)
rm(obs_id)
rm(S13_fullDS)
rm(DS_order)

########################################################################
## Step 2 - Extract Useful Measurements Only
##          (i.e., Get rid of the others measurements columns 
##                 plus the obs_id column)
########################################################################

# 1) Read Features Tables that contains list of features and column position
Features<-read.table("./UCI HAR Dataset/features.txt")

# 2) Select measures that contain "mean()" or "std()" in their label.
vector_selected_features<-(grepl("mean()", fixed=TRUE, Features[,2])
                           | grepl("std()", fixed=TRUE, Features[,2]))

# 3) Create a Selected Features DF (it is a subset of Features table)
Selected_Features<-subset(Features,vector_selected_features==TRUE,c(1,2))

#4) Prepare a vector of columns to be kept for the subset operation
#   From Full_Ordered_DS:
#   - We eliminate column #1 (obs_id).
#   - We keep Columns #2 (Subject) and #3 (Activity)
#   - We keep the 66 colums selected in Selected_Features but their position
#     has to be shifted by 3 (column #1 in original measurements is #4 in full dataset)
Selected_Features[,1]<-Selected_Features[,1]+3
Selected_Columns<-c(2,3,Selected_Features[,1])

## 5) Now we create the Final DS with all observations and only relevant
## measurement columns
Final_DS<-subset(Full_Ordered_DS,,Selected_Columns)

# Remove temporary objects
rm(Features)
rm(Full_Ordered_DS)
rm(vector_selected_features)
rm(Selected_Columns)

########################################################################
## Step 3 - Descriptive Activity Names
########################################################################
for (i in 1:nrow(Final_DS)){
        if(Final_DS[i,2]==1){Final_DS[i,2]<-"WALKING"}
        if(Final_DS[i,2]==2){Final_DS[i,2]<-"WALKING_UPSTAIRS"}
        if(Final_DS[i,2]==3){Final_DS[i,2]<-"WALKING_DOWNSTAIRS"}
        if(Final_DS[i,2]==4){Final_DS[i,2]<-"SITTING"}
        if(Final_DS[i,2]==5){Final_DS[i,2]<-"STANDING"}
        if(Final_DS[i,2]==6){Final_DS[i,2]<-"LAYING"}
}

########################################################################
## Step 4 Label Columns
########################################################################
names(Final_DS) [1] <-"Subject"
names(Final_DS) [2] <-"Activity"

for (i in 3:ncol(Final_DS)){
        names(Final_DS) [i]<-as.character(Selected_Features[i-2,2])
}

# Next Line to write the Full DS in a File (with ColNames)
write.table(Final_DS,"./TEMP/FINAL_DS.txt",row.names=FALSE,col.names=TRUE)

########################################################################
## Step 5 - Create Second Summary Dataset (The one t)
########################################################################

# 1 - Prepare a vector of columns that will be the variables in the Summary DS
# (i.e. the 66 selected measurements colums.)
vector_variables<-c()
for(i in 1:nrow(Selected_Features)){
    vector_variables<-c(vector_variables,as.character(Selected_Features[i,2]))    
}

# 2 - Create a (long) intermediate MELT_DS table (Subject, Activity, Var name, value)
MELT_DS<-melt(Final_DS, id=c("Subject", "Activity"), measure.vars=c(vector_variables))

# 3 - Cast and mean the previous table to get the target DS
Final_DS_Summary<-dcast(MELT_DS, Subject+Activity ~ variable, mean)

# 4 - Rename Columns 3:68 to indicate their meaning
for (i in 3:ncol(Final_DS_Summary)){
        names(Final_DS_Summary) [i]<-paste("Mean -", names(Final_DS_Summary) [i])
}

# 5 - Write the DS in a File to be delivered as project output (with ColNames)
write.table(Final_DS_Summary,"./TEMP/Final_DS_Summary.txt",row.names=FALSE,col.names=TRUE)

# Remove temporary objects
rm(Selected_Features)
rm(vector_variables)
rm(MELT_DS)
rm(i)
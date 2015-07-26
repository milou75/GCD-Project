**============================================================**
**README - Coursera - Getting and Cleaning Data - Course Project**
**===========================================================**
**Configuration**
R version 3.1.3 (2015-03-09) — "Smooth Sidewalk"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

**Script Structure**
The script is organized as follows:
- Step 0 : Preliminary : Setting environment, getting data from the web and unzip dataset
- Step 1 to Step 5 are aligned to project's five questions 1) to 5). (Note that Steps 3 and 4 are rather straightforward and do not require extended comments)

****====================================================**
**Step 0 - Getting Data and Preparing the Environment**
**====================================================**
Create a directory and set your working directory (.) as this directory.

Step 0 downloads the zip file in the ./DOWNLOADED directory and unzip the dataset files under . (./UCI HAR Dataset, subdirectories and files)

**Note** : at the end of the step the ./DOWNLOADED directory is still there for reference.   

**==========================================**
**Step 1 - Merging Train and Test Dataset** 
**==========================================**

From 2*3 files to 1 full ordered DF containing the same information. The DF is sorted by subjects id (1..30).
**CHOICE** : I have chosen to preserve the original observation order for each subject). This is not required by the project but I suspects there is an implicit chronology between observation.

Step 1 is divided in subsets (0 to 4)

**Substep 0**
**  - - - - - **

Read the 2*3 files in memory : subject, y and X files for test and train phases.

Paese note that:
   - train dataset contains observations about subjects (1, 3, 5 …. 23, 25, 26, 27, 28, 29, 30)
   - test dataset contains observations about subjects (2, 4, ….. , 24)

**Substep 1**
**  - - - - - - 
**Merge "horizontally" (Subject, y, X) for the train and test with cbind(). Resulting objects are prefixed with S11_ (Step 1 Substep 1)

**Substep 2**
**  - - - - - - -**
Merge and concatenates "vertically" train and test DF with rbind.
The result file *S12_FullDS* concatenates observations for subjects (1, 3, 5 …. 23, 25, 26, 27, 28, 29, 30, 2, 4, ….. , 24) 

**Substeps 3 and 4**
**  - - - - - - - - - **
I decided to sort the resulting DF 1) by subject and 2) to keep the initial order of observations for each subject. This requires a bit of preparation in Step 3.

**Substep 3** : I insert (at left of the DF) an extra column that is an absolute obs_id (1:10299)
Note: this extra column will be removed in Step 2.

**Substep 4** : Sort the DF by subject (col #2) and then  obs_id (col#1). This is done by creating a permutation vector (order function) and then by applying this permutation.
Full_Ordered_DS contains measurements for subjects (1,2,3,4,5….24,25..30) with obs_id in ascending order for each subject.

**=================================================**
**Step 2 - Extract Useful Measurements Columns Only** 
**=================================================**
This Step 2 starts from Full_Ordered_DS as result of Step 1 and only keep the required columns (subject, activity, mean() and std() columns. The others are removed.

**CHOICE** I have decided to strictly apply "mean()" and "std()" strings in the selection of columns. This results in 66 columns (Other choices would have led to more columns).

Step 2 is divided in 5 substeps.
  
**1**)
**  - - **
First, read the Features text file (provided in the original DS) that lists features and their position (1..561) in the X files.

**2**)
**— - **
Create a logical vector that marks (=TRUE) only the columns that match EXACTLY the "mean()" or "std()" pattern. (This is achieved using fixed=TRUE in grepl function.)

Note : there are 66 TRUE in the vector. (Default value fixed=FALSE in grapple would have selected more columns).

**3** )
**— - **
Subset the Features DF to select only the selected columns (position and label) in Selected_Features DF. 66 rows are selected with 2 column each : position and label.

**4**)
**— -
**Prepare a vector of columns to be kept in the final DS.
From the Full_Ordered_DS we need :
		- To remove col #1 (obs_id)
		- To keep col #2 (Subject) and #3 (Activity)
		- To keep 66 columns selected in Selected_Features but their position has to be shifted by 3 (column #1 in original measurements is #4 in the full dataset)

Note : There are 68 Selected Columns (2+66)

**5**)
**— -**
Built the Final Dataset subsetting the Full_Ordered_Dataset

Final_DS is (10299 rows * 68 columns)

**============================================**
**Step 3 - SET ACTIVITY NAMES ** 
**============================================**

An obvious for () loop !

**============================================**
**Step 4 - SET COLUMNS NAMES ** 
**============================================**

(subject, Activity, 66 original columns names as provided features.txt file)

At the end : Write the Final_DS in a File for reference

**============================================**
**Step 5 - CREATE THE SECOND SUMMARY DS ** 
**============================================**

**CHOICE** I have decided to present the Summary DS using the wide format.

Therefore, starting from Final_DS dataset we have to transform it twice :
 
1) to a long format and 
2) to a wide format (180 subject-activity rows and 66 measurement columns that contain mean values for each subject-activity).

This step is divided in 5 substeps:

1) Create a vector variables to select. This prepare the melt function.

2) Then melt the Final_DS object by (subject, activity, variable, value) in an intermediate MELT_DS table. This results in a 679734 rows and 4 columns long table.

3) dcast the MELT_DS table to create the target object and calculating the mean for each 180 subject/activity rows and 66  variables. This results in the Final_DS_Summary DF (180 * 68 columns)

4) Rename Final_DS_Summary columns labels 2:68 with the "Mean -" prefix

5) Write Final_DS_Summary in a txt file to be delivered to Coursera.








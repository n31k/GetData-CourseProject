<<<<<<< HEAD
<<<<<<< HEAD
# README
'Project directory' here denotes the folder that contains a test and a train folder. 
Running the 'run_analysis.r' script in the Project directory will create two new objects in your workspace: 1) 'SamsungList', which is a list represeantation of all the Project directory contents and 2) 'SamsungLongData' with four columns: Subject, Activity, Feature, Value (see CodeBook).
## How the script works
### Reading Functions
'read_dir' is taylored for the directory structure of these particular data, i.e. a 'test', and a 'train' folder, with useful text files in each, and one subdirectory with inertial data. The function takes 'test' or 'train' as an argument, and reads as lines the txt files of the respective folder, the subdirectory included. Returns a list with two elements. One for the folder (3 elements: subject, data, activity) and one for the subdirectory (9 elements, refer to source data set codebook). Actually, the subdirectory is not used in any analyses. 
'read_all' exploits the previous function and harvests all data from the project directory, including the features and activity files. It returns a list with two elements, 'test' and 'train', each of which is itself a list structured as explained in the read_dir function outpout, right above. 
### Processing Data Functions
'return_data_frames' performs all the following operations. It takes a list as an argument,  structured as the output of 'read_all' (see above). It converts the lines found in the second element of both the 'test' and 'train' lists, from character to numeric matrix, and then to data.frame (see 'subject_matrix' function below). Then it combines the 'test' and 'train' data frames. Retains only the 'mean' and 'std' involving features. Trims and treats the feature labels. Assigns the feature labels to columns. Corrects the activity labels and assigns them to a new column. Adds a subject column. Adds a set column (so that the subset of each subject is tracable). Aggregates data to the average of each measure. Melts the data. Returns a list with two elements. The first is the wide data frame, the second is the long one. 
'subject_matrix' converts the character string read by read_all (see above) to a numeric matrix with 561 columns pertaining to each subject. It is a helper to the read_all function, above.

=======
=======
>>>>>>> 7d5885fc5d9b2cc4eec570050c3fac9d610b94f4
GetData-CourseProject
=====================

Project repository for the Coursera Getting and Cleaning Data Course.
<<<<<<< HEAD
>>>>>>> 7d5885fc5d9b2cc4eec570050c3fac9d610b94f4
=======
>>>>>>> 7d5885fc5d9b2cc4eec570050c3fac9d610b94f4

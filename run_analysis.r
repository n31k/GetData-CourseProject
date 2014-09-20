### Instructions ###
'
You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

    From the data set in step 4, creates a second, independent tidy data set with 
	the average of each variable for each activity and each subject.

'

### Functions ###

read_dir <- function(x){ 
setwd(dirs[[x]]) 
my_dir <- dir(pattern = "txt$")
setNames(lapply(my_dir, readLines), gsub('.txt', '', my_dir))
}
### Within a directory, locates the text files, and reads them as separate lines.
### Returns a list of character vectors.


read_all <- function(){
### This function is called from within the Project directory, see README.
### It exploits the previous, so that all given files, are available
### in the R workspace, within a grand list object. 
### Return Value is a list with a train and a test sublist.
### The first element of each sublist (in train or test) is the data. The second is the
### inertial data. Within the first element, the first vector is the subject, the second 
### the features, and the third the activities. Checking out the structure with str()
### visualzes this much more clearly.
out = list()
for (folder in c('test', 'train')){
setwd(dirs$project)
x <- read_dir(folder)
y <- read_dir('inert')
out[[folder]] <- list(x, y)
}
setwd(dirs$project)
for (i in c('features', 'activity_labels')){
out[[i]] <- readLines(paste(i, '.txt', sep = ''))
}

out

}


subject_matrix <- function(x) {
### Because each subject data are represented as a long character vector,
### This function treats each of these vectors so that a long numeric vector
### is returned. This is convenient because the number of each vector is constant,
### but it certainly is not robust for use in other occasions.
xyz <- as.numeric(unlist(strsplit(as.character(x), split = ' '), recursive = F))
xyz[!is.na(xyz)]
}


return_data_frames <- function(x){
### This is a long function, which implements all steps required in the instructions.
### It takes as an arguments a list object created by the custom read_all function.
### Then it analyzes each subjects data, in both the 'test', and 'train' set separately,
### assigns the features as colnames. It corrects both the features' and the activities' labels,
### selects the required columns, binds the two data frames, and aggregates all observations
### within subjects and activities by their mean. Returns a list, whose first element is the 
### wide, complete data.frame, and the second the long, aggregated one. 

out <- list()
### Holder list to put the two data.frames in.

for (i in c('test', 'train')){
### The following process will take place twice, once for the train set
### and once for the test set. The product of each run is a data.frame. 
### The two data frames are then to be combined. 

xyz <- lapply(x[[i]][[1]][[2]], subject_matrix)
### - lapply -  first argument is the X_test or X_train element
### which consists > 7000 pcs of 561-element strings
### which in turn are in need of a 'names' vector - the features!

### - subject_matrix - see functions; The data at the time being are 
### represented as a long character vector for each subject. This function
### returns a long numeric vector, which is to be organized with matrix().

xyz <- data.frame(matrix(unlist(xyz), ncol = 561, byrow = T))
### Finally, after organizing the numeric vector by the -known - number of features - 
### a data frame is returned. This, I attach to the other variables,
### i.e. the subject and the activity, but only after I rename the activities.

xxx <- factor(x[[i]][[1]][[3]])
### I assign the activity labels to a new factor. Indices will make sense
### if you consider that the functions operates on a list object returned by
### custom function read_all, with known structure (see function).
### Here, the 'i' variable stands either for the 'test', or the 'train' set.
### [[1]] the useful data, not the inertial ones, [[3]] the activities.


levels(xxx) <- gsub('\\d\\s|\\_|ING|STAIRS', '',x$activity_labels)
### With gsub I trim the labels to make them more convenient.
colnames(xyz) <- x$features
### At last, I assign the features as column names.


xyz$activity <- xxx # attach worked labels to data frame
xyz$subject <- factor(x[[i]][[1]][[1]]) # attach subjects
xyz$set <- i # attach the info that this record comes from the train or test set
out[[i]] <- xyz
### Each element will be accesible by its name in the returned list
}

### Combine the two data frames.
y <- rbind(out[[1]], out[[2]])

y2 <- y[562:564]
### Save the Activities, Subject and Set columns, from the
### impending regular expression avalanche.

y <- y[grep("mean|std",x$features)]
### Select only those column names that involve mean or std.

foo <- colnames(y) 
# Create a character vector to work with.

foo <- gsub('^\\d*\\s|-|\\(|\\)', '',foo ) 
### Apply regular expressions to get rid of spaces, digits and parentheses.
fume <- matrix(c('t', 'Time', 
				'mean', 'Mean', 
				'std', 'Std', 
				'f', 'Freq'), 
				byrow = T, ncol = 2)
### Having studied the names, I came up with these convenient pairs of
### substitutions, to avoid typing... and human errors.

for (row in 1:nrow(fume)){
foo <- sub(fume[row, 1], fume[row,2], foo)
}
### Apply substitutions with a loop.

y <- cbind(y, y2)
### Attach the Activity, Subject and Set columns back to the data frame.

colnames(y) <- c(foo, 'Activity', 'Subject', 'Set')
### Assign the treated vector as column names of the combined data frame.
### Plus the names of the Activity, Subject and Set columns.

require(reshape)
y2 <- aggregate(y[-c(80:82)], by = list(Subject = y$Subject, Activity =y$Activity), FUN = mean)
### Built in function, which splt the data frame according to the factors passed as a list to the 'by'
### argument, and summarizes all observations in these combination of factors with the function
### passed to the FUN argument, here the mean.
y2 <- melt(y2, id = c("Subject", "Activity"))
### Function from the reshape package which organizes observations in a repeated-measures fashion.
colnames(y2)[3:4] <- c("Feature", "Average")
### Tidying up the resulting data frame's column names.


out <- list(y, y2)
### Packaging the wide and the long data frame in a lst for shiping.
out
# Return the list with the two data frames. 
}



### Script ###


dirs <- as.list(setNames(c(getwd(), 'test', 'train', 'Inertial Signals'),
c('project', 'test', 'train', 'inert')))
### I defined this global object so that I can easily switch between directories,
### and do so with consistency. Note that dirs[[1]] returns the corresponding path
### itself. 

setwd(dirs$project)
SamsungList <- read_all()

SamsungLongData <- return_data_frames(SamsungList)[[2]]

### Custom functions, see functions below for details.
### str() command reveals the object structure, which can
### facilitate following the functions commentary.

str(SamsungLongData)



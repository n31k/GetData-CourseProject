#CodeBook
These data come from a study by Anguita et al (2012), where details on methodology and objectives can be found. In general, data was collected from 30 subjects across 6 activities. For each Subject*Activity a Samsung mobile device was used in order to collect data, via its embedded accelerometer and gyroscope. Measures were recorded with a frequency of 50Hz. The researchers treated the signals with Fourier-transformations and other procedures, explained in their own codebook. 
### Source Reference:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
www.smartlab.ws
## The data were treated as follows:
Only the measures involving means and standard deviations were kept in this data set. For each subject * activity, only the average of each measure was retained. 
Variable naming scheme was changed as follows: 'Time' suffix in the name of a variable indicates a time measurement, whereas 'Freq' denotes a Fourier-transformed frequency measurement. 'Mean' and 'Std' suffixes are self-explanatory. 'X', 'Y', 'Z' denote the axis to which the measurement refers. All other suffixes ('Acc' for accelerometer, 'Gyro' for gyroscope, 'Body' for body acceleration, 'Grav' for gravity acceleration, as well as other suffixes related to the signal transformations, 'Jerk' and 'Mag', are retained from the source data set. 
All measures ('features' in the source data set terminology) were treated as within-subject measurements. Thus, they are all levels of the 'Activity' factor variable in our data set. 
## Schematically:
### Subject
	1:30 factor: the code of each subject
### Activity
	1:6 factor: the label of each activity
	1 WALK ; 2 WALKUP ; 3 WALKDOWN ; 4 SITT ; 5 STAND ; 6 LAY
### Feature
	1:79 factor: the label of each measurement
	[Consult text above for suffix interpretation, as well as source code book.]
### Average
	numeric: Average Value of the measurement under discussion 
	for each subject * activity





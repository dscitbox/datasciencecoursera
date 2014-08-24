This is the readme file for the run_analysis.R file, required for the "Getting and Cleaning Data" project assignment

To run, the program expects the Samsung data in a subdirectory of the directory where the program is located
(e.g. ./UCI_HAR Dataset/...)
The program requires the data.table and plyr libraries.

General overview:
The script reads the training and the test sets and combines them into a single set using rbind
In order to set the dataset column names, the program:
  reads the features names from the feature text file, 
  removes any features that do not contain the strings mean() and std()
  uses the remaining features as a column filter to the dataset and sets the column names to the name of the features; the feature names are also used as descriptive variable names

Maps activities to training and test sets
Adds the activities and subjects as columns to the dataset

Finally, the tidy set is built by averaging all columns by activity and subject, using ddply, then sorted (for easy reading) by activity and subject

The result is written to tidy_set.txt in the same folder as the script


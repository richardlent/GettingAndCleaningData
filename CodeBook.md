CodeBook.md
================
Richard A. Lent

Codebook for Getting and Cleaning Data Course Project
-----------------------------------------------------

The 69 variables in the tidy data set `tidydata.csv`, produced by the `run_analysis.R` script, are:

     [1] "block"                    "activity"                
     [3] "subject"                  "tBodyAccMeanX"           
     [5] "tBodyAccMeanY"            "tBodyAccMeanZ"           
     [7] "tBodyAccStdX"             "tBodyAccStdY"            
     [9] "tBodyAccStdZ"             "tGravityAccMeanX"        
    [11] "tGravityAccMeanY"         "tGravityAccMeanZ"        
    [13] "tGravityAccStdX"          "tGravityAccStdY"         
    [15] "tGravityAccStdZ"          "tBodyAccJerkMeanX"       
    [17] "tBodyAccJerkMeanY"        "tBodyAccJerkMeanZ"       
    [19] "tBodyAccJerkStdX"         "tBodyAccJerkStdY"        
    [21] "tBodyAccJerkStdZ"         "tBodyGyroMeanX"          
    [23] "tBodyGyroMeanY"           "tBodyGyroMeanZ"          
    [25] "tBodyGyroStdX"            "tBodyGyroStdY"           
    [27] "tBodyGyroStdZ"            "tBodyGyroJerkMeanX"      
    [29] "tBodyGyroJerkMeanY"       "tBodyGyroJerkMeanZ"      
    [31] "tBodyGyroJerkStdX"        "tBodyGyroJerkStdY"       
    [33] "tBodyGyroJerkStdZ"        "tBodyAccMagMean"         
    [35] "tBodyAccMagStd"           "tGravityAccMagMean"      
    [37] "tGravityAccMagStd"        "tBodyAccJerkMagMean"     
    [39] "tBodyAccJerkMagStd"       "tBodyGyroMagMean"        
    [41] "tBodyGyroMagStd"          "tBodyGyroJerkMagMean"    
    [43] "tBodyGyroJerkMagStd"      "fBodyAccMeanX"           
    [45] "fBodyAccMeanY"            "fBodyAccMeanZ"           
    [47] "fBodyAccStdX"             "fBodyAccStdY"            
    [49] "fBodyAccStdZ"             "fBodyAccJerkMeanX"       
    [51] "fBodyAccJerkMeanY"        "fBodyAccJerkMeanZ"       
    [53] "fBodyAccJerkStdX"         "fBodyAccJerkStdY"        
    [55] "fBodyAccJerkStdZ"         "fBodyGyroMeanX"          
    [57] "fBodyGyroMeanY"           "fBodyGyroMeanZ"          
    [59] "fBodyGyroStdX"            "fBodyGyroStdY"           
    [61] "fBodyGyroStdZ"            "fBodyAccMagMean"         
    [63] "fBodyAccMagStd"           "fBodyBodyAccJerkMagMean" 
    [65] "fBodyBodyAccJerkMagStd"   "fBodyBodyGyroMagMean"    
    [67] "fBodyBodyGyroMagStd"      "fBodyBodyGyroJerkMagMean"
    [69] "fBodyBodyGyroJerkMagStd" 

The file `tidydata.csv` can be read into an R data frame with the R command `tidydata <- read.csv("tidydata.csv")`. The above list of variables was produced by the R command `names(tidydata)` so that the variables are listed according to their column position in `tidydata.csv`. The tidy data set contains a subset of the original 561 measured activity variables that were contained in the test and training data sets. That subset consists only of variables containing means or standard deviations. In addition to these measured variables there are three fixed[1] variables: `block`, `activity`, and `subject`, created as described in `README.md`. The fixed variables are as follows:

`block` is an R factor with two levels, `test` and `train`, to distinguish the test and training datasets.

`activity` is an R factor with six levels that are descriptive activity names corresponding to the six activities that were coded as integers in the original test and training datasets. The levels are: `walking`, `walking_upstairs`, `walking_downstairs`, `sitting`, `standing`, and `laying`.

`subject` is an integer variable with values ranging from 1 to 30 indicating the subject performing a particular activity.

Descriptive names for the remaining 66 measured variables were created in the `run_analysis.R` script by removing extraneous parentheses and hyphens from the original variable names and producing "camel case" variable names in which the first letter of each word in the name is capitalized. This naming convention makes the variable names easier to read and interpret.

The 66 measured variables were normalized to fall within the range -1 to 1 resulting in a comparable and unitless scale of measurement. All values are means of each variable computed for each combination of block, activity, and subject.

Names for the 66 measured variables can be decoded by referring to the following list of component names derived from the `features_info.txt` file that accompanies the data archive.

`t`: time domain signals.

`f`: frequency domain signals.

`Body`: body acceleration.

`Gravity`: gravity acceleration.

`Acc`: accelerometer sensor.

`Gyro`: gyroscope sensor.

`Jerk`: jerk signal (rate of change of acceleration).

`Mag`: magnitude.

`Mean`: mean.

`Std`: standard deviation.

`-XYZ`: X, Y, or Z direction.

**Examples**

`tBodyGyroJerkMeanX`: time signal, body acceleration, gyroscope sensor, jerk signal, mean, X direction.

`fBodyBodyGyroJerkMagStd`: frequency signal, body acceleration, gyroscope sensor, jerk signal, magnitude, standard deviation.

`tGravityAccStdY`: time signal, gravity acceleration, accelerometer sensor, standard deviation, Y direction.

[1] Wickham, Hadley . "Tidy Data" Journal of Statistical Software \[Online\], Volume 59, Issue 10 (12 September 2014)

README.md
================
Richard A. Lent

Course Project: Getting and Cleaning Data
-----------------------------------------

This Markdown file, `README.md`, describes the accompanying R[1] script `run_analysis.R`. Additional documentation of the script is contained in comments embedded in the script itself. Variable definitions for the final tidy data set `tidydata.csv`, produced by the script, are contained in the codebook `CodeBook.md`.

The script downloads and processes data from the [Center for Machine Learning and Intelligent Systems](http://cml.ics.uci.edu/) at the University of California/Irvine. Data were obtained from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The database[2] was built from recordings of 30 subjects of ages 19-48 years performing activities of daily living while carrying a waist-mounted Samsung Galaxy S smartphone with embedded inertial sensors. Each person performed six activities: walking, walking upstairs, walking downstairs, sitting, standing, and laying. Using the smartphone's embedded accelerometer and gyroscope, 3-axial (X, Y, and Z dimensions) linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. A series of 561 activity feature variables was derived from these measurements. The feature variables were all normalized, with values ranging from -1 to 1, resulting in a comparable and unitless[3] scale of measurement for all measured variables. The obtained data set was randomly partitioned into two sets, where 70% of the volunteers (7352 observations) was selected for generating the training data and 30% (2947 observations) for the test data, for a total of 10299 observations.

When downloaded and extracted by `run_analysis.R`, the data archive contains two subfolders named `test` and `train`, containing the test and training data sets. The relevant raw data files for this exercise are as follows.

`activity_labels.txt`: Descriptive labels for the 6 activities, coded as integer values:

    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

`train/X_train.txt`: Training data set containing 561 feature variables and 7352 observations.

`train/y_train.txt`: Training labels, integers coded 1 through 6 for the six activities and 7352 observations.

`train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample for the training data set. Subjects are coded as integers ranging from 1 to 30 for 7352 observations.

`test/X_test.txt`: Test data set containing 561 feature variables for 2947 observations.

`test/y_test.txt`: Test labels, integers coded 1 through 6 for the six activities and 2947 observations.

`test/subject_test.txt`: Each row identifies the subject who performed the activity for each window sample for the test data set. Subjects are coded as integers ranging from 1 to 30 for 2947 observations.

After downloading and extracting the data archive, the script `run_analysis.R` does the following, as directed in the instructions for this exercise:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set.
4.  Appropriately labels the data set with descriptive variable names. (See `CodeBook.md`.)
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The `run_analysis.R` script creates three fixed variables reflecting the design of the study. An integer `subject` variable was created from the `subject_train.txt` and `subject_test.txt` files and indicates the subject performing a particular activity for each data set. A second variable called `activity` (an R factor) was created from the `y_train.txt` and `y_test.txt` files to indicate which of the six activities was being performed by a particular subject. A third fixed variable, an R factor named `block`, was created by the script with levels `test` and `train` to distinguish the two data sets. These three fixed variables were added to the 561 measured variables in the test and training data sets based on the number of observations. Because the various components in the test and training data sets had identical numbers of observations (7352 observations for the training data set and 2947 observations for the test data set), columns containing the three fixed variables were added to the data sets using the `cbind` function. This resulted in two data frames, `test` and `train`, that had identical columns. The two data frames were then combined by rows with the `rbind` function.

After merging the training and the test sets to create one data set containing 10299 observations over 561 measured variables and the three fixed variables just described, the script extracts only those measurements on the mean and standard deviation, resulting in a subset of 66 measured variables and the three fixed variables `block`, `activity`, and `subject`. The final tidy data set is then created using the [dplyr package](https://CRAN.R-project.org/package=dplyr). The data frame containing the combined test and training data sets is first grouped by the fixed variables `block`, `activity`, and `subject` using the `dplyr group_by` function. The `dplyr summarize_each` function is then used on the grouped data frame to create means of all 66 measured variables, which contain either means or standard deviations. Finally, the `arrange` function of `dplyr` is used to sort the final tidy data set by `activity` and `subject` to clearly show the structure of the data containing the average of each numeric variable for each activity and each subject.

The subset of 66 measured variables extracted by `run_analysis.R`, comprising only those variables containing means and standard deviations, in addition to the three fixed variables created by `run_analysis.R`, are described in the R Markdown file `CodeBook.md`.

The script creates a plain-text CSV file of the tidy data set named `tidydata.csv`. This CSV file can be read back into an R data frame with the command `tidydata <- read.csv("tidydata.csv")`. The CSV file can also be opened directly in spreadsheet applications such as Microsoft Excel, Apple Numbers, LibreOffice Calc, or Google Sheets in addition to being compatible with many other database and statistical applications.

The final tidy data set satisfies Wickham's [4] criteria for tidy data:

1.  Each variable forms a column.
2.  Each observation forms a row.
3.  Each type of observational unit forms a table.

Each row of the tidy data set represents a single observational unit, that is, a single subject performing one of the six activities. This is clearly seen in `tidydata.csv` as the 30 subjects are sorted numerically from 1 to 30 in each of the six activities, resulting in a total of 180 observations. The tidy data set also contains two types of observational units, indicated by the `block` factor with levels `test` and `train` to distinguish the original test and training datasets. The `block` variable allows each observational unit to be extracted into a separate table if desired.

[1] R Core Team (2016). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL <https://www.R-project.org/>.

[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

[3] Abdi, H. Normalizing data. In Salkind, N. (Ed.), Encyclopedia of Research Design, Sage, Thousand Oaks CA, 2010.

[4] Wickham, Hadley . "Tidy Data" Journal of Statistical Software \[Online\], Volume 59, Issue 10 (12 September 2014)

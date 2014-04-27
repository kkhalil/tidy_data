# The program has been designed to facilitate its reusability, maintainance 
# and to keep it simple

# checkfiles returns a list in its first element a boolean true if concerned files
# exist otherwise false the other list elements are the names of concerned files
checkfiles <- function ( ) {
   files <- data.frame(xdata = c("./train/X_train.txt", "./test/X_test.txt"),
                       ydata = c("./train/y_train.txt",   "./test/y_test.txt"),
                       subject = c("./train/subject_train.txt", "./test/subject_test.txt" ),
                       others  = c("features.txt", "activity_labels.txt"), stringsAsFactors=FALSE)
   
   # test if every file exists and collect the results in a table of TRUE-FALSE
   test_result <- table(sapply(files, function(x) sapply(x, function(y) file.exists(y))))
   
   # if all files exist we will have a table of dimension 1 and names equls to TRUE 
   is_exist= dim(test_result) == 1 && names(test_result) == "TRUE"
   
   # return a list containing the result (TRUE/FALSE) and file names
   c (exists = is_exist, filenames = files)
}

# read list of names, used for activity names and variable names
read_names <- function (namesfile) {
   read.table(namesfile[1], stringsAsFactors=FALSE)$V2
}
# read measuement for both traing and test can combine them (used for x, y and subject)
read_data <- function (datafiles) {
   rbind(read.table(datafiles[1]), read.table(datafiles[2]))
}
get_mean_std <- function(dataset, features) {
   # pattern to use for testing if we have a mean() or a std() in variables' name
   patrn <- ".*mean\\(\\).*|.*std\\(\\).*"
   
   # get the indices of variables verifying the pattern
   mean_std_indices <- grep(patrn, features)
   
   # select the mean() and std() features only
   mean_std_features <- features[mean_std_indices]
   
   # select their measurements
   mean_std_data <- dataset[mean_std_indices]
   
   # add variable names to the dataset 'mean_std_data'
   names(mean_std_data) <- mean_std_features
   
   # return the result a dataset with concerned variables only
   mean_std_data
}

get_tidy <- function(xdata, ydata, subjectdata, activity_names) {
   
   # split the variables values in groups of activity and subject then calculate group means
   tidy_data <- sapply(split(xdata, list(ydata$V1, subjectdata$V1)), colMeans)
   
   # save variables names (row names) because the transpose operation modify them
   features <- row.names(tidy_data)
   # transpose tidy data to have numeric values for variables in columns
   # if we add activity names as row we will have character as variables' data type
   tidy_data <- data.frame(base::t(tidy_data))
   
   # rows become columns so restore the column names (variables names)
   colnames(tidy_data) <- features
   
   # compute number od activities nd number of subject 
   nb_acti <- length(activity_names)
   nb_subj <- dim(table(subjectdata))
   
   # add activity names and subject id columns in front of tidy data's columns
   activity_names <- tolower(activity_names)
   tidy_data <- cbind(rep(activity_names, nb_subj), 
                      rep(seq(1,nb_subj), each=nb_acti), 
                      tidy_data)
   
   # add titles for the columns of activites and subjects
   colnames(tidy_data)[1:2] <- c("Activity", "Subject_id")
   
   # add row names as combination of activity name and subject id
   row.names(tidy_data) <-paste(rep(activity_names, nb_subj), 
                                rep(seq(1,nb_subj), each=nb_acti), sep=".")
   # return the final result
   tidy_data
}

# create a txt file to save the dataset in the working directory
write_data <- function(dataset, filename) {
   write.table(dataset, filename, row.names=FALSE, quote=FALSE)
}

# Compute the tidy data set from the 'UCI HAR Dataset' which supposed to be
# the working directory with the same original structure of files
create_tidy_data <- function() {
   print("In progress...", quote=FALSE)
   files <- checkfiles()
   if (files$exists) {
      
      # select the measurements concernening the mean() and std() only 
      # from x_data (both x training and x test data )
      mean_std_data <- get_mean_std(xdata <- read_data(files$filenames.xdata), 
                                    read_names(files$filenames.others[1]))
      
      # save the mean and std data on working dicrectory with the name 'mean_std_data.txt'
      write_data(mean_std_data, "./mean_std_data.txt")
      
      # compute the average of each variable for each activity and each subject
      # we pass the means abd stds datam ydata, subject data and subject names
      # after reading their values from their files
      tidy_data <-get_tidy(mean_std_data, 
                           read_data(files$filenames.ydata), 
                           read_data(files$filenames.subject),
                           read_names(files$filenames.others[2]))
      
      # save the tidy data on working dicrectory with the name 'tidy_data.txt'
      write_data(tidy_data, "./tidy_data.txt")
      
      print("The tidy data is stored in <working-directory>/tidy_data.txt")
      
      # return the tidy data as a data frame
      tidy_data
   }
   else {
      print(paste("The current work directory is :", getwd()), quote=FALSE)
      print("At least one of the following files does not exists :", quote=FALSE)
      lapply(files[2:4], function(x) print(x))
      print("The program needs all those files within the specified structure to work.", quote=FALSE)
      
      NULL
   }
}
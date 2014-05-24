## Zinonas Zinonos
## Fun with R programming

dataDir <- "./data"
outFile <- "processedData.txt"
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
# first initialization
kFeaturesRead <- FALSE
dfFeatures <- data.frame()
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
main <- function(){

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getFeaturesCache <- function(){ #save CPU time!! Use cached data frame for features for multiple calls
    
  if (kFeaturesRead) { info("getting features from cache"); return(dfFeatures)}
 
  info("getting features first");
  kFeaturesRead <<- TRUE
  dfFeatures <<- getFeatures()
  
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getFeatures <- function(){ # returns a data frame of features

  info("getting interesting features")
  
  d <- extractFeatures( readFeatures() )
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
extractFeatures <- function(df){ #isolate the columns which have only interesting features (mean and std)

  info("extracting interesting features")
  pattern <- "mean\\(\\)|std\\(\\)"   #names of subset columns required
  df[ grep(pattern, df$V2), ] # or df$V2 = df[,2]
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
readFeatures <- function(){#read all info from the features file and return a table

  info("reading all features")
  filepath <- file.path(dataDir, "features.txt")
  dtable <- read.table(filepath)
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getActivities <- function(){ #get the activities data

  info("reading all activities labels")
  filepath <- file.path(dataDir, "activity_labels.txt")
  dtable <- read.table(filepath)
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getDataFileName <- function( dtype = "train", dcont = ""){#obtain data file with the appropriate name

  dcontent <- if ( dcont == "set") 
    "X_"	
    else if ( dcont == "labels") 
    "y_" 
    else if ( dcont == "subjects") 
    "subject_" 
    else 
     ""
      
  paste( dcontent, dtype, ".txt", sep = "")

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getDataFile <- function(dtype = "train", dcont = ""){ #get file with full path

  filepath <- file.path(dataDir, dtype, getDataFileName(dtype, dcont))

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
info <- function(...) {
  cat("run_analysis - ", ..., "...\n")
}

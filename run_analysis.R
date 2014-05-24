## Zinonas Zinonos
## Fun with R programming

dataDir <- "./data"
outFile <- "processedData.txt"
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
main <- function(){

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getFeaturesCache <- function(){

  if (kFeaturesRead) { info("getting features from cache"); return(dfFeatures)}
 
  info("getting features first");
  kFeaturesRead <<- TRUE
  dfFeatures <<- getFeatures()
  
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getFeatures <- function(){

  info("getting interesting features")
  
  d <- extractFeatures( readFeatures() )
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
extractFeatures <- function(df){

  info("extracting interesting features")
  #names of subset columns required
  pattern <- "mean\\(\\)|std\\(\\)"
  df[ grep(pattern, df$V2), ] # df$V2 = df[,2]
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
readFeatures <- function(){

  info("reading all features")
  filepath <- file.path(dataDir, "features.txt")
  dtable <- read.table(filepath)
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getActivities <- function(){

  info("reading all activities labels")
  filepath <- file.path(dataDir, "activity_labels.txt")
  dtable <- read.table(filepath)
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getDataFileName <- function( dtype = "train", dcont = ""){

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
getDataFile <- function(dtype = "train", dcont = ""){

  filepath <- file.path(dataDir, dtype, getDataFileName(dtype, dcont))

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
info <- function(...) {
  cat("run_analysis - ", ..., "...\n")
}

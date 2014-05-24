## Zinonas Zinonos
## Fun with R programming
## May 2012

dataDir <- "./data"
outFile <- "processedData.txt"
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
## first initialization for cache variables
kFeaturesRead <- FALSE
dfFeatures <- data.frame()
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
main <- function(){ # top-level function

    info("obtaining a merged dataset")
    mergedData <- getMergedData()

    ##reference: http://cran.r-project.org/web/packages/reshape2/index.html
    ## We want to convert data from a wide/long format to a long/wide format.
    library(reshape2)

    ## melt function from reshape
    ## From wide to long
    info("reshaping merged data -> applying melting")
    meltedData <- melt(mergedData, id = c("Subject", "Activity"))

    ## dcast to reshape the data (this function is meant for d-ata frames)
    ## From long to wide
    info("reshaping merged data -> recasting")
    processedData <- castData <- dcast(meltedData, Subject + Activity ~ variable, mean)

    ## store output
    info("saving processed data in output file")
    cat("-> proc data dim ", dim(processedData), "\n")
    outputfile <- file.path(".", outFile)
    write.table(processedData, outputfile, row.names = FALSE, quote = FALSE)

    if (file.exists(outputfile))
        info( paste(outputfile, "created") )
    else
        info( paste("rerun code, couldn't create ", outputfile) )

    info("Cheers!")
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getMergedData <- function (){ # merge test and train data
  
   info("getting training dataset")
   dataTrain <- getDataTrain()
   cat("-> train dim ", dim(dataTrain), "\n")
   
   info("getting test dataset")
   dataTest <- getDataTest()
   cat("-> test dim ", dim(dataTest), "\n")
   
   info("merging datasets")
   mergedData <- rbind(dataTest, dataTrain)

}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getDataTrain <- function() getDataset("train")
getDataTest <- function() getDataset("test")
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getDataset <- function(dtype){ # function to create, clean, join and return combined (train or test) data

    ##read interesting feature names and get data correspondingly
    info("features data")

    dfFeatures <- getFeaturesCache()
    v1Features <- dfFeatures[, "V1", drop=TRUE]
    v2Features <- dfFeatures[, "V2", drop=TRUE]

    dfSet <- read.table( getDataFile(dtype, "set") )[v1Features]
    names(dfSet) <- v2Features

    combinedData <- dfSet # attach as tidy data

    ##read all activities names and obtain data according to those
    info("activities data")

    dfActivities <- getActivities()
    v1Activities <- dfActivities[, "V1", drop=TRUE]
    v2Activities <- dfActivities[, "V2", drop=TRUE]

    dfLabels <- read.table( getDataFile(dtype, "labels") )
    names(dfLabels) <- c("Activity") # new column name assigned
    dfLabels$Activity <- factor(dfLabels$Activity, levels = v1Activities, labels = v2Activities)

    combinedData <- cbind(combinedData, Activity = dfLabels$Activity) #insert to combined data

    ##read subjects
    info("subjects data")

    dfSubjects <- read.table( getDataFile(dtype, "subjects") )
    names(dfSubjects) <- c("Subject") # new column name

    combinedData <- cbind(combinedData, Subject = dfSubjects$Subject) # bind to combined dataset and return
}
##_-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-__-'`'-_
getFeaturesCache <- function(){ #save CPU time!! Use cached data frame for features for multiple calls

    if (kFeaturesRead) { info("getting features from cache"); return(dfFeatures) }

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
    #print(df[ grep(pattern, df$V2), ])
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

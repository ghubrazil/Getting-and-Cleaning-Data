library(base)
library(utils)
library(data.table)

load.dataset <- function (set, features, labels) {
        
        prefix <- paste(set, '/', sep = '')
        data <- paste(prefix, 'X_', set, '.txt', sep = '')
        label <- paste(prefix, 'y_', set, '.txt', sep = '')
        subject <- paste(prefix, 'subject_', set, '.txt', sep = '')
        
        data <- read.table(data)[, features$index]
        names(data) <- features$name
        
        label.set <- read.table(label)[, 1]
        data$label <- factor(label.set, levels=labels$level, labels=labels$label)
        
        subject.set <- read.table(subject)[, 1]
        data$subject <- factor(subject.set)
        
        data.table(data)
}

run.analysis <- function () {
        
        setwd('UCI HAR Dataset/')
        
        
        feature.set <- read.table('features.txt', col.names = c('index', 'name'))
        features <- subset(feature.set, grepl('-(mean|std)[(]', feature.set$name))
        
        
        label.set <- read.table('activity_labels.txt', col.names = c('level', 'label'))
        
        
        train.set <- load.dataset('train', features, label.set)
        test.set <- load.dataset('test', features, label.set)
        
        
        dataset <- rbind(train.set, test.set)
        
        
        tidy.dataset <- dataset[, lapply(.SD, mean), by=list(label, subject)]
        
        names <- names(tidy.dataset)
        names <- gsub('-mean', 'Mean', names) 
        names <- gsub('-std', 'Std', names) 
        names <- gsub('[()-]', '', names) 
        names <- gsub('BodyBody', 'Body', names) 
        setnames(tidy.dataset, names)
        
        
        setwd('..')
        write.csv(dataset, file = 'rawdata.csv', row.names = FALSE)
        write.csv(tidy.dataset, file = 'tidydata.csv',
                  row.names = FALSE, quote = FALSE)
        
        
        tidy.dataset
}
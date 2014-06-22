### Introduction

The R script called run_analysis.R contains a function `run.analysis()` that performs the
actual job:
 * reads train and test data sets and merges them
 * writes the merged data set to `rawdata.csv`
 * generates the tidy data set
 * writes the tidy data set to `tidydata.csv`
 

### How to use

If you have the data available in the current directory, run the follow:

```r
source('./run_analysis.R')
run.analysis() 


### Additional Information
You can find additional information in the CodeBook.MD file.


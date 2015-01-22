Getting and Cleaning Data - Course Project
==========================================

This document describes the methodology and the R code used to collect, analyse and process various files in order to build
a tidy data set that could be used for further analysis.

This repository contains the follozwing files:

1. CodeBook.md
2. README.md
3. run_analysis.R

The dataset being used is issued from: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data files can be downloaded here: [download link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Pre-requisites
The script `run_analysis.R` needs the libraries `plyr` and `dplyr`. 

## Running the script
These are the steps to follow in order to run the script `run_analysis.R`
  1. Download the data files using the above link, extract and locate all files in the same directory
  2. Download from gitHub the file `run_analysis.R` into this directory
  2. Edit the run_analysis.R and replace the `path` with your own path
  3. source the R file using `source("run_analysis.R")`

## Resulting objects

After running the script, a file named `HumanActivityRecognitionDataset.txt` is generated in the current directory (according the path file defined earlier). This file is based on a data frame called `df_tidy`



## Codebook
Information about the variables is provided in `CodeBook.md`.     

#script to perform differential gene expression analysis using DESeq2 package
#setwd("~/Desktop/demo/DESeq2_tutorial/data")

#load libraries
library(DESeq2)
library(tidyverse)
library(airway)


#Step 1: preparing count data --------

#read in counts data
counts_data <- read.csv('counts_data.csv')
head(counts_data)

#read in sample info
colData <- read.csv('sample_info.csv')

#making sure the row names in colData matches the column names in counts_data
all(colnames(counts_data)%in% rownames(colData))
#are they in the same order?

all(colnames(counts_data) == rownames(colData))

#Step 2: construct a DESeqDataSet object

DESeqDataSetFromMatrix(counts = counts_data,
                       colData = colData,
                       design - ~Dexamethasone)

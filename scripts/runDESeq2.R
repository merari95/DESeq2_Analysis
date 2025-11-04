# script to perform differential gene expression analysis using DESeq2 package
# setwd("~/Desktop/demo/DESeq2_tutorial/data")

# load libraries
library(DESeq2)
library(tidyverse)
library(airway)


# Step 1: preparing count data --------

# read in counts data
counts_data <- read.csv('counts_data.csv')
head(counts_data)

# read in sample info
colData <- read.csv('sample_info.csv')

# making sure the row names in colData matches the column names in counts_data
all(colnames(counts_data)%in% rownames(colData))
# are they in the same order?

all(colnames(counts_data) == rownames(colData))

# Step 2: construct a DESeqDataSet object

dds <- DESeqDataSetFromMatrix(countData = counts_data,
                       colData = colData,
                       design = ~ dexamethasone) #design factor = dexamethasone

dds
# pre-filtering: removing rows with low gene counts
# keeping rows that have at least 10 reads total (filter out rows less than 10 reads across all samples)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds
# set the factor level

dds$dexamthasone <- relevel(dds$dexamethasone, ref = "untreated") #untreated is reference level

#NOTE: collapse technical replicates (not biological replicates)

# Step 3: Run DESeq function on DESeq object

dds <- DESeq(dds)
res <- results(dds)

res



# Explore Results -------

summary(res)

#change p-value to less than 0.01, so results will change accordingly
res0.01 <- results(dds, alpha = 0.01)
summary(res0.01)

#contrasts 
resultsNames(dds)

# e.g.: treated_4hr, treated_8hrs, untreated   # let's say that these were our conditions,
                                               # then to get the results we would have to 
 
                                              # do the following...
#results(dds, contrast = c("dexamethasone", "treated_4hrs", "untreated")) #compare treatment level (treated_4hrs) vs reference level (untreated)



# MA plot 
plotMA(res)
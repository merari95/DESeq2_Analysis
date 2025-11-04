BACKGROUND: Analyzing RNA-seq count data from the airway dataset, which contains airway smooth muscle cell samples that were:

1. treated with dexamethasone (a corticosteroid drug), and

2. untreated (control samples).

OBJECTIVE: Identify which genes show significant differences in expression between treated and untreated samples. (i.e. Which genes are up-regulated (more highly expressed after dexamethasone)? Which genes are down-regulated (less expressed after dexamethasone)?

DATA: is retrieved from Bioconductor package


runDESeq2.R script-  
>> res

log2 fold change (MLE): dexamethasone untreated vs treated 
Wald test p-value: dexamethasone untreated vs treated                                #used the Wald test
DataFrame with 22369 rows and 6 columns
                 baseMean log2FoldChange     lfcSE      stat    pvalue      padj
                <numeric>      <numeric> <numeric> <numeric> <numeric> <numeric>
ENSG00000000003  708.5979      0.3788232  0.173155  2.187770 0.0286863  0.138469
ENSG00000000419  520.2963     -0.2037892  0.100742 -2.022877 0.0430858  0.182997
ENSG00000000457  237.1621     -0.0340629  0.126476 -0.269324 0.7876803  0.929806
ENSG00000000460   57.9324      0.1171569  0.301583  0.388474 0.6976656  0.894232
ENSG00000000971 5817.3108     -0.4409785  0.258776 -1.704096 0.0883632  0.297044
...                   ...            ...       ...       ...       ...       ...
xENSG00000273485   1.28646      -0.194073  1.346550 -0.144126 0.8854007        NA
ENSG00000273486  15.45244       0.113322  0.426034  0.265993 0.7902447  0.930696
ENSG00000273487   8.16327      -1.017799  0.575797 -1.767635 0.0771219  0.271628
ENSG00000273488   8.58437      -0.218104  0.570714 -0.382159 0.7023435  0.896552

-note that the first column are the genes (i.e. ENSG00000000003 , etc.)
-baseMean : average of the nomalized counts taken over all the samples
-log2FoldChange : fold change of the corresponding gene in the treated condition compared to the untreated condition (positive are upregulated genes in treated condition and negative are downregulated genes in treated condition)
-lfcSE : standard error estimates for the log2FoldChange
-stat : Wald test values for the genes
-pvalue : p-value of the test statistic for the gene
-padj : adjusted p-value; corrected p-value for multiple testing

>> summary(res)

out of 22369 with nonzero total read count
adjusted p-value < 0.1
LFC > 0 (up)       : 1502, 6.7%            # this is the number of upregulated genes
LFC < 0 (down)     : 1884, 8.4%            # this is the number of downregulated genes
outliers [1]       : 51, 0.23%             # how many are outliers
low counts [2]     : 3903, 17%             # how many have low counts
(mean count < 4)


-MA plot: scatter plot of log2FoldChange vs the mean of the normalized counts. Shows us the genes that are differentially expressed. Genes with blue points are signficantly differentially expressed genes and have adjusted p-values of less than 0.05. The small triangles towards the end of the plot indicate have higher fold changes and the direction of the triangle is the direction of the fold change...In our plot, we are hoping we get dots on the upper-right and bottom-right quadarant of the plot which would means these genes would have high mean of normalized counts and high logFold changes which would be candidates to be further looked into.
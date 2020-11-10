# This is the script to install all the dependencies of the huva package

# Update the current packages
BiocManager::install(update = T, ask = F)

# Install CRAN packages

## I use here the Biocmanager so there is no need to specify the package version since this will be bound to the
## Bioconductor version installed

BiocManager::install(c("ggplot2", "Rmisc", "ggpubr", "reshape2", "ggsci", "plotly", "knitr", "pheatmap", "useful", "rmarkdown"), version = "3.11")

# Install Bioconductor packages

BiocManager::install(c("fgsea", "limma", "GSVA"), version = "3.11")
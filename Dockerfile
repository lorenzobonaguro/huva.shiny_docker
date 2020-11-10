# Docker image to run the Shiny app for huva (package version 0.1.4)
FROM rocker/shiny-verse:4.0.0

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    libv8-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN Rscript -e 'BiocManager::install(update = T, ask = F, version= "3.11")' && \
	Rscript -e 'BiocManager::install(c("ggplot2", "Rmisc", "ggpubr", "reshape2", "ggsci", "plotly", "knitr", "pheatmap", "useful", "rmarkdown"), version = "3.11")' && \
	Rscript -e 'BiocManager::install(c("fgsea", "limma", "GSVA"), version = "3.11")' &&\
    Rscript -e 'BiocManager::install(c("shinydashboard", "shinyBS", "useful", "shinybusy", "shinyjs", "V8"), version = "3.11")'

# Install huva
COPY huva_0.1.4.tar.gz /tmp/
COPY huva.db_0.1.4.tar.gz /tmp/
RUN Rscript -e 'install.packages("/tmp/huva.db_0.1.4.tar.gz", repos = NULL, type = "source")' && \
	Rscript -e 'install.packages("/tmp/huva_0.1.4.tar.gz", repos = NULL, type = "source")'

# Copy app
COPY /app ./app

# expose port
EXPOSE 3838

# run the app at startup
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
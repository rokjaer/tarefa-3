#load existing file
FROM rocker/tidyverse:4.0.0
RUN R -e "install.packages('rvest')"
RUN R -e "install.packages('ggthemes')"

COPY /Tarefa_3.R /Tarefa_3.R


CMD Rscript /Tarefa_3.R
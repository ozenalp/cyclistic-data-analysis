# Load the libraries and functions.r
library(tidyverse)
source("functions.R")
# Read the pre-processed data
data <- getwd() %>%
  file.path("processed_data.csv") %>%
  read_csv()

summary(data$ride_length)

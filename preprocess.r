# Load the libraries and functions.r
library(tidyverse)
source("functions.R")
# Read the merged data
data <- getwd() %>%
  file.path("merged_data.csv") %>%
  read_csv()

# Check the structure of data
str(data)

# Add columns that list the date, month, and day of each ride
data$date <- as.Date(data$started_at)
data$month <- format(as.Date(data$date), "%m")
data$day <- format(as.Date(data$date), "%d")
data$day_of_week <- format(as.Date(data$date), "%A")

# Create a new column for the ride length
data$ride_length <- as.double(
        difftime(data$ended_at, data$started_at, units = "mins")
)
# Check ride_length. Does everything makes sense?
summary(data$ride_length)
# It appears that there are some outliers in data, which needs to be removed
# Remove rows with negative ride length
data_v2 <- data[data$ride_length >= 0, ]
# Check how many empty cells in each column
empty_cells <- colSums(is.na(data) | is.null(data))
# Write the processed dataset
write_csv(data_v2, "processed_data.csv")
current_dir <- getwd() # Get working directory

file_path <- file.path(current_dir, "processed_data.csv") # Get the file path

data <- read.csv(file_path) # Read data from .csv file

# Get a summary on ride_length
summary_ride_length <- summary(data$ride_length)
summary_ride_length

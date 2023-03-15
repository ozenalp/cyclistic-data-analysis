current_dir <- getwd() # Get working directory

file_path <- file.path(current_dir, "merged_data.csv") # Get the file path

data <- read.csv(file_path) # Read data from .csv file

# Check the structure of the data
str_data <- capture.output(str(data, max.level = 1))

# Check how many empty cells in each column
empty_cells <- colSums(is.na(data) | data == "" | is.null(data))
# Get the percentage of empty cells in each column
percent_empty <- round(empty_cells / nrow(data) * 100, 2)
print(percent_empty)

# Remove rows where no info exists
data <- data[rowSums(is.na(data) | data == "") == 0, ]

# Convert "started_at" and "ended_at" columns to datetime since,
# we can not operate on chr
data$started_at <- as.POSIXct(data$started_at, format = "%Y-%m-%d %H:%M:%S")
data$ended_at <- as.POSIXct(data$ended_at, format = "%Y-%m-%d %H:%M:%S")
# Create a new column for the ride length
data$ride_length <- difftime(data$ended_at, data$started_at, units = "mins")
# Create a new column for the day of the week
data$day_of_week <- as.numeric(format(data$started_at, "%u"))

write.csv(data, "processed_data.csv", row.names = FALSE)

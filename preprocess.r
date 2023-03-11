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

data_new <- subset(data, select = -c(start_station_name,
    start_station_id, end_station_name, end_station_id))


# Remove rows where no info exists
data_complete <- data_new[rowSums(is.na(data_new) | data_new == "") == 0, ]

write.csv(data_complete, "cleaned_data.csv", row.names = FALSE)

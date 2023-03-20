# Load the libraries and functions.r
library(tidyverse)
library(ggplot2)
source("functions.R")
# Read the pre-processed data
data <- getwd() %>%
  file.path("processed_data.csv") %>%
  read_csv()
str(data)

aggregate(data$ride_length ~ data$member_casual, FUN = mean)
aggregate(data$ride_length ~ data$member_casual, FUN = max)
aggregate(data$ride_length ~ data$member_casual, FUN = median)
aggregate(data$ride_length ~ data$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
table(data$member_casual, data$day_of_week)
aggregate(data$ride_length ~
  data$member_casual + data$day_of_week, FUN = mean, drop = FALSE)

ggplot(data, aes(x = ride_length, fill = member_casual)) + 
  geom_histogram(position = "dodge", binwidth = 1000) +
  facet_wrap(~day_of_week)

# Notice that the days of the week are out of order. Let's fix that.
data$day_of_week <- ordered(data$day_of_week,
  levels=c(
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    )
  )

# analyze ridership data by type and weekday
data %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
  average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)

# Let's visualize the number of rides by rider type
data %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)  %>%
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Let's create a visualization for average duration
data %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)  %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

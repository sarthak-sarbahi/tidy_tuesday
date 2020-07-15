# Install multiple packages together using 'pacman' library
install.packages("pacman")
library(pacman)
p_load(dplyr,ggplot2,tidyverse,readr,visdat,data.table,stringr,ggthemes)

# Load the .CSV file
astronaut <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-14/astronauts.csv")

# Take a glimpse
glimpse(astronaut)

# Look at missing values
vis_miss(astronaut)

# Look at rows having missing values
astronaut %>% filter(is.na(original_name))
astronaut %>% filter(is.na(selection))
astronaut %>% filter(is.na(mission_title))
astronaut %>% filter(is.na(ascend_shuttle))
astronaut %>% filter(is.na(descend_shuttle))

# View head
head(astronaut)

# Export file for data cleaning using Excel
write_csv(astronaut,"mission_data_cleaning.csv")

# Import file after data cleaning
astronaut_mission_cleaned <- read_csv("mission_data_cleaning_done.csv")

# Group by year and save into a different data frame
astronaut_mission_cleaned_viz <- astronaut_mission_cleaned %>% group_by(year_of_mission) %>% summarise(n=n())

# Calculate mean of missions launched
astronaut_mission_cleaned_viz %>% summarise(mean_n=round(mean(n),0))

# Visualization - line plot 
astronaut_mission_cleaned_viz %>% ggplot() + geom_line(aes(x=year_of_mission,y=n)) + labs(title="Number of astronaut missions vs Year?",x="Year of Mission",y="Number of missions") + theme_wsj() + geom_text(aes(x=2018,y=5.3,label="Average is 5 missions"),color="black") + geom_text(aes(x=1986,y=13.5,label="13 missions launched in 1985")) + geom_text(aes(x=1969,y=10.5,label="Peak during 'Space Race'"))


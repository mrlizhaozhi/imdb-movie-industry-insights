# movie-analytics.R
# load and attach data
movie_data <- read.csv(file.choose())
attach(movie_data)

###

# check names and first six rows
names(movie_data)
head(movie_data)

###

# load the plyr library
library(plyr)

###

# frequency tables

# frequency table - rating
# frequency - rating
rating_freq <- cbind(count(movie_data, "rating"))
rating_freq

# percentage frequency - rating
rating_perfreq <- cbind(round(
  rating_freq$freq / nrow(movie_data) * 100, digits = 2))       
rating_perfreq 
rating_table <- cbind(rating_freq, rating_perfreq)
rating_table

#check
sum(rating_table$freq)
sum(rating_table$rating_perfreq)

###

# frequency table - genre
# frequency - genre
genre_freq <- cbind(count(movie_data, "genre"))
genre_freq

# percentage frequency - genre
genre_perfreq <- cbind(round(
  genre_freq$freq / nrow(movie_data) * 100, digits = 2))
genre_perfreq
genre_table <- cbind(genre_freq, genre_perfreq)
genre_table

#check
sum(genre_table$freq)
sum(genre_table$genre_perfreq)

###

# correlation coefficient maxtrix
library(tidyverse)
movie_quant <- movie_data %>%
  select(-company, -country.region, -director, -genre, -name, -rating, 
         -released, -star, -writer, -year)
head(movie_quant)
round(cor(movie_quant), digits = 2)

# correlation coefficient table
library(correlation)
write.csv(correlation::correlation(movie_quant, 
                         include_factors = TRUE, method = "auto"), "comax.csv")

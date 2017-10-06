###########################################
# Yelp Analysis
###########################################

#set working directory 
getwd()
setwd("C:/Users/Suresh/Documents/SpringBoard")

#clear working storage'
rm(list=ls())

#install packages
install.packages("dplyr")
install.packages("jsonlite")
install.packages("stringr")

#load packages 
library(jsonlite)
library(dplyr)
library(stringr)

#covert Json into CSV 
yelp_biz <- stream_in(file("dataset/business.json"), handler = NULL, pagesize = 50000, verbose = TRUE)
#flatten nested attributes
bizflat <- flatten(yelp_biz)
head(bizflat)
#change to dataframe
bizdf <- as_data_frame(bizflat)
# select only requried columns and select rows for particular category and city 
Business <- bizdf %>% select(-starts_with("hours"), -starts_with("attribute")) %>%
  mutate(categories = as.character(categories)) %>%
     filter(str_detect(categories, "Restaurents"),(city == "Boston"| city == "San Francisco")) %>%
    select(-starts_with("hours"), -starts_with("attribute"))
write.csv(Business1, file = "dataset/business.csv", row.names=TRUE)

## Read all req files 
## Currect Healthcare Inspection Feed website - https://www.yelp.com/healthscores/feeds
violations <- read.csv("dataset/all_violations.csv", header = TRUE)
id_map <- read.csv("dataset/Restaurent_Yelp_ID_Map", header = TRUE)
review <- read.csv("dataset/review_c", header = TRUE)







  
library(jsonlite)
library(magrittr)
library(tidyr)
library(listviewer)


##  FAILS
read_json("data/yelp_academic_dataset_business.json")
fromJSON("data/yelp_academic_dataset_business.json")
jsonedit("data/yelp_academic_dataset_business.json")   # looks something like will be: 19 cols, 2550 rows

names(ted)
#  [1] "comments"           "description"        "duration"          
#  [4] "event"              "film_date"          "languages"         
#  [7] "main_speaker"       "name"               "num_speaker"       
# [10] "published_date"     "ratings"            "related_talks"     
# [13] "speaker_occupation" "tags"               "title"             
# [16] "url"                "views"              "ratings2"          

  str(ted$ratings, max.level=2)
  ted$ratings2 <- gsub("'", '"', ted$ratings)

# convert to R object (list of data.frame) fromJSON
  ted$ratings2  <- purrr::map(ted$ratings2, fromJSON)
  str(ted$ratings2, max.level=2, list.len=3)


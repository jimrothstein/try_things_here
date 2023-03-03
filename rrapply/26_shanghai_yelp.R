library(jsonlite)
library(magrittr)
library(tidyr)
library(listviewer)


# TODO
# - use tibble earlier

ted   <- read.csv(file="data/ted_main.csv") 
jsonedit(ted)   # looks something like will be: 19 cols, 2550 rows
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


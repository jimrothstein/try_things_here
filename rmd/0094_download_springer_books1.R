devtools::install_github("renanxcortes/springerQuarantineBooksR")

devtools::install_github("renanxcortes/springerQuarantineBooksR", force= TRUE)


devtools::install_github("joke/joke", force= TRUE)
library(springerQuarantineBooksR)

devtools::install_github("renanxcortes")
git@github.com:renanxcortes/springerQuarantineBooksR.git
library(httr)
library(magrittr)
library(readxl)
download_springer_table <-
  function(lan = 'eng') {

    if (lan == 'eng') {books_list_url <- 'https://resource-cms.springernature.com/springer-cms/rest/v1/content/17858272/data/v4/'}
    if (lan == 'ger') {books_list_url <- 'https://resource-cms.springernature.com/springer-cms/rest/v1/content/17863240/data/v2'}

    GET(books_list_url, write_disk(tf <- tempfile(fileext = ".xlsx")))

    springer_table <- read_excel(tf) %>%
      clean_names()

    return(springer_table)

  }
download_springer_table()

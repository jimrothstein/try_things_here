library(httr)
endpoint <- "https://api.noopschallenge.com/hexbot"


## get a single color, and display on screen

random.color <- function() {
    hexbot <- GET(endpoint)
    content(hexbot)$colors[[1]]$value
}

rcol <- random.color()
barplot(1, col=rcol, main=rcol, axes=FALSE)
## --------
## get n colors at once
## get n colors at once

random.colors <- function(n) {
    hexbot <- GET(endpoint, query=list(count=n))
    unlist(content(hexbot)$colors)
}

ncol <- 5
barplot(rep(1,ncol),col=random.colors(ncol), axes=FALSE)


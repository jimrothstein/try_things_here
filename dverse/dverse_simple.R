# dverse - simple example
library(dverse)

library(glue)
library(tibble)

universe <- c("glue", "tibble")
document_universe(universe)
#> # A tibble: 46 × 7
#>    topic      alias                          title concept type  keyword package
#>    <chr>      <chr>                          <chr> <chr>   <chr> <chr>   <chr>
#>  1 add_column add_column                     Add … additi… help  <NA>    tibble
#>  2 add_row    add_row, add_case              Add … additi… help  <NA>    tibble
#>  3 as_glue    as_glue                        Coer… <NA>    help  <NA>    glue
#>  4 as_tibble  as_tibble, as_tibble_row, as_… Coer… <NA>    help  <NA>    tibble
#>  5 char       char, set_char_opts            Form… vector… help  <NA>    tibble
#>  6 deprecated deprecated, data_frame, tibbl… Depr… <NA>    help  intern… tibble
#>  7 digits     digits                         Comp… <NA>    vign… <NA>    tibble
#>  8 enframe    enframe, deframe               Conv… <NA>    help  <NA>    tibble
#>  9 engines    engines                        Cust… <NA>    vign… <NA>    glue
#> 10 extending  extending                      Exte… <NA>    vign… <NA>    tibble
#> # ℹ 36 more rows

# Assuming vignettes can be found at */articles/* rather than */reference/*
# (LEAVE manual unchanged)
manual <- "https://{package}.tidyverse.org/reference/{topic}.html"
document_universe(universe, url_template = manual)
#> # A tibble: 46 × 7
#>    topic                               alias title concept type  keyword package
#>    <chr>                               <chr> <chr> <chr>   <chr> <chr>   <chr>
#>  1 <a href=https://tibble.tidyverse.o… add_… Add … additi… help  <NA>    tibble
#>  2 <a href=https://tibble.tidyverse.o… add_… Add … additi… help  <NA>    tibble
#>  3 <a href=https://glue.tidyverse.org… as_g… Coer… <NA>    help  <NA>    glue
#>  4 <a href=https://tibble.tidyverse.o… as_t… Coer… <NA>    help  <NA>    tibble
#>  5 <a href=https://tibble.tidyverse.o… char… Form… vector… help  <NA>    tibble
#>  6 <a href=https://tibble.tidyverse.o… depr… Depr… <NA>    help  intern… tibble
#>  7 <a href=https://tibble.tidyverse.o… digi… Comp… <NA>    vign… <NA>    tibble
#>  8 <a href=https://tibble.tidyverse.o… enfr… Conv… <NA>    help  <NA>    tibble
#>  9 <a href=https://glue.tidyverse.org… engi… Cust… <NA>    vign… <NA>    glue
#> 10 <a href=https://tibble.tidyverse.o… exte… Exte… <NA>    vign… <NA>    tibble
#> # ℹ 36 more rows

# Adding an explicit template for vignettes
vignettes <- "https://{package}.tidyverse.org/articles/{topic}.html"
docs <- document_universe(universe, url_template = c(manual, vignettes))

sink(file="./dverse/example.html")
knitr::kable(tail(docs))
sink

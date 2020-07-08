---
title: "066_fs_examples.Rmd"
output:
  html_document:
    toc: yes
  pdf_document:
    toc: yes
editor_options:
  chunk_output_type: console
---
Ref: https://fs.r-lib.org/index.html


#### Code to print files in r_try_things_here/
#### special one time only - print directory
```{r include=FALSE }
knitr::opts_chunk$set(echo = TRUE, comment="")
library(tidyverse)
library(fs)
library(lubridate)
library(magrittr)
library(tibble)
library(dplyr)
```

```{r}
knitr::opts_chunk$set(echo= TRUE, include= TRUE)
# dir_info, capture as_tibble

# convert Positct date-time to simple date
t <- as_tibble(dir_info()) %>% 
  mutate(modification_time = lubridate::as_date(modification_time)) %>% 
	select(path, size, modification_time )
print(t, n=500)

```

```{r example}
library(kableExtra)

dt <- mtcars[1:5, 1:6]
kable(dt, "latex")

# with booktabs ?)
kable(dt, "latex", booktabs = T)

kable(dt, "latex", booktabs = T) %>% 
kable_styling(latex_options = "striped")

# double space 
kable(mtcars[1:8, 1:4], "latex", booktabs = T, linesep = " ") %>%
kable_styling(latex_options = "striped", stripe_index = c(1,2, 5:6))

```

```
knitr::knit_exit()

```


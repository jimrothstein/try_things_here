# dverse_example
jim
2023-12-20

``` r
library(dverse)
library(glue)
library(tibble)
```

``` r
universe <- c("glue", "tibble")
manual <- "https://{package}.tidyverse.org/reference/{topic}.html"

document_universe(universe, url_template = manual)
```

    # A tibble: 46 × 7
       topic                               alias title concept type  keyword package
       <chr>                               <chr> <chr> <chr>   <chr> <chr>   <chr>  
     1 <a href=https://tibble.tidyverse.o… add_… Add … additi… help  <NA>    tibble 
     2 <a href=https://tibble.tidyverse.o… add_… Add … additi… help  <NA>    tibble 
     3 <a href=https://glue.tidyverse.org… as_g… Coer… <NA>    help  <NA>    glue   
     4 <a href=https://tibble.tidyverse.o… as_t… Coer… <NA>    help  <NA>    tibble 
     5 <a href=https://tibble.tidyverse.o… char… Form… vector… help  <NA>    tibble 
     6 <a href=https://tibble.tidyverse.o… depr… Depr… <NA>    help  intern… tibble 
     7 <a href=https://tibble.tidyverse.o… digi… Comp… <NA>    vign… <NA>    tibble 
     8 <a href=https://tibble.tidyverse.o… enfr… Conv… <NA>    help  <NA>    tibble 
     9 <a href=https://glue.tidyverse.org… engi… Cust… <NA>    vign… <NA>    glue   
    10 <a href=https://tibble.tidyverse.o… exte… Exte… <NA>    vign… <NA>    tibble 
    # ℹ 36 more rows

Both manual and vignettes

``` r
vignettes <- "https://{package}.tidyverse.org/articles/{topic}.html"
docs <- document_universe(universe, url_template = c(manual, vignettes))
```

``` r
knitr::kable(docs)
```

| topic | alias | title | concept | type | keyword | package |
|:---|:---|:---|:---|:---|:---|:---|
| <a href=https://tibble.tidyverse.org/reference/add_column.html>add_column</a> | add_column | Add columns to a data frame | addition | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/add_row.html>add_row</a> | add_row, add_case | Add rows to a data frame | addition | help | NA | tibble |
| <a href=https://glue.tidyverse.org/reference/as_glue.html>as_glue</a> | as_glue | Coerce object to glue | NA | help | NA | glue |
| <a href=https://tibble.tidyverse.org/reference/as_tibble.html>as_tibble</a> | as_tibble, as_tibble_row, as_tibble_col | Coerce lists, matrices, and more to data frames | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/char.html>char</a> | char, set_char_opts | Format a character vector | vector classes | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/deprecated.html>deprecated</a> | deprecated, data_frame, tibble\_, data_frame\_, lst\_, as_data_frame, as.tibble, frame_data | Deprecated functions | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/articles/digits.html>digits</a> | digits | Comparing display with data frames | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/enframe.html>enframe</a> | enframe, deframe | Converting vectors to data frames, and vice versa | NA | help | NA | tibble |
| <a href=https://glue.tidyverse.org/articles/engines.html>engines</a> | engines | Custom knitr language engines | NA | vignette | NA | glue |
| <a href=https://tibble.tidyverse.org/articles/extending.html>extending</a> | extending | Extending tibble | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/articles/formats.html>formats</a> | formats | Column formats | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/formatting.html>formatting</a> | formatting, print, format, print.tbl_df, format.tbl_df | Printing tibbles | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/frame_matrix.html>frame_matrix</a> | frame_matrix | Row-wise matrix creation | NA | help | NA | tibble |
| <a href=https://glue.tidyverse.org/reference/glue.html>glue</a> | glue, glue_data | Format and interpolate a string | NA | help | NA | glue |
| <a href=https://glue.tidyverse.org/articles/glue.html>glue</a> | glue, glue_data | Introduction to glue | NA | vignette | NA | glue |
| <a href=https://glue.tidyverse.org/reference/glue-package.html>glue-package</a> | glue-package | glue: Interpreted String Literals | NA | help | internal | glue |
| <a href=https://glue.tidyverse.org/reference/glue_col.html>glue_col</a> | glue_col, glue_data_col | Construct strings with color | NA | help | NA | glue |
| <a href=https://glue.tidyverse.org/reference/glue_collapse.html>glue_collapse</a> | glue_collapse, glue_sql_collapse | Collapse a character vector | NA | help | NA | glue |
| <a href=https://glue.tidyverse.org/reference/glue_safe.html>glue_safe</a> | glue_safe, glue_data_safe | Safely interpolate strings | NA | help | NA | glue |
| <a href=https://glue.tidyverse.org/reference/glue_sql.html>glue_sql</a> | glue_sql, glue_data_sql | Interpolate strings with SQL escaping | NA | help | NA | glue |
| <a href=https://glue.tidyverse.org/reference/identity_transformer.html>identity_transformer</a> | identity_transformer | Parse and Evaluate R code | NA | help | NA | glue |
| <a href=https://tibble.tidyverse.org/articles/invariants.html>invariants</a> | invariants | Invariants: Comparing behavior with data frames | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/is.tibble.html>is.tibble</a> | is.tibble | Deprecated test for tibble-ness | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/reference/is_tibble.html>is_tibble</a> | is_tibble | Test if the object is a tibble | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/lst.html>lst</a> | lst | Build a list | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/name-repair.html>name-repair</a> | name-repair | Name repair | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/reference/name-repair-superseded.html>name-repair-superseded</a> | name-repair-superseded, tidy_names, name-repair-retired, set_tidy_names, repair_names | Superseded functions for name repair | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/reference/new_tibble.html>new_tibble</a> | new_tibble, validate_tibble | Tibble constructor and validator | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/num.html>num</a> | num, set_num_opts | Format a numeric vector | vector classes | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/articles/numbers.html>numbers</a> | numbers | Controlling display of numbers | NA | vignette | NA | tibble |
| <a href=https://glue.tidyverse.org/reference/quoting.html>quoting</a> | quoting, single_quote, double_quote, backtick | Quoting operators | NA | help | NA | glue |
| <a href=https://tibble.tidyverse.org/reference/reexports.html>reexports</a> | reexports, glimpse, has_name, %\>%, tbl_sum, obj_sum, type_sum, size_sum | Objects exported from other packages | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/reference/rownames.html>rownames</a> | rownames, has_rownames, remove_rownames, rownames_to_column, rowid_to_column, column_to_rownames | Tools for working with row names | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/subsetting.html>subsetting</a> | subsetting, \$, \[\[, \[, \$\<-, \[\[\<-, \[\<- | Subsetting tibbles | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/tbl_df-class.html>tbl_df-class</a> | tbl_df-class, tbl_df | ‘tbl_df’ class | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/tibble.html>tibble</a> | tibble, tibble_row | Build a data frame | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/articles/tibble.html>tibble</a> | tibble, tibble_row | Tibbles | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/tibble-package.html>tibble-package</a> | tibble-package | tibble: Simple Data Frames | NA | help | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/tibble_options.html>tibble_options</a> | tibble_options | Package options | Datasets available by data() | help | datasets | tibble |
| <a href=https://glue.tidyverse.org/articles/transformers.html>transformers</a> | transformers | Transformers | NA | vignette | NA | glue |
| <a href=https://tibble.tidyverse.org/reference/tribble.html>tribble</a> | tribble | Row-wise tibble creation | NA | help | NA | tibble |
| <a href=https://glue.tidyverse.org/reference/trim.html>trim</a> | trim | Trim a character vector | NA | help | NA | glue |
| <a href=https://tibble.tidyverse.org/reference/trunc_mat.html>trunc_mat</a> | trunc_mat | Legacy printing | NA | help | internal | tibble |
| <a href=https://tibble.tidyverse.org/articles/types.html>types</a> | types | Column types | NA | vignette | NA | tibble |
| <a href=https://tibble.tidyverse.org/reference/view.html>view</a> | view | View an object | NA | help | NA | tibble |
| <a href=https://glue.tidyverse.org/articles/wrappers.html>wrappers</a> | wrappers | How to write a function that wraps glue | NA | vignette | NA | glue |

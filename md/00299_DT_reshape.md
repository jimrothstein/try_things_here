Vignette::Normalize and de-Normalize Data REF:
<https://rdatatable.gitlab.io/data.table/library/data.table/doc/datatable-reshape.html>
\* Follow the tutorial \* Conent here is LIMITED annotation, follow the
tuturial

### Section 1

### non-normalized data

    # sloppy way to input data!
    s1 <- "family_id age_mother dob_child1 dob_child2 dob_child3
    1         30 1998-11-26 2000-01-29         NA
    2         27 1996-06-22         NA         NA
    3         26 2002-07-11 2004-04-05 2007-09-02
    4         32 2004-10-10 2009-08-27 2012-07-21
    5         29 2000-12-05 2005-02-28         NA"

    s1

          ## [1] "family_id age_mother dob_child1 dob_child2 dob_child3\n1         30 1998-11-26 2000-01-29         NA\n2         27 1996-06-22         NA         NA\n3         26 2002-07-11 2004-04-05 2007-09-02\n4         32 2004-10-10 2009-08-27 2012-07-21\n5         29 2000-12-05 2005-02-28         NA"

    DT <- fread(s1)
    DT

          ##    family_id age_mother dob_child1 dob_child2 dob_child3
          ## 1:         1         30 1998-11-26 2000-01-29       <NA>
          ## 2:         2         27 1996-06-22       <NA>       <NA>
          ## 3:         3         26 2002-07-11 2004-04-05 2007-09-02
          ## 4:         4         32 2004-10-10 2009-08-27 2012-07-21
          ## 5:         5         29 2000-12-05 2005-02-28       <NA>

    str(DT)

          ## Classes 'data.table' and 'data.frame': 5 obs. of  5 variables:
          ##  $ family_id : int  1 2 3 4 5
          ##  $ age_mother: int  30 27 26 32 29
          ##  $ dob_child1: IDate, format: "1998-11-26" ...
          ##  $ dob_child2: IDate, format: "2000-01-29" ...
          ##  $ dob_child3: IDate, format: NA ...
          ##  - attr(*, ".internal.selfref")=<externalptr>

    dt  <- DT

### list\_column

    # makes list-column
    dt[, .(age_mother, 
           .(dob = .(dob_child1, dob_child2, dob_child3))),
           by = family_id]

          ##    family_id age_mother        V2
          ## 1:         1         30 <list[3]>
          ## 2:         2         27 <list[3]>
          ## 3:         3         26 <list[3]>
          ## 4:         4         32 <list[3]>
          ## 5:         5         29 <list[3]>

### normalize

    # normalizes
    dt[, .(age_mother, 
           dob = .(dob_child1, dob_child2, dob_child3)),
           by = family_id]

          ##     family_id age_mother        dob
          ##  1:         1         30 1998-11-26
          ##  2:         1         30 2000-01-29
          ##  3:         1         30         NA
          ##  4:         2         27 1996-06-22
          ##  5:         2         27         NA
          ##  6:         2         27         NA
          ##  7:         3         26 2002-07-11
          ##  8:         3         26 2004-04-05
          ##  9:         3         26 2007-09-02
          ## 10:         4         32 2004-10-10
          ## 11:         4         32 2009-08-27
          ## 12:         4         32 2012-07-21
          ## 13:         5         29 2000-12-05
          ## 14:         5         29 2005-02-28
          ## 15:         5         29         NA

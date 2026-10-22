## 00293\_ Basic\_Examples of DT

REF:
<https://stackoverflow.com/questions/32276887/use-of-lapply-sd-in-data-table-r>

### create dt

    set.seed(10238)
    # A and B are the "id" variables within which the
    #   "data" variables C and D vary meaningfully

    create_dt  <- function () {
    DT = data.table(
      A = rep(1:3, each = 5L), 
      B = rep(1:5, 3L),
      C = sample(15L),
      D = sample(15L)
    )
    return(DT)
    }

    dt  <- create_dt()
    dt

          ##     A B  C  D
          ##  1: 1 1 12 15
          ##  2: 1 2  4  6
          ##  3: 1 3  5  7
          ##  4: 1 4  9  1
          ##  5: 1 5  6 14
          ##  6: 2 1 15 13
          ##  7: 2 2  2 10
          ##  8: 2 3 14  3
          ##  9: 2 4  1  2
          ## 10: 2 5 10  4
          ## 11: 3 1 11  9
          ## 12: 3 2  3  8
          ## 13: 3 3 13 11
          ## 14: 3 4  8  5
          ## 15: 3 5  7 12

### Count, sum columns, groupings

    #Sum all columns
    dt[ , lapply(.SD, sum)]

          ##     A  B   C   D
          ## 1: 30 45 120 120

    #     A  B   C   D
    # 1: 30 45 120 120

### Raw Markdown?

    ###  Sum all columns
    dt[ , lapply(.SD, sum)]

    A  B   C   D

1: 30 45 120 120

### Count Rows

    dt[ , lapply(.SD, length)]

          ##     A  B  C  D
          ## 1: 15 15 15 15

### By grouping, sum all, except A

    dt[ , lapply(.SD, sum), by = A]

          ##    A  B  C  D
          ## 1: 1 15 36 43
          ## 2: 2 15 42 32
          ## 3: 3 15 42 45

    #    A  B  C  D
    # 1: 1 15 38 43
    # 2: 2 15 30 49
    # 3: 3 15 52 28

\#\#\#Sum all columns EXCEPT A

    dt[ , lapply(.SD, sum), .SDcols = !"A"]

          ##     B   C   D
          ## 1: 45 120 120

### Group on A, count

    dt[ , lapply(.SD, length), by = A]

          ##    A B C D
          ## 1: 1 5 5 5
          ## 2: 2 5 5 5
          ## 3: 3 5 5 5

    #Sum all columns EXCEPT A, grouping BY B
    dt[ , lapply(.SD, sum), by = B, .SDcols = !"A"]

          ##    B  C  D
          ## 1: 1 38 37
          ## 2: 2  9 24
          ## 3: 3 32 21
          ## 4: 4 18  8
          ## 5: 5 23 30

    #    B  C  D
    # 1: 1 27 29
    # 2: 2 17 30
    # 3: 3 33 11
    # 4: 4 23 36

    dt[ , lapply(.SD, length), by = B, .SDcols = !"A"]

          ##    B C D
          ## 1: 1 3 3
          ## 2: 2 3 3
          ## 3: 3 3 3
          ## 4: 4 3 3
          ## 5: 5 3 3

    # Count, each combination of c("A", "B")
    dt[ , lapply(.SD, length), by = c("A","B")]

          ##     A B C D
          ##  1: 1 1 1 1
          ##  2: 1 2 1 1
          ##  3: 1 3 1 1
          ##  4: 1 4 1 1
          ##  5: 1 5 1 1
          ##  6: 2 1 1 1
          ##  7: 2 2 1 1
          ##  8: 2 3 1 1
          ##  9: 2 4 1 1
          ## 10: 2 5 1 1
          ## 11: 3 1 1 1
          ## 12: 3 2 1 1
          ## 13: 3 3 1 1
          ## 14: 3 4 1 1
          ## 15: 3 5 1 1

### normalize - votes

    # each=2, each element repeated twice, before moving on.
    votes <- function() {
      data.table(issue = rep(c("issue1", "issue2"),times=1, each=2),
                 A = rep(c("Y",NA), 2),
                 B = rep(c(NA,"N"),2)
                 )
    }
    dt = votes()
    dt

          ##     issue    A    B
          ## 1: issue1    Y <NA>
          ## 2: issue1 <NA>    N
          ## 3: issue2    Y <NA>
          ## 4: issue2 <NA>    N

    dt  <- votes()
    dt_A  <- dt[!is.na(A), .(country = "A", vote=A), by = issue]
    dt_A

          ##     issue country vote
          ## 1: issue1       A    Y
          ## 2: issue2       A    Y

    dt_B  <- dt[!is.na(B), .(country = "B", vote=B), by = issue]
    dt_B

          ##     issue country vote
          ## 1: issue1       B    N
          ## 2: issue2       B    N

------------------------------------------------------------------------


data.table-package         package:data.table          R Documentation

Enhanced data.frame

Description:

     ‘data.table’ _inherits_ from ‘data.frame’. It offers fast and
     memory efficient: file reader and writer, aggregations, updates,
     equi, non-equi, rolling, range and interval joins, in a short and
     flexible syntax, for faster development.

     It is inspired by ‘A[B]’ syntax in R where ‘A’ is a matrix and ‘B’
     is a 2-column matrix. Since a ‘data.table’ _is_ a ‘data.frame’, it
     is compatible with R functions and packages that accept _only_
     ‘data.frame’s.

     Type ‘vignette(package="data.table")’ to get started. The
     Introduction to data.table vignette introduces ‘data.table’'s
     ‘x[i, j, by]’ syntax and is a good place to start. If you have
     read the vignettes and the help page below, please read the
     data.table support guide.

     Please check the homepage for up to the minute live NEWS.

     Tip: one of the _quickest_ ways to learn the features is to type
     ‘example(data.table)’ and study the output at the prompt.

Usage:

     data.table(..., keep.rownames=FALSE, check.names=FALSE, key=NULL, stringsAsFactors=FALSE)
     
     ## S3 method for class 'data.table'
     x[i, j, by, keyby, with = TRUE,
       nomatch = NA,
       mult = "all",
       roll = FALSE,
       rollends = if (roll=="nearest") c(TRUE,TRUE)
                  else if (roll>=0) c(FALSE,TRUE)
                  else c(TRUE,FALSE),
       which = FALSE,
       .SDcols,
       verbose = getOption("datatable.verbose"),                   # default: FALSE
       allow.cartesian = getOption("datatable.allow.cartesian"),   # default: FALSE
       drop = NULL, on = NULL, env = NULL]
	
Arguments: 

     ...: Just as ‘...’ in ‘data.frame’. Usual recycling rules are
          applied to vectors of different lengths to create a list of
          equal length vectors.

keep.rownames: If ‘...’ is a ‘matrix’ or ‘data.frame’, ‘TRUE’ will
          retain the rownames of that object in a column named ‘rn’.

check.names: Just as ‘check.names’ in ‘data.frame’.

     key: Character vector of one or more column names which is passed
          to ‘setkey’. It may be a single comma separated string such
          as ‘key="x,y,z"’, or a vector of names such as
          ‘key=c("x","y","z")’.

stringsAsFactors: Logical (default is ‘FALSE’). Convert all ‘character’
          columns to ‘factor’s?

       x: A ‘data.table’.

       i: Integer, logical or character vector, single column numeric
          ‘matrix’, expression of column names, ‘list’, ‘data.frame’ or
          ‘data.table’.

          ‘integer’ and ‘logical’ vectors work the same way they do in
          ‘[.data.frame’ except logical ‘NA’s are treated as FALSE.

          ‘expression’ is evaluated within the frame of the
          ‘data.table’ (i.e. it sees column names as if they are
          variables) and can evaluate to any of the other types.

          ‘character’, ‘list’ and ‘data.frame’ input to ‘i’ is
          converted into a ‘data.table’ internally using
          ‘as.data.table’.

          If ‘i’ is a ‘data.table’, the columns in ‘i’ to be matched
          against ‘x’ can be specified using one of these ways:

            • ‘on’ argument (see below). It allows for both ‘equi-’ and
              the newly implemented ‘non-equi’ joins.

            • If not, ‘x’ _must be keyed_. Key can be set using
              ‘setkey’. If ‘i’ is also keyed, then first _key_ column
              of ‘i’ is matched against first _key_ column of ‘x’,
              second against second, etc..

              If ‘i’ is not keyed, then first column of ‘i’ is matched
              against first _key_ column of ‘x’, second column of ‘i’
              against second _key_ column of ‘x’, etc...

              This is summarised in code as ‘min(length(key(x)), if
              (haskey(i)) length(key(i)) else ncol(i))’.

          Using ‘on=’ is recommended (even during keyed joins) as it
          helps understand the code better and also allows for
          _non-equi_ joins.

          When the binary operator ‘==’ alone is used, an _equi_ join
          is performed. In SQL terms, ‘x[i]’ then performs a _right
          join_ by default. ‘i’ prefixed with ‘!’ signals a _not-join_
          or _not-select_.

          Support for _non-equi_ join was recently implemented, which
          allows for other binary operators ‘>=, >, <= and <’.

          See ‘vignette("datatable-keys-fast-subset")’ and
          ‘vignette("datatable-secondary-indices-and-auto-indexing")’.

          _Advanced:_ When ‘i’ is a single variable name, it is not
          considered an expression of column names and is instead
          evaluated in calling scope.

       j: When ‘with=TRUE’ (default), ‘j’ is evaluated within the frame
          of the data.table; i.e., it sees column names as if they are
          variables. This allows to not just _select_ columns in ‘j’,
          but also ‘compute’ on them e.g., ‘x[, a]’ and ‘x[, sum(a)]’
          returns ‘x$a’ and ‘sum(x$a)’ as a vector respectively. ‘x[,
          .(a, b)]’ and ‘x[, .(sa=sum(a), sb=sum(b))]’ returns a two
          column data.table each, the first simply _selecting_ columns
          ‘a, b’ and the second _computing_ their sums.

          As long as ‘j’ returns a ‘list’, each element of the list
          becomes a column in the resulting ‘data.table’. When the
          output of ‘j’ is not a ‘list’, the output is returned as-is
          (e.g. ‘x[ , a]’ returns the column vector ‘a’), unless ‘by’
          is used, in which case it is implicitly wrapped in ‘list’ for
          convenience (e.g. ‘x[ , sum(a), by=b]’ will create a column
          named ‘V1’ with value ‘sum(a)’ for each group).

          The expression `.()` is a _shorthand_ alias to ‘list()’; they
          both mean the same. (An exception is made for the use of
          ‘.()’ within a call to ‘bquote’, where ‘.()’ is left
          unchanged.)

          When ‘j’ is a vector of column names or positions to select
          (as in ‘data.frame’). There is no need to use ‘with=FALSE’
          anymore. Note that ‘with=FALSE’ is still necessary when using
          a logical vector with length ‘ncol(x)’ to include/exclude
          columns. Note: if a logical vector with length ‘k < ncol(x)’
          is passed, it will be filled to length ‘ncol(x)’ with
          ‘FALSE’, which is different from ‘data.frame’, where the
          vector is recycled.

          _Advanced:_ ‘j’ also allows the use of special _read-only_
          symbols: ‘.SD’, ‘.N’, ‘.I’, ‘.GRP’, ‘.BY’. See
          ‘special-symbols’ and the Examples below for more.

          _Advanced:_ When ‘i’ is a ‘data.table’, the columns of ‘i’
          can be referred to in ‘j’ by using the prefix ‘i.’, e.g.,
          ‘X[Y, .(val, i.val)]’. Here ‘val’ refers to ‘X’'s column and
          ‘i.val’ ‘Y’'s.

          _Advanced:_ Columns of ‘x’ can now be referred to using the
          prefix ‘x.’ and is particularly useful during joining to
          refer to ‘x’'s _join_ columns as they are otherwise masked by
          ‘i’'s. For example, ‘X[Y, .(x.a-i.a, b), on="a"]’.

          See ‘vignette("datatable-intro")’ and ‘example(data.table)’.

      by: Column names are seen as if they are variables (as in ‘j’
          when ‘with=TRUE’). The ‘data.table’ is then grouped by the
          ‘by’ and ‘j’ is evaluated within each group. The order of the
          rows within each group is preserved, as is the order of the
          groups. ‘by’ accepts:

            • A single unquoted column name: e.g., ‘DT[, .(sa=sum(a)),
              by=x]’

            • a ‘list()’ of expressions of column names: e.g., ‘DT[,
              .(sa=sum(a)), by=.(x=x>0, y)]’

            • a single character string containing comma separated
              column names (where spaces are significant since column
              names may contain spaces even at the start or end): e.g.,
              ‘DT[, sum(a), by="x,y,z"]’

            • a character vector of column names: e.g., ‘DT[, sum(a),
              by=c("x", "y")]’

            • or of the form ‘startcol:endcol’: e.g., ‘DT[, sum(a),
              by=x:z]’

          _Advanced:_ When ‘i’ is a ‘list’ (or ‘data.frame’ or
          ‘data.table’), ‘DT[i, j, by=.EACHI]’ evaluates ‘j’ for the
          groups in `DT` that each row in ‘i’ joins to. That is, you
          can join (in ‘i’) and aggregate (in ‘j’) simultaneously. We
          call this _grouping by each i_. See this StackOverflow answer
          for a more detailed explanation until we roll out vignettes.

          _Advanced:_ In the ‘X[Y, j]’ form of grouping, the ‘j’
          expression sees variables in ‘X’ first, then ‘Y’. We call
          this _join inherited scope_. If the variable is not in ‘X’ or
          ‘Y’ then the calling frame is searched, its calling frame,
          and so on in the usual way up to and including the global
          environment.

   keyby: Same as ‘by’, but with an additional ‘setkey()’ run on the
          ‘by’ columns of the result, for convenience. It is common
          practice to use `keyby=` routinely when you wish the result
          to be sorted. May also be ‘TRUE’ or ‘FALSE’ when ‘by’ is
          provided as an alternative way to accomplish the same
          operation.

    with: By default ‘with=TRUE’ and ‘j’ is evaluated within the frame
          of ‘x’; column names can be used as variables. In case of
          overlapping variables names inside dataset and in parent
          scope you can use double dot prefix ‘..cols’ to explicitly
          refer to `‘cols’ variable parent scope and not from your
          dataset.

          When ‘j’ is a character vector of column names, a numeric
          vector of column positions to select or of the form
          ‘startcol:endcol’, and the value returned is always a
          ‘data.table’. ‘with=FALSE’ is not necessary anymore to select
          columns dynamically. Note that ‘x[, cols]’ is equivalent to
          ‘x[, ..cols]’ and to ‘x[, cols, with=FALSE]’ and to ‘x[, .SD,
          .SDcols=cols]’.

 nomatch: When a row in ‘i’ has no match to ‘x’, ‘nomatch=NA’ (default)
          means ‘NA’ is returned. ‘NULL’ (or ‘0’ for backward
          compatibility) means no rows will be returned for that row of
          ‘i’.

    mult: When ‘i’ is a ‘list’ (or ‘data.frame’ or ‘data.table’) and
          _multiple_ rows in ‘x’ match to the row in ‘i’, ‘mult’
          controls which are returned: ‘"all"’ (default), ‘"first"’ or
          ‘"last"’.

    roll: When ‘i’ is a ‘data.table’ and its row matches to all but the
          last ‘x’ join column, and its value in the last ‘i’ join
          column falls in a gap (including after the last observation
          in ‘x’ for that group), then:

            • ‘+Inf’ (or ‘TRUE’) rolls the _prevailing_ value in ‘x’
              forward. It is also known as last observation carried
              forward (LOCF).

            • ‘-Inf’ rolls backwards instead; i.e., next observation
              carried backward (NOCB).

            • finite positive or negative number limits how far values
              are carried forward or backward.

            • "nearest" rolls the nearest value instead.

          Rolling joins apply to the last join column, generally a date
          but can be any variable. It is particularly fast using a
          modified binary search.

          A common idiom is to select a contemporaneous regular time
          series (‘dts’) across a set of identifiers (‘ids’):
          ‘DT[CJ(ids,dts),roll=TRUE]’ where ‘DT’ has a 2-column key
          (id,date) and ‘CJ’ stands for _cross join_.

rollends: A logical vector length 2 (a single logical is recycled)
          indicating whether values falling before the first value or
          after the last value for a group should be rolled as well.

            • If ‘rollends[2]=TRUE’, it will roll the last value
              forward. ‘TRUE’ by default for LOCF and ‘FALSE’ for NOCB
              rolls.

            • If ‘rollends[1]=TRUE’, it will roll the first value
              backward. ‘TRUE’ by default for NOCB and ‘FALSE’ for LOCF
              rolls.

          When ‘roll’ is a finite number, that limit is also applied
          when rolling the ends.

   which: ‘TRUE’ returns the row numbers of ‘x’ that ‘i’ matches to. If
          ‘NA’, returns the row numbers of ‘i’ that have no match in
          ‘x’. By default ‘FALSE’ and the rows in ‘x’ that match are
          returned.

 .SDcols: Specifies the columns of ‘x’ to be included in the special
          symbol ‘.SD’ which stands for ‘Subset of data.table’. May be
          character column names, numeric positions, logical, a
          function name such as `is.numeric`, or a function call such
          as `patterns()`. `.SDcols` is particularly useful for speed
          when applying a function through a subset of (possible very
          many) columns by group; e.g., ‘DT[, lapply(.SD, sum),
          by="x,y", .SDcols=301:350]’.

          For convenient interactive use, the form ‘startcol:endcol’ is
          also allowed (as in ‘by’), e.g., ‘DT[, lapply(.SD, sum),
          by=x:y, .SDcols=a:f]’.

          Inversion (column dropping instead of keeping) can be
          accomplished be prepending the argument with ‘!’ or ‘-’
          (there's no difference between these), e.g. ‘.SDcols =
          !c('x', 'y')’.

          Finally, you can filter columns to include in ‘.SD’ based on
          their _names_ according to regular expressions via
          ‘.SDcols=patterns(regex1, regex2, ...)’. The included columns
          will be the _intersection_ of the columns identified by each
          pattern; pattern unions can easily be specified with ‘|’ in a
          regex. You can filter columns on ‘values’ by passing a
          function, e.g. ‘.SDcols=is.numeric’. You can also invert a
          pattern as usual with ‘.SDcols=!patterns(...)’ or
          ‘.SDcols=!is.numeric’.

 verbose: ‘TRUE’ turns on status and information messages to the
          console. Turn this on by default using
          ‘options(datatable.verbose=TRUE)’. The quantity and types of
          verbosity may be expanded in future.

allow.cartesian: ‘FALSE’ prevents joins that would result in more than
          ‘nrow(x)+nrow(i)’ rows. This is usually caused by duplicate
          values in ‘i’'s join columns, each of which join to the same
          group in `x` over and over again: a _misspecified_ join.
          Usually this was not intended and the join needs to be
          changed. The word 'cartesian' is used loosely in this
          context. The traditional cartesian join is (deliberately)
          difficult to achieve in ‘data.table’: where every row in ‘i’
          joins to every row in ‘x’ (a ‘nrow(x)*nrow(i)’ row result).
          'cartesian' is just meant in a 'large multiplicative' sense,
          so FALSE does not always prevent a traditional cartesian
          join.

    drop: Never used by ‘data.table’. Do not use. It needs to be here
          because ‘data.table’ inherits from ‘data.frame’. See
          ‘vignette("datatable-faq")’.

      on: Indicate which columns in ‘x’ should be joined with which
          columns in ‘i’ along with the type of binary operator to join
          with (see non-equi joins below on this). When specified, this
          overrides the keys set on ‘x’ and ‘i’. When ‘.NATURAL’
          keyword provided then _natural join_ is made (join on common
          columns). There are multiple ways of specifying the ‘on’
          argument:

            • As an unnamed character vector, e.g., ‘X[Y, on=c("a",
              "b")]’, used when columns ‘a’ and ‘b’ are common to both
              ‘X’ and ‘Y’.

            • _Foreign key joins_: As a _named_ character vector when
              the join columns have different names in ‘X’ and ‘Y’.
              For example, ‘X[Y, on=c(x1="y1", x2="y2")]’ joins ‘X’ and
              ‘Y’ by matching columns ‘x1’ and ‘x2’ in ‘X’ with columns
              ‘y1’ and ‘y2’ in ‘Y’, respectively.

              From v1.9.8, you can also express foreign key joins using
              the binary operator ‘==’, e.g. ‘X[Y, on=c("x1==y1",
              "x2==y2")]’.

              NB: shorthand like ‘X[Y, on=c("a", V2="b")]’ is also
              possible if, e.g., column ‘"a"’ is common between the two
              tables.

            • For convenience during interactive scenarios, it is also
              possible to use ‘.()’ syntax as ‘X[Y, on=.(a, b)]’.

            • From v1.9.8, (non-equi) joins using binary operators ‘>=,
              >, <=, <’ are also possible, e.g., ‘X[Y, on=c("x>=a",
              "y<=b")]’, or for interactive use as ‘X[Y, on=.(x>=a,
              y<=b)]’.

          See examples as well as
          ‘vignette("datatable-secondary-indices-and-auto-indexing")’.

     env: List or an environment, passed to ‘substitute2’ for
          substitution of parameters in ‘i’, ‘j’ and ‘by’ (or ‘keyby’).
          Use ‘verbose’ to preview constructed expressions.
 	
Details:

     ‘data.table’ builds on base R functionality to reduce 2 types of
     time:

       1. programming time (easier to write, read, debug and maintain),
          and

       2. compute time (fast and memory efficient).

     The general form of data.table syntax is:

         DT[ i,  j,  by ] # + extra arguments
             |   |   |
             |   |    -------> grouped by what?
             |    -------> what to do?
              ---> on which rows?
     
     The way to read this out loud is: "Take ‘DT’, subset rows by ‘i’,
     _then_ compute ‘j’ grouped by ‘by’. Here are some basic usage
     examples expanding on this definition. See the vignette (and
     examples) for working examples.

         X[, a]                      # return col 'a' from X as vector. If not found, search in parent frame.
         X[, .(a)]                   # same as above, but return as a data.table.
         X[, sum(a)]                 # return sum(a) as a vector (with same scoping rules as above)
         X[, .(sum(a)), by=c]        # get sum(a) grouped by 'c'.
         X[, sum(a), by=c]           # same as above, .() can be omitted in j and by on single expression for convenience
         X[, sum(a), by=c:f]         # get sum(a) grouped by all columns in between 'c' and 'f' (both inclusive)
     
         X[, sum(a), keyby=b]        # get sum(a) grouped by 'b', and sort that result by the grouping column 'b'
         X[, sum(a), by=b, keyby=TRUE] # same order as above, but using sorting flag
         X[, sum(a), by=b][order(b)] # same order as above, but by chaining compound expressions
         X[c>1, sum(a), by=c]        # get rows where c>1 is TRUE, and on those rows, get sum(a) grouped by 'c'
         X[Y, .(a, b), on="c"]       # get rows where Y$c == X$c, and select columns 'X$a' and 'X$b' for those rows
         X[Y, .(a, i.a), on="c"]     # get rows where Y$c == X$c, and then select 'X$a' and 'Y$a' (=i.a)
         X[Y, sum(a*i.a), on="c" by=.EACHI] # for *each* 'Y$c', get sum(a*i.a) on matching rows in 'X$c'
     
         X[, plot(a, b), by=c]       # j accepts any expression, generates plot for each group and returns no data
         # see ?assign to add/update/delete columns by reference using the same consistent interface
     
     A ‘data.table’ query may be invoked on a ‘data.frame’ using
     functional form ‘DT(...)’, see examples. The class of the input is
     retained.

     A ‘data.table’ is a ‘list’ of vectors, just like a ‘data.frame’.
     However :

       1. it never has or uses rownames. Rownames based indexing can be
          done by setting a _key_ of one or more columns or done
          _ad-hoc_ using the ‘on’ argument (now preferred).

       2. it has enhanced functionality in ‘[.data.table’ for fast
          joins of keyed tables, fast aggregation, fast last
          observation carried forward (LOCF) and fast add/modify/delete
          of columns by reference with no copy at all.

     See the ‘see also’ section for the several other _methods_ that
     are available for operating on data.tables efficiently.

Note:

     If ‘keep.rownames’ or ‘check.names’ are supplied they must be
     written in full because R does not allow partial argument names
     after ‘...’. For example, ‘data.table(DF, keep=TRUE)’ will create
     a column called ‘keep’ containing ‘TRUE’ and this is correct
     behaviour; ‘data.table(DF, keep.rownames=TRUE)’ was intended.

     ‘POSIXlt’ is not supported as a column type because it uses 40
     bytes to store a single datetime. They are implicitly converted to
     ‘POSIXct’ type with _warning_. You may also be interested in
     ‘IDateTime’ instead; it has methods to convert to and from
     ‘POSIXlt’.

References:

      |https://r-datatable.com| (‘data.table’ homepage)
      |https://en.wikipedia.org/wiki/Binary_search|

See Also:

     ‘special-symbols’, ‘data.frame’, ‘[.data.frame’, ‘as.data.table’,
     ‘setkey’, ‘setorder’, ‘setDT’, ‘setDF’, ‘J’, ‘SJ’, ‘CJ’,
     ‘merge.data.table’, ‘tables’, ‘test.data.table’, ‘IDateTime’,
     ‘unique.data.table’, ‘copy’, ‘:=’, ‘setalloccol’, ‘truelength’,
     ‘rbindlist’, ‘setNumericRounding’, ‘datatable-optimize’,
     ‘fsetdiff’, ‘funion’, ‘fintersect’, ‘fsetequal’, ‘anyDuplicated’,
     ‘uniqueN’, ‘rowid’, ‘rleid’, ‘na.omit’, ‘frank’

Examples:

     ## Not run:
     
     example(data.table)  # to run these examples yourself
     ## End(Not run)
     
     DF = data.frame(x=rep(c("b","a","c"),each=3), y=c(1,3,6), v=1:9)
     DT = data.table(x=rep(c("b","a","c"),each=3), y=c(1,3,6), v=1:9)
     DF
     DT
     identical(dim(DT), dim(DF))    # TRUE
     identical(DF$a, DT$a)          # TRUE
     is.list(DF)                    # TRUE
     is.list(DT)                    # TRUE
     
     is.data.frame(DT)              # TRUE
     
     tables()
     
     # basic row subset operations
     DT[2]                          # 2nd row
     DT[3:2]                        # 3rd and 2nd row
     DT[order(x)]                   # no need for order(DT$x)
     DT[order(x), ]                 # same as above. The ',' is optional
     DT[y>2]                        # all rows where DT$y > 2
     DT[y>2 & v>5]                  # compound logical expressions
     DT[!2:4]                       # all rows other than 2:4
     DT[-(2:4)]                     # same
     
     # select|compute columns data.table way
     DT[, v]                        # v column (as vector)
     DT[, list(v)]                  # v column (as data.table)
     DT[, .(v)]                     # same as above, .() is a shorthand alias to list()
     DT[, sum(v)]                   # sum of column v, returned as vector
     DT[, .(sum(v))]                # same, but return data.table (column autonamed V1)
     DT[, .(sv=sum(v))]             # same, but column named "sv"
     DT[, .(v, v*2)]                # return two column data.table, v and v*2
     
     # subset rows and select|compute data.table way
     DT[2:3, sum(v)]                # sum(v) over rows 2 and 3, return vector
     DT[2:3, .(sum(v))]             # same, but return data.table with column V1
     DT[2:3, .(sv=sum(v))]          # same, but return data.table with column sv
     DT[2:5, cat(v, "\n")]          # just for j's side effect
     
     # select columns the data.frame way
     DT[, 2]                        # 2nd column, returns a data.table always
     colNum = 2
     DT[, ..colNum]                 # same, .. prefix conveys one-level-up in calling scope
     DT[["v"]]                      # same as DT[, v] but faster if called in a loop
     
     # grouping operations - j and by
     DT[, sum(v), by=x]             # ad hoc by, order of groups preserved in result
     DT[, sum(v), keyby=x]          # same, but order the result on by cols
     DT[, sum(v), by=x, keyby=TRUE] # same, but using sorting flag
     DT[, sum(v), by=x][order(x)]   # same but by chaining expressions together
     
     # fast ad hoc row subsets (subsets as joins)
     DT["a", on="x"]                # same as x == "a" but uses binary search (fast)
     DT["a", on=.(x)]               # same, for convenience, no need to quote every column
     DT[.("a"), on="x"]             # same
     DT[x=="a"]                     # same, single "==" internally optimised to use binary search (fast)
     DT[x!="b" | y!=3]              # not yet optimized, currently vector scan subset
     DT[.("b", 3), on=c("x", "y")]  # join on columns x,y of DT; uses binary search (fast)
     DT[.("b", 3), on=.(x, y)]      # same, but using on=.()
     DT[.("b", 1:2), on=c("x", "y")]             # no match returns NA
     DT[.("b", 1:2), on=.(x, y), nomatch=NULL]   # no match row is not returned
     DT[.("b", 1:2), on=c("x", "y"), roll=Inf]   # locf, nomatch row gets rolled by previous row
     DT[.("b", 1:2), on=.(x, y), roll=-Inf]      # nocb, nomatch row gets rolled by next row
     DT["b", sum(v*y), on="x"]                   # on rows where DT$x=="b", calculate sum(v*y)
     
     # all together now
     DT[x!="a", sum(v), by=x]                    # get sum(v) by "x" for each i != "a"
     DT[!"a", sum(v), by=.EACHI, on="x"]         # same, but using subsets-as-joins
     DT[c("b","c"), sum(v), by=.EACHI, on="x"]   # same
     DT[c("b","c"), sum(v), by=.EACHI, on=.(x)]  # same, using on=.()
     
     # joins as subsets
     X = data.table(x=c("c","b"), v=8:7, foo=c(4,2))
     X
     
     DT[X, on="x"]                         # right join
     X[DT, on="x"]                         # left join
     DT[X, on="x", nomatch=NULL]           # inner join
     DT[!X, on="x"]                        # not join
     DT[X, on=c(y="v")]                    # join using column "y" of DT with column "v" of X
     DT[X, on="y==v"]                      # same as above (v1.9.8+)
     
     DT[X, on=.(y<=foo)]                   # NEW non-equi join (v1.9.8+)
     DT[X, on="y<=foo"]                    # same as above
     DT[X, on=c("y<=foo")]                 # same as above
     DT[X, on=.(y>=foo)]                   # NEW non-equi join (v1.9.8+)
     DT[X, on=.(x, y<=foo)]                # NEW non-equi join (v1.9.8+)
     DT[X, .(x,y,x.y,v), on=.(x, y>=foo)]  # Select x's join columns as well
     
     DT[X, on="x", mult="first"]           # first row of each group
     DT[X, on="x", mult="last"]            # last row of each group
     DT[X, sum(v), by=.EACHI, on="x"]      # join and eval j for each row in i
     DT[X, sum(v)*foo, by=.EACHI, on="x"]  # join inherited scope
     DT[X, sum(v)*i.v, by=.EACHI, on="x"]  # 'i,v' refers to X's v column
     DT[X, on=.(x, v>=v), sum(y)*foo, by=.EACHI] # NEW non-equi join with by=.EACHI (v1.9.8+)
     
     # setting keys
     kDT = copy(DT)                        # (deep) copy DT to kDT to work with it.
     setkey(kDT,x)                         # set a 1-column key. No quotes, for convenience.
     setkeyv(kDT,"x")                      # same (v in setkeyv stands for vector)
     v="x"
     setkeyv(kDT,v)                        # same
     # key(kDT)<-"x"                       # copies whole table, please use set* functions instead
     haskey(kDT)                           # TRUE
     key(kDT)                              # "x"
     
     # fast *keyed* subsets
     kDT["a"]                              # subset-as-join on *key* column 'x'
     kDT["a", on="x"]                      # same, being explicit using 'on=' (preferred)
     
     # all together
     kDT[!"a", sum(v), by=.EACHI]          # get sum(v) for each i != "a"
     
     # multi-column key
     setkey(kDT,x,y)                       # 2-column key
     setkeyv(kDT,c("x","y"))               # same
     
     # fast *keyed* subsets on multi-column key
     kDT["a"]                              # join to 1st column of key
     kDT["a", on="x"]                      # on= is optional, but is preferred
     kDT[.("a")]                           # same, .() is an alias for list()
     kDT[list("a")]                        # same
     kDT[.("a", 3)]                        # join to 2 columns
     kDT[.("a", 3:6)]                      # join 4 rows (2 missing)
     kDT[.("a", 3:6), nomatch=NULL]        # remove missing
     kDT[.("a", 3:6), roll=TRUE]           # locf rolling join
     kDT[.("a", 3:6), roll=Inf]            # same as above
     kDT[.("a", 3:6), roll=-Inf]           # nocb rolling join
     kDT[!.("a")]                          # not join
     kDT[!"a"]                             # same
     
     # more on special symbols, see also ?"special-symbols"
     DT[.N]                                  # last row
     DT[, .N]                                # total number of rows in DT
     DT[, .N, by=x]                          # number of rows in each group
     DT[, .SD, .SDcols=x:y]                  # select columns 'x' through 'y'
     DT[ , .SD, .SDcols = !x:y]              # drop columns 'x' through 'y'
     DT[ , .SD, .SDcols = patterns('^[xv]')] # select columns matching '^x' or '^v'
     DT[, .SD[1]]                            # first row of all columns
     DT[, .SD[1], by=x]                      # first row of 'y' and 'v' for each group in 'x'
     DT[, c(.N, lapply(.SD, sum)), by=x]     # get rows *and* sum columns 'v' and 'y' by group
     DT[, .I[1], by=x]                       # row number in DT corresponding to each group
     DT[, grp := .GRP, by=x]                 # add a group counter column
     DT[ , dput(.BY), by=.(x,y)]             # .BY is a list of singletons for each group
     X[, DT[.BY, y, on="x"], by=x]           # join within each group
     DT[, {
       # write each group to a different file
       fwrite(.SD, file.path(tempdir(), paste0('x=', .BY$x, '.csv')))
     }, by=x]
     dir(tempdir())
     
     # add/update/delete by reference (see ?assign)
     print(DT[, z:=42L])                   # add new column by reference
     print(DT[, z:=NULL])                  # remove column by reference
     print(DT["a", v:=42L, on="x"])        # subassign to existing v column by reference
     print(DT["b", v2:=84L, on="x"])       # subassign to new column by reference (NA padded)
     
     DT[, m:=mean(v), by=x][]              # add new column by reference by group
                                           # NB: postfix [] is shortcut to print()
     # advanced usage
     DT = data.table(x=rep(c("b","a","c"),each=3), v=c(1,1,1,2,2,1,1,2,2), y=c(1,3,6), a=1:9, b=9:1)
     
     DT[, sum(v), by=.(y%%2)]              # expressions in by
     DT[, sum(v), by=.(bool = y%%2)]       # same, using a named list to change by column name
     DT[, .SD[2], by=x]                    # get 2nd row of each group
     DT[, tail(.SD,2), by=x]               # last 2 rows of each group
     DT[, lapply(.SD, sum), by=x]          # sum of all (other) columns for each group
     DT[, .SD[which.min(v)], by=x]         # nested query by group
     
     DT[, list(MySum=sum(v),
               MyMin=min(v),
               MyMax=max(v)),
         by=.(x, y%%2)]                    # by 2 expressions
     
     DT[, .(a = .(a), b = .(b)), by=x]     # list columns
     DT[, .(seq = min(a):max(b)), by=x]    # j is not limited to just aggregations
     DT[, sum(v), by=x][V1<20]             # compound query
     DT[, sum(v), by=x][order(-V1)]        # ordering results
     DT[, c(.N, lapply(.SD,sum)), by=x]    # get number of observations and sum per group
     DT[, {tmp <- mean(y);
           .(a = a-tmp, b = b-tmp)
           }, by=x]                        # anonymous lambda in 'j', j accepts any valid
                                           # expression. TO REMEMBER: every element of
                                           # the list becomes a column in result.
     pdf("new.pdf")
     DT[, plot(a,b), by=x]                 # can also plot in 'j'
     dev.off()
     
     
     # using rleid, get max(y) and min of all cols in .SDcols for each consecutive run of 'v'
     DT[, c(.(y=max(y)), lapply(.SD, min)), by=rleid(v), .SDcols=v:b]
     
     # functional query DT(...)
     
     ## Not run:
     
     mtcars |> DT(mpg>20, .(mean_hp=mean(hp)), by=cyl)
     ## End(Not run)
     
     
     # Support guide and links:
     # https://github.com/Rdatatable/data.table/wiki/Support
     
     ## Not run:
     
     if (interactive()) {
       vignette(package="data.table")  # 9 vignettes
     
       test.data.table()               # 6,000 tests
     
       # keep up to date with latest stable version on CRAN
       update.packages()
     
       # get the latest devel version
       update.dev.pkg()
       # read more at:
       # https://github.com/Rdatatable/data.table/wiki/Installation
     }
     ## End(Not run)
     
###

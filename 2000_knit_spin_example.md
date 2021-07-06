This is a special R script which can be used to generate a report. You can
write normal text in roxygen comments.

First we set up some options (you do not have to do this):



The report begins here.


```r
# boring examples as usual
set.seed(123)
x = rnorm(5)
mean(x)
## [1] 0.194
```

You can use the special syntax {{code}} to embed inline expressions, e.g.
`2.194`
is the mean of x plus 2.
The code itself may contain braces, but these are not checked.  Thus,
perfectly valid (though very strange) R code such as `{{2 + 3}} - {{4 - 5}}`
can lead to errors because `2 + 3}} - {{4 - 5` will be treated as inline code.

Now we continue writing the report. We can draw plots as well.


```r
par(mar = c(4, 4, .1, .1)); plot(x)
```

![plot of chunk test-b](figure/test-b-1.png)

Actually you do not have to write chunk options, in which case knitr will use
default options. For example, the code below has no options attached:


```r
var(x)
## [1] 0.658
quantile(x)
##      0%     25%     50%     75%    100% 
## -0.5605 -0.2302  0.0705  0.1293  1.5587
```

And you can also write two chunks successively like this:


```r
sum(x^2) # chi-square distribution with df 5
## [1] 2.82
```

```r
sum((x - mean(x))^2) # df is 4 now
## [1] 2.63
```

Done. Call spin('knitr-spin.R') to make silk from sow's ear now and knit a
lovely purse.

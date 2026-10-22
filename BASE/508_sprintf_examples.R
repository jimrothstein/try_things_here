

\footnotesize{this is footnotesize}

### sprintf:
  * sprintf(x, FORMAT)
  * wrapper for os command

```{r sprint}
sprintf("hello %s", "jim")
sprintf("hello %s", 23)

sprintf("hello %01s", 23)         # min of 1 space
sprintf("hello %02s", 23)         # min of 2
sprintf("hello %03s", 23)         # min of 3
sprintf("hello %04s", 23)         # min of 4
# [1] "hello   23"


sprintf("hello %04f", 23)         # 23.000000
# [1] "hello 23.000000"
sprintf("hello %04i", 23)         # int, min of 4 digits
# [1] "hello 0023"

sprintf(fmt='%5.2f', pi)    # 1 space to LEFT
# [1] " 3.14"
sprintf(fmt='%-5.2f', pi)    # 1 space to RIGHT
# [1] "3.14 "



##  tricky
  n = 3
  x  <- paste0("e with %2d digits= %.", n, "g")
  x
  sprintf(x, n, exp(1))       # e with 3 digits=2.72

# 4, 5 digits
sprintf("e = %.4g", exp(1))
sprintf("e = %.5g", exp(1))   # 2.7183
sprintf("e = %.5f", exp(1))   # 2.71828

sprintf("e = %5.2f", exp(1))   # 2.72
sprintf("e = %5.3f", exp(1))   # 2.718


## exponential
sprintf("e = %5.2g", 1e6 * exp(1))   # 2.7e+06
sprintf("e = %5.3g", 1e6 * exp(1))   # 2.72e+06
sprintf("e = %5.3g", 1e9 * exp(1))   # 2.72e+06
sprintf("e = %.3g", 1e9 * exp(1))   #
sprintf("e = %.8g", 1e9 * exp(1))   # 2.71882818e...

##  spacing after `=`
  sprintf('e = %9.3e', exp(1))
# [1] "e = 2.718e+00"
  sprintf('e = %10.3e', exp(1))
# [1] "e =  2.718e+00"
  sprintf('e = %20.3e', exp(1))
# [1] "e =            2.718e+00"


sprintf("10^7 = %.3g", 10^7)
sprintf("10^7 = %.4g", 10^7)
sprintf("10^7 = %7.4g", 10^7)
sprintf("10^7 = %7.4G", 10^7)
sprintf("10^7 = %7.4f", 10^7)

# five digits,  great for prefix!
  N  <- 10 
  sprintf("%05i", 1:N)


  sprintf("This is e= %f", exp(1))
  sprintf("This is e= %f", exp(1))

  sprintf("This is exponential %02e", 1000)


```

### sprintf examples from help
```{r from_help}
     sprintf("%f", pi)
     sprintf("%.3f", pi)   # 3 decimal places
     sprintf("%1.0f", pi)
     sprintf("%5.1f", pi)
     sprintf("%05.1f", pi)
     sprintf("%+f", pi)
     sprintf("% f", pi)
     sprintf("%-10f", pi) # left justified
     sprintf("%e", pi)
     sprintf("%.3e", pi)  # 3 digits
     sprintf("%E", pi)
     sprintf("%g", pi)
     sprintf("%g",   1e6 * pi) # -> exponential
     sprintf("%.9g", 1e6 * pi) # -> "fixed"
     sprintf("%G", 1e-6 * pi)
```



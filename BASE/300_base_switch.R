#### switch()
###
###
###
```
Since I never remember the `switch` code, here is an example:

```

##  convert yes/no answers to 1,0

start = c("yes", "yes", "no", "")

end = sapply(start, function(e) switch(e, 
                                       yes = 1, 
                                       no = 0, 
                                       "bad data"), 
                                 USE.NAMES=F)
end
# [1] "1"        "1"        "0"        "bad data"



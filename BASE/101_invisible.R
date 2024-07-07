#   TAGS:   
https://ivelasq.rbind.io/blog/not-so-basic-base-r-functions/

### invisible, returns object, but does not print
```{r}
f1 <- function(x) x
f2 <- function(x) invisible(x)

f1("This prints")

f2("This does not print")
(f2("This does not print"))
z <- f2("This does not print")
z
```
```{r}
webr::install("purrr")
```

## remote quotes
```{r}
z <- "quote me"

print(z)
print(z, quote = F)

noquote(z)

noquote
noquote(invisible(z)) # why does this print?
a <- noquote(invisible(z))
a
```
### sets attributes of obj to class = "noquote"
```{r}
q <- function(obj, right = FALSE) {
  if (!inherits(obj, "noquote")) {
    browser()
  }
  class(obj) <- c(
    attr(obj, "class"),
    if (right) c(right = "noquote
") else "noquote"
  )


  obj
}
q("abc")
```


vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnrc foldcolumn=1 cc=+1

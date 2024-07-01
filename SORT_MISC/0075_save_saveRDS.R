# Simple code examples

# ---- ifelse() ----

x <- ifelse(5 > 3, TRUE, FALSE)
print(x)

x <- ifelse("a" %in% c("a", "b"),
  TRUE, FALSE
)
y <- ifelse("c" %in% c("a", "b"),
  TRUE, FALSE
)
print(x)
print(y)


# ---- save vs saveRDS(preferred)----

x <- 3
save(x, file = "temp.RDATA")

# check
system("ls") # dir() also works
dir()

x <- 0
load("temp.RDATA")
print(x) # x=3 !

# clean up
system("rm temp.RDATA")
dir()

x <- 4
# best for 1 object
saveRDS(x, file = "t.RDS")

# check
dir()

x <- 0
readRDS("t.RDS")
x # x=4

# cleanup
system("rm t.RDS")
dir()


save.image() # if no name, ".RData"
system("rm .RData")

#

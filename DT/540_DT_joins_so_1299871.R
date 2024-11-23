library(data.table)

{
  df1 <- data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
  df2 <- data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

  dt1 <- as.data.table(df1)
  dt2 <- as.data.table(df2)
  setkey(dt1, CustomerId)
  setkey(dt2, CustomerId)

  # right outer join keyed data.tables
  dt1[dt2]
}


# unkey
{
  setkey(dt1, NULL)
  setkey(dt2, NULL)

  dt1[dt2, on = .(CustomerId)]

  identical(dt1[dt2, on = .(CustomerId)], dt1[dt2, on = "CustomerId"])
}

# walk down dt1, 1:6
{
  dt2[dt1, on = .(CustomerId)]
}

# inner
{
  dt1[dt2, nomatch = NULL, on = .(CustomerId)]
}

# add row to dt2
{
  newDT <- data.table(CustomerId = c(99), State = "Mars")
  dt3 <- rbindlist(list(dt2, newDT))

  dt1
  dt3
  dt1[dt3, on = .(CustomerId)]
}

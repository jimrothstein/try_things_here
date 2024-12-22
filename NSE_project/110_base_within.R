# base::within
# how useful?   given an envir() and expression

within(mtcars, log(hp))
within(mtcars, { z = log(hp)})

# returns list $a = 1 , $b =2, $z =3
within(list(a=1, b=2), {z = quote(a+ b)})

# list, values for a, b and $z=3
within(list(a=1, b=2), {z = (a+ b)})

# error,  no y
within(list(a=1, b=y), quote(a+ b))

?within


a=100
b=200
res = with(globalenv(), expr = {z=a+b})
res   #300

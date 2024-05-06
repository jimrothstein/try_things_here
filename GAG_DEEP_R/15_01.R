                                        # Chapter 15_01

First deal with syntax (not semantics).  mean() could just as well be nobody()

Expressions are just list or sequences of
- names (constants,  names or symbols),
- calls ( (f,e1,e2,e3..) (unevaluated functions)

         Don't try to read to much more;  terminology gets confusing

# quote can create expressions or pieces of... 

quote(spam)   # symbol
quote(f(x))# call
quote(1+2+3*pi) # a call, because unevaluated 


# convert string to name
as.name("jim")


# build expressions (calls here) by progam
call("sin", pi/2)
call("sin", quote(pi/2))

call("c", 1, exp(1), quote(exp(1)), pi, quote(pi))

# another way to create expressions  (quotes all arguments)13k
(exprs <- expression(1, spam, mean(x)+2))

typeof(exprs)  # expression !

# list-like
exprs
length(exprs) # 3
names(exprs) # NULL

## Exercise
c(1, "two", sd, list(3, 4:5), expression(3+3))


parse(text=1)
parse(text='call("sin", pi)')
parse(text=call("sin", pi))
parse(text=quote(1+1))

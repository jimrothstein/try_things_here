# 		02/07/2024

fake_commnet ={"
	SOURCE:  GUS
 if ... else if ... else ... would become if(..., T, if(..., T, F)) which looks confusing.I'd probably break it down like so:

    x <- if(..., T, F) or fun(var = if(..., T, F)) for a short inline assignment

    x <- if ... else ... is also valid, but I'm probably going to use the functional if() now instead

    if (...) x <- T else y <- F where different things happen in the if and else on one line
    if ... else if ... else ... where different things happen in many lines
    x <- F; if (...) x <- T; (an odd one, but it ha
"}

`if`(6>2, 6, 2)

# FAILS
if(F)
{
	if(6>2, 6, 2)

	try(expr = if 6>2  6 else 2, silent=T) 
}

try(expr = if (6>2)  6 else 2,
silent=F)

if (6>2)  6 else 2

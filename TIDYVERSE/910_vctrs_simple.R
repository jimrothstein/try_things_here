                                        # Simple Examples of vctrs::
# Tags:  vctrs::, vec_chop
library(vctrs)


# indices has 2 elements; expect 2 lists to  be returned
vctrs::vec_chop(LETTERS, indices=list(1:2, 4:6))


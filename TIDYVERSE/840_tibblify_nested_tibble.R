library(tibblify)

df <- tibble(
        id = 1L,
        name = "a",
        children = list(
                tibble( # children list has ONE element
                        id = 11:12,
                        name = c("b", "c"),
                        children = list(
                                NULL,
                                tibble(
                                        id = 121:122,
                                        name = c("d", "e")
                                )
                        )
                )
        )
)

df
# # A tibble: 1 × 3
#      id name  children
#   <int> <chr> <list>
# 1     1 a     <tibble [2 × 3]>

length(df$children) # [1] 1

## And this ONE element is a tibble:

df$children[1]
# [[1]]
# # A tibble: 2 × 3
#      id name  children
#   <int> <chr> <list>
# 1    11 b     <NULL>
# 2    12 c     <tibble [2 × 2]>


df$children
# [[1]]
# # A tibble: 2 × 3
#      id name  children
#   <int> <chr> <list>
# 1    11 b     <NULL>
# 2    12 c     <tibble [2 × 2]>

unnest_tree(
        df,
        child_col = "children",
        level_to = "level",
        parent_to = "parent",
        ancestors_to = "ancestors"
)


# ----------------------------------------
#   Problem:   Columns holding variables
# ----------------------------------------
07_pivot_longer_wider_stocks_two_new_variables.R

# REF?

Another pivot_wider example (not corrrect)
Here there are 2 sets of need to be fixed
# ----
ID *
Plan *
Year *
Stock *
Value
# ----
SEE vignette("pivot")
```{r}

df = data.frame(ID = "A", 
           Plan = "Ab", 
           Year = 2024, 
           Stock1_name = "stock 1", 
           Stock1_dollars = 100, 
           Stock2_name = "stock 2",  
           Stock2_dollars = 200)  
df
df |>  pivot_longer(cols = contains("_name"), 
                    names_to =  c("Stock", "Value"),
#                    names_pattern = contains("_dollars")
                    )






```
```{r}

```

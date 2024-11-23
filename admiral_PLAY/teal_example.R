install.packages("pak")
install.packages("gdtools")
pak::pkg_install(c("teal", "pharmaverseadam"))
# Step 1: import packages

library(teal)
library(pharmaverseadam)

# Step 2: create a teal data object
data <- cdisc_data(
  ADAE = pharmaverseadam::adae,
  ADSL = pharmaverseadam::adsl
)

# Step 3: initialize teal app
app <- init(
  data = data,
  modules = example_module()
)

# Step 4: run shiny app
shinyApp(app$ui, app$server)

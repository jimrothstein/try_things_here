# Load the necessary libraries
library(ggplot2)
# (to use |> version 4.1.0 of R is required, for lower versions we recommend %>% from magrittr)
library(magrittr)

# Create a scatter plot
mtcars %>%
  {
    ggplot2::ggplot(., aes(x = mpg, y = wt)) +
      ggplot2::geom_point()
  } %>%
  print()



# Repeat with line plot


library(gridify)
fig_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()


g <- gridify(fig_obj, layout = simple_layout())
class(g)


g <- g %>%
  set_cell("title", "Title") %>%
  set_cell("footer", "Footer")

print(g)


# More complex (more text slots to fill)
fig_obj <- ggplot2::ggplot(data = mtcars, ggplot2::aes(x = mpg, y = wt)) +
  ggplot2::geom_line()

g <- gridify(fig_obj, layout = complex_layout()) %>%
  set_cell("header_left", "Left Header") %>%
  set_cell("header_middle", "Middle Header") %>%
  set_cell("header_right", "Right Header") %>%
  set_cell("title", "Title") %>%
  set_cell("subtitle", "Subtitle") %>%
  set_cell("note", "Note") %>%
  set_cell("footer_left", "Left Footer") %>%
  set_cell("footer_middle", "Middle Footer") %>%
  set_cell("footer_right", "Right Footer")

print(g)



#------------------------ JSON Hack
library(jsonlite)

# 1. Create a list of your custom metadata
my_metadata <- list(
    title = "Alpha",
    header1 = 42,
    status = "Draft",
    tags = c("R", "Plot", "JSON")
)

# 2. Convert to a JSON string - we should use base R for that - we control what we convert
json_string <- toJSON(my_metadata, auto_unbox = TRUE)

# 3. Pass the JSON string to the title argument
png("json_metadata_plot.png", title = json_string)
plot(1:10, main = "Data Visualization")
dev.off()


#------------------------  stackoverlfow
# Source - https://stackoverflow.com/a/24254259
# Posted by jbaums, modified by community. See post 'Timeline' for change history
# Retrieved 2026-03-02, License - CC BY-SA 4.0
getexif <- function(file, exiftool='exiftool.exe', opts=NULL, 
                    intern=TRUE, simplify=FALSE) {
  # file: the file to be updated
  # exiftool: the path to the ExifTool binary
  # opts: additional arguments to ExifTool (optional)
  # intern: should a named vector of metadata be returned? (bool)
  # simplify: if intern==TRUE, should the results be returned as a named 
  #           vector (TRUE) or as a data.frame (FALSE)?
  arg <- c(opts, normalizePath(file))
  if(intern) {
    exif <- system2(normalizePath(exiftool), args=arg, stdout=TRUE)
    exif <- do.call(rbind, strsplit(exif, ' +: +', perl=T))
    row.names(exif) <- exif[, 1]
    exif[, 2, drop=simplify]
  } else {
    system2(normalizePath(exiftool), args=arg, stdout='')
  }
}


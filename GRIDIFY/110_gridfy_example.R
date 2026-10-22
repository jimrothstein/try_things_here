library(gridify)
# install.packages("gt")
# gt needs gtable
# install.packages("gtable")
library(gt)
# (to use |> version 4.1.0 of R is required, for lower versions we recommend %>% from magrittr)

pdf("gridify_mtcars.pdf")
tab <- gt::gt(head(mtcars, n = 10))  |>
  gt::tab_options(
    table.width = gt::pct(100),
    data_row.padding = gt::px(10),
    table_body.hlines.color = "white",
    # gt font size is in pixels
    # Multiply points by 96/72 to get pixels
    table.font.size = 10 * 96 / 72,
    table.font.names = "sans"
  )

# Use `gridify()` to create a `gridify` object
gridify_object <- gridify(
  object = tab,
  # Choose a layout (predefined or custom)
  layout = pharma_layout_base(
    margin = grid::unit(c(0.5, 0.5, 0.5, 0.5), "inches"),
    global_gpar = grid::gpar(fontfamily = "sans", fontsize = 10)
  )
)
# Print the `gridify` object to see empty cells
gridify_object
# Use `set_cell()` to fill in the various text elements in the layout (headers etc.)
gridify_object_fill <- gridify_object |>
  set_cell("header_left_1", "My Company") |>
  set_cell("header_left_2", "<PROJECT> / <INDICATION>") |>
  set_cell("header_left_3", "<STUDY>") |>
  set_cell("header_right_1", "CONFIDENTIAL") |>
  set_cell("header_right_2", "<Draft or Final>") |>
  set_cell("header_right_3", "Data Cut-off: YYYY-MM-DD") |>
  set_cell("output_num", "<Table> xx.xx.xx") |>
  set_cell("title_1", "<Title 1>") |>
  set_cell("title_2", "<Title 2>") |>
  set_cell("title_3", "<Optional Title 3>") |>
  set_cell("by_line", "By: <GROUP>, <optionally: Demographic parameters>") |>
  set_cell("note", "<Note or Footnotes>") |>
  set_cell("references", "<References:>") |>
  set_cell("footer_left", "Program: <PROGRAM NAME>, YYYY-MM-DD at HH:MM") |>
  set_cell("footer_right", "Page xx of nn") |>
  set_cell("watermark", "DRAFT")

gridify_object_fill

print(gridify_object_fill)
dev.off()

    # helpful info
    args(rmarkdown::render)

          ## function (input, output_format = NULL, output_file = NULL, output_dir = NULL, 
          ##     output_options = NULL, output_yaml = NULL, intermediates_dir = NULL, 
          ##     knit_root_dir = NULL, runtime = c("auto", "static", "shiny", 
          ##         "shinyrmd", "shiny_prerendered"), clean = TRUE, params = NULL, 
          ##     knit_meta = NULL, envir = parent.frame(), run_pandoc = TRUE, 
          ##     quiet = FALSE, encoding = "UTF-8") 
          ## NULL

    render_files  <- function(input=NULL, output_format=NULL, output_dir=NULL){

      # TODO:  run checks
      rmarkdown::render(input= input,
                        output_format=output_format,
                        output_dir = output_dir)
    }
    file  <- "rmd/0230_embed_latex.Rmd"
    file  <- basename(file)
    file  <- here("rmd", file)
    file

          ## [1] "/home/jim/code/try_things_here/rmd/0230_embed_latex.Rmd"

    render_files(input= file, output_format="md_document", output_dir="md")

          ## 
          ## 
          ## processing file: 0230_embed_latex.Rmd

          ## Error in parse_block(g[-1], g[1], params.src, markdown_mode): Duplicate chunk label 'setup', which has been used for the chunk:
          ## knitr::opts_chunk$set(echo = TRUE,
          ##                       comment = "      ##",
          ##                       error = TRUE,
          ##                       collapse = FALSE   ) # easier to read
          ## library(here)

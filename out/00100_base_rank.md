file=“/home/jim/.config/nvim/templates/skeleton.R”

    # RANK is each element's distance from lowest (smallest) bottom (=1)
    # 10 is always 3rd from bottom (which is 1 here)
    rank(c(10, 8, 1))  # 3, 2, 1

    ## [1] 3 2 1

    rank(c(10, 8, 3))

    ## [1] 3 2 1

    rank(c(1,10,8))

    ## [1] 1 3 2

    # R
    reprex::reprex( style= T, venue = "slack", x=

                   {
    #'  **Order vs rank**
                     #'
    #'  The function roll() picks 3 letters (from the first 10) and displays results several ways.   
    #'
    #'  Every now and then order and rank do not match, puzzling me.   
    #'



    #'  First, the roll function                
        roll  <- function(original = NULL) {

        # if user provides no original, pick sample  of 3
        if (is.null(original))
          original  <- sample(letters[1:10], size=3)

        #  
        list  <- list(original = original, 
                      sort = sort(original),
                      order = order(original),
                      rank = rank(original)
                      )

        }
    #' 
    #'  # let's try, examine the different ways to present:
        #
        (r  <- roll())
    #'

    #' Now, try with this specific choice, why do order and rank differ? 
    #'
        (r  <- roll(c("j", "d", "i")))
    #'
        #'
    })

    ## ℹ Non-interactive session, setting `html_preview = FALSE`.

    ## ℹ Rendering reprex...

    ## ✔ Reprex output is on the clipboard.

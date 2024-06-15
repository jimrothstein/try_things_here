
#' @title Puts into environment a list of toy datasets for testing. 
#'
#' @description Ad-hoc named list of toy dataframes first used for testing each check function and copied here.  List is structured first by name of check function and then 0, 1 or more dataframes.  Before use, the list must be unnested and assembled as required.

#'
#'
#' @param 
#' @param 
#' @param 
#'
#' @return Nested list of dataframes.
#'
#' @export
#'
#' @importFrom 
#'
#' @author jim rothstein [14JUNE2024]  
#' 
#' @family 
#' 
#' @keywords 
#'
#' @examples
#' toy_datasets = check_toy_datasets()
#'

check_toy_datasets = function(){

    L = list(
        check_ae_aeacnoth= list(
            AE1 <- data.frame(
                USUBJID = 1:7,
                AETERM = 1:7,
                AESTDTC = 1:7,
                AEACNOTH = 1:7,
                AEACNOT1 = 1:7,
                AEACNOT2 = 1:7,
                AESPID = "FORMNAME-R:13/L:13XXXX"),
            AE2 <- data.frame(
                #USUBJID = 1:7,
                AETERM = 1:7,
                AESTDTC = 1:7,
                AEACNOTH = 1:7,
                AEACNOT1 = 1:7,
                AEACNOT2 = 1:7,
                AESPID = "FORMNAME-R:13/L:13XXXX"),
            AE3 = data.frame(
               ##USUBJID = 1:7,
                AETERM = 1:7,
                AESTDTC = 1:7,
                AEACNOTH = 1:7,
                AEACNOT1 = 1:7,
                AEACNOT2 = 1:7,
                AESPID = "FORMNAME-R:13/L:13XXXX")
        ),
        check_ae_aedecode = list(
            AE <- data.frame(
                USUBJID = 1:5,
                DOMAIN = c(rep("AE", 5)),
                AESEQ = 1:5,
                AESTDTC = 1:5,
                AETERM = 1:5,
                AEDECOD = 1:5,
                AESPID = c("FORMNAME-R:13/L:13XXXX",
                            "FORMNAME-R:16/L:16XXXX",
                            "FORMNAME-R:2/L:2XXXX",
                            "FORMNAME-R:19/L:19XXXX",
                            "FORMNAME-R:5/L:5XXXX"),
                stringsAsFactors = FALSE)
        )
    )
    L
}

check_toy_datasets()

# -------------------

L

L["AE3"]

L["AE2"]

L[["AE2"]]
length(L)

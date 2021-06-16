#' This function is based on functions in tuneR package only faster
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export
f_discrets <- function(x, symb = 5, collapse = TRUE, plateau = 1){
  if (symb != 3 && symb != 5)
    stop("'symb' should be set to 3 or 5")
  x <- inputw(wave = x, f = NULL)$w

  y=data.table::as.data.table(x)
  y[ , plus1 := shift(V1 ,type = "lead")]
  y[ , plus2 := shift(plus1 ,type = "lead")]
  y$text=""
  if (plateau == 1) {

    y[V1 <= plus1 & plus1 < plus2]$text="I"
    y[V1 <= plus2 & plus2 <= plus1]$text="P"
    y[plus1 < V1 & V1 <= plus2]$text="T"
    y[plus1 < plus2 & plus2 <= V1]$text="T"

    y[plus2 < V1 & V1 <= plus1]$text="P"
    y[plus2 <= plus1 & plus1 < V1]$text="D"
    y[V1 == plus1 & plus1 == plus2]$text="F"
  }else if (plateau == 2) {

    y[V1 < plus1 & plus1 > plus2]$text="P"
    y[V1 > plus1 & plus1 < plus2]$text="T"
    y[V1 <= plus1 & plus1 <= plus2]$text="I"
    y[V1 >= plus1 & plus1 >= plus2]$text="D"
    y[V1 == plus1 & plus1 == plus2]$text="F"

  }

  return(y[nchar(text)>0]$text)
}
#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export
f_fpeaks=function (spec){
  sym <- f_discrets(spec[, 2], symb = 5, plateau = 1, collapse = FALSE)
  if (sym[1] == "I")
    sym[1] <- "T"
  if (sym[1] == "P")
    sym[1] <- "D"
  sym <- c(NA, sym, NA)
  peaks <- which(sym == "P")
  res <- matrix(na.omit(spec[peaks, ]), ncol = 2)
  colnames(res) <- c("freq", "amp")
  return(res)
}


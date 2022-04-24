
SingleDigitSubstitutions <- function(x) {
    stopifnot(is.character(x) & length(x) == 1 & all(grepl("^\\d*$", x)))

    y <- c()

    digits <- as.integer(unlist(strsplit(x, "")))
    for (i in seq(digits)) {
        for (j in setdiff(0:9, digits[i])) {
            new_digits <- digits
            new_digits[i] <- j
            y <- c(y, paste(new_digits, collapse = ""))
            rm(new_digits)
        }
        rm(j)
    }
    rm(i)

    return(y)
}

SingleAdjacentTranspositions <- function(x) {
    stopifnot(is.character(x) & length(x) == 1 & all(grepl("^\\d*$", x)))

    y <- c()

    if (nchar(x) > 1) {
        digits <- as.integer(unlist(strsplit(x, "")))
        for (i in seq(2, length(digits))) {
            index <- seq(digits)
            index[i - 1] <- index[i - 1] + 1
            index[i] <- index[i] - 1
            y <- c(y, paste(digits[index], collapse = ""))
            rm(index)
        }
        rm(i)
    }

    return(y)
}

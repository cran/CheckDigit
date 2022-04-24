
test_that("VerifyCheckDigit calls the appropriate function or throws errors", {
    expect_that(VerifyCheckDigit(), throws_error())
    expect_that(VerifyCheckDigit("12340"), throws_error())
    expect_that(VerifyCheckDigit(method = "Verhoeff"), throws_error())
    expect_that(VerifyCheckDigit(12340, "Verhoeff"), throws_error())
    expect_that(VerifyCheckDigit("12340", "foo"), throws_error())
    expect_that(VerifyCheckDigit("12340", "Verhoeff"), is_equivalent_to(TRUE))
})

test_that("VerifyCheckDigit.Verhoeff gives a warning when stripping non-digit characters", {
    expect_that(VerifyCheckDigit("867-5309", "Verhoeff"), gives_warning("Non-digit characters are disregarded in check digit calculation"))
})

test_that("VerifyCheckDigit.Verhoeff returns correct responses", {

    ## Missing values should return FALSE
    expect_that(VerifyCheckDigit("", "Verhoeff"), is_equivalent_to(FALSE))
    expect_that(VerifyCheckDigit(as.character(NA), "Verhoeff"), is_equivalent_to(FALSE))
    expect_that(suppressWarnings(VerifyCheckDigit(as.character(NaN), "Verhoeff")), is_equivalent_to(FALSE))

    ## Character arguments
    expect_that(VerifyCheckDigit("15", "Verhoeff"), is_equivalent_to(TRUE))
    expect_that(VerifyCheckDigit("12340", "Verhoeff"), is_equivalent_to(TRUE))
    expect_that(VerifyCheckDigit("86753098", "Verhoeff"), is_equivalent_to(TRUE))
    expect_that(VerifyCheckDigit("92233720368547758088", "Verhoeff"), is_equivalent_to(TRUE))

    ## Vectorized arguments
    expect_that(
        VerifyCheckDigit(
            c("", "15", "12340", "86753098", "92233720368547758088"),
            "Verhoeff"
        ),
        is_equivalent_to(
            c(FALSE, TRUE, TRUE, TRUE, TRUE)
        )
    )
})

test_that("Verhoeff check digit detects all single digit substitutions", {
    for (i in SingleDigitSubstitutions("86753098")) {
        expect_that(VerifyCheckDigit(i, "Verhoeff"), is_equivalent_to(FALSE))
    }
    rm(i)
})

test_that("Verhoeff check digit detects all single adjacent transpositions", {
    for (i in SingleAdjacentTranspositions("86753098")) {
        expect_that(VerifyCheckDigit(i, "Verhoeff"), is_equivalent_to(FALSE))
    }
    rm(i)
})

testthat::context("Knit")

Sys.setlocale('LC_ALL','C')

# Knit from template
testthat::test_that("Templates are knitted", {
  testthat::skip_on_cran()
  # knit all templates
  if (rmarkdown::pandoc_available()) {
    destination <- paste(getwd(), "/docs", sep="")
    knit_all(destination=destination)
    # Clean up
    unlink(destination, recursive = TRUE)
  }
})

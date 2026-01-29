# Knit

Create documents from templates

## Usage

``` r
knit_all(destination = usethis::proj_path("docs"), gallery = "gallery")

knit_template(
  template,
  output_format,
  destination = usethis::proj_path("docs"),
  gallery = "gallery"
)
```

## Arguments

- destination:

  name of the folder containing GitHub pages or equivalent.

- gallery:

  name of the subfolder of `destination` to store the knitted documents.

- template:

  name of the template to knit, e.g. "simple_article".

- output_format:

  A character vector of the output formats to convert to. Each value
  must be the name of a function producing an output format object, such
  as "bookdown::pdf_book".

## Value

`TRUE` if all documents have been knitted and copied to the gallery,
invisibly.

## Details

These functions are used to test the templates and produce a gallery.

- `knit_template()` produces an HTML and a PDF output of the chosen
  template.

- `knit_all()` runs knit_template() on all templates of the package. The
  `output_format` argument selects the way templates are rendered:

- articles may be rendered in HTML by
  [bookdown::html_document2](https://pkgs.rstudio.com/bookdown/reference/html_document2.html),
  [bookdown::gitbook](https://pkgs.rstudio.com/bookdown/reference/gitbook.html),
  [rmdformats::downcute](https://rdrr.io/pkg/rmdformats/man/downcute.html)
  (and others, see the package **rmdformats**) and in PDF by
  [bookdown::pdf_book](https://pkgs.rstudio.com/bookdown/reference/pdf_book.html).

- books may be rendered in HTML by
  [bookdown::gitbook](https://pkgs.rstudio.com/bookdown/reference/gitbook.html)
  or
  [bookdown::bs4_book](https://pkgs.rstudio.com/bookdown/reference/bs4_book.html)
  and in PDF by
  [bookdown::pdf_book](https://pkgs.rstudio.com/bookdown/reference/pdf_book.html).

- slides may be rendered in HTML by
  [bookdown::slidy_presentation2](https://pkgs.rstudio.com/bookdown/reference/html_document2.html),
  [bookdown::ioslides_presentation2](https://pkgs.rstudio.com/bookdown/reference/html_document2.html)
  and in PDF by
  [bookdown::beamer_presentation2](https://pkgs.rstudio.com/bookdown/reference/html_document2.html).

These functions are mainly used for test and documentation purposes. In
projects based on the templates, use the *Knit* button (articles,
presentations) or the *Build the Book* button (memoirs) or
[`bookdown::render_book()`](https://pkgs.rstudio.com/bookdown/reference/render_book.html).

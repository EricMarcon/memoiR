# Build GitHub Pages

Copy the files produced by knitting to the destination folder.

## Usage

``` r
build_githubpages(destination = usethis::proj_path("docs"))
```

## Arguments

- destination:

  destination folder of the knitted documents.

## Value

A vector with the names of the files and directory that were copied if
they existed (some may not be knitted), invisibly.

## Details

Produced files are HTML pages and their companions (css, figures,
libraries) and PDF documents. The function moves them all and the
`README.md` file into the destination folder. GitHub Pages allow making
a website to present them:

- `README.md` is the home page. Make it with
  [`build_readme()`](https://EricMarcon.github.io/memoiR/dev/reference/build_readme.md)
  to have links to the HTML and PDF outputs.

- knit both HTML and PDF versions to avoid dead links.

- run `build_githubpages()` when a document is knitted to move the
  outputs into the `docs` folder.

- push to GitHub and activate GitHub Pages on the main branch and the
  `docs` folder. The function is useless in book projects: the *Build
  the Book* (i.e. the
  [`bookdown::render_book()`](https://pkgs.rstudio.com/bookdown/reference/render_book.html)
  function) takes care of every step.

## Examples

``` r
if (FALSE) { # \dontrun{
## Simulate the creation of a new project
# Save working directory
original_wd <- getwd()
# Get a temporary working directory
wd <- tempfile("example")
# Simulate File > New File > R Markdown... > From Template > Simple Article
rmarkdown::draft(wd, template="simple_article", package="memoiR", edit=FALSE)
# Go to temp directory
setwd(wd)
# Make it the current project
usethis::proj_set(path = ".", force = TRUE)

## Sequence of actions to build a complete project
# Build .gitignore
build_gitignore()
## Activate source control, edit your files, commit
# Build README, link to HTML output only in this example
build_readme(PDF = FALSE)
# render: knit to HTML Document (interactively: click the Knit button)
rmarkdown::render(input = list.files(pattern = "*.Rmd"),
                  output_format = "bookdown::html_document2")
# Build GitHub Pages
build_githubpages()
# List the GitHub Pages files
setwd("docs")
list.files(recursive = TRUE)
## Commit and push. Outputs will be in /docs of the master branch.

## End of the example: cleanup
# Return to the original working directory and clean up
setwd(original_wd)
unlink(wd, recursive = TRUE)
} # }
```

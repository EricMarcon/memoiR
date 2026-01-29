# Build README

Build a `README.md` file that will be used as index of GitHub Pages.

## Usage

``` r
build_readme(PDF = TRUE)
```

## Arguments

- PDF:

  if `TRUE` (by default), a link to the PDF output is added.

## Value

The content of the `README.md` file as a vector of characters,
invisibly. Each element is a line of the file.

## Details

R Markdown files of the project are used to get the title and abstract
of the published documents. Run this function once in each project
created from a memoiR template, before
[`build_githubpages()`](https://EricMarcon.github.io/memoiR/dev/reference/build_githubpages.md).
A link to their HTML and, optionally, PDF versions is added. Metadata
fields are read in the .Rmd files YAML header: title, abstract and
`URL`.

## Examples

``` r
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
#> ✔ Setting active project to
#>   "/private/var/folders/yz/zr09txvs5dn18vt4cn21kzl40000gn/T/Rtmp5by3Aw/example2a1a4e8091de".

# Build README.md file
build_readme()
#> ✔ Writing README.md.
# Content
readLines("README.md")
#>  [1] "# Title of the Article"                                                  
#>  [2] ""                                                                        
#>  [3] "Abstract of the article."                                                
#>  [4] ""                                                                        
#>  [5] "Formats:"                                                                
#>  [6] ""                                                                        
#>  [7] "- [HTML](https://GitHubID.github.io/Repository/example2a1a4e8091de.html)"
#>  [8] "- [PDF](https://GitHubID.github.io/Repository/example2a1a4e8091de.pdf)"  
#>  [9] ""                                                                        
#> [10] ""                                                                        
#> [11] ""                                                                        

## End of the example: cleanup
# Return to the original working directory and clean up
setwd(original_wd)
unlink(wd, recursive = TRUE)
```

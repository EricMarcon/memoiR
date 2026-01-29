# Build .gitignore

Build a `.gitignore` file suitable for R Markdown projects.

## Usage

``` r
build_gitignore()
```

## Value

The content of the `.gitignore` file as a vector of characters,
invisibly. Each element is a line of the file.

## Details

The .gitignore file contains the list of files (file name patterns) that
must not be controlled by git. Run this function once in each project
created from a memoiR template, before activating version control.

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
#>   "/private/var/folders/yz/zr09txvs5dn18vt4cn21kzl40000gn/T/Rtmp5by3Aw/example2a1a131130e1".

# Build .gitignore file
build_gitignore()
#> ✔ Writing .gitignore.
# Content
readLines(".gitignore")
#>  [1] "# History files"                                 
#>  [2] ".Rhistory"                                       
#>  [3] ".Rapp.history"                                   
#>  [4] "# Session Data files"                            
#>  [5] ".RData"                                          
#>  [6] "# Package file"                                  
#>  [7] ".Rbuildignore"                                   
#>  [8] "# RStudio files"                                 
#>  [9] ".Rproj.user/"                                    
#> [10] ""                                                
#> [11] "# knitr and R markdown default cache directories"
#> [12] "/*_files/"                                       
#> [13] "/*_cache/"                                       
#> [14] "/libs/"                                          
#> [15] ""                                                
#> [16] "# Latex files"                                   
#> [17] "*.aux"                                           
#> [18] "*-blx.bib"                                       
#> [19] "*.log"                                           
#> [20] "*.xml"                                           
#> [21] "*.bbl"                                           
#> [22] "*.bcf"                                           
#> [23] "*.blg"                                           
#> [24] "*.synctex.gz"                                    
#> [25] "*.out"                                           
#> [26] "*.toc"                                           
#> [27] "*-concordance.tex"                               
#> [28] "*(busy)"                                         
#> [29] "*.nav"                                           
#> [30] "*.snm"                                           
#> [31] "*.vrb"                                           
#> [32] ""                                                
#> [33] "# Template specific"                             
#> [34] "packages.bib"                                    
#> [35] ""                                                
#> [36] "# Uncomment if CI builds docs/"                  
#> [37] "# docs/"                                         

## End of the example: cleanup
# Return to the original working directory and clean up
setwd(original_wd)
unlink(wd, recursive = TRUE)
```

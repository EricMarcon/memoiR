# Build GitHub Action Workflow

Build a YAML file (`.gihub/workflows/memoir.yml`) to knit the documents
of the project to GitHub Pages. The workflow knits all R Markdown files
according their header: all output formats are produced and stored into
the `gh-pages` branch of the project.

## Usage

``` r
build_ghworkflow()
```

## Value

The content of the YAML file as a vector of characters, invisibly. Each
element is a line of the file.

## Details

All HTML outputs have the same name so the last one knitted overwrites
the previous ones. Keep only one HTML format in the header of each
RMarkdown file.

No `DESCRIPTION` file is necessary in the project to install packages.
They must be declared in the options code chunk of each .Rmd file
(index.Rmd for the memoir template).

Two secrets must have been stored in the GitHub account:

- GH_PAT: a valid access token,

- EMAIL: the email address to send the workflow results to.

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
#>   "/private/var/folders/yz/zr09txvs5dn18vt4cn21kzl40000gn/T/Rtmp5by3Aw/example2a1a39af45e".

# Build GitHub Actions Workflow script
build_ghworkflow()
#> ✔ Writing .github/workflows/memoir.yml.
# Content
readLines(".github/workflows/memoir.yml")
#>  [1] "on:"                                                                                               
#>  [2] "  push:"                                                                                           
#>  [3] "   branches:"                                                                                      
#>  [4] "     - main"                                                                                       
#>  [5] "     - master"                                                                                     
#>  [6] ""                                                                                                  
#>  [7] "name: rmarkdown"                                                                                   
#>  [8] ""                                                                                                  
#>  [9] "jobs:"                                                                                             
#> [10] "  render:"                                                                                         
#> [11] "    runs-on: macOS-latest"                                                                         
#> [12] "    steps:"                                                                                        
#> [13] "      - name: Checkout repo"                                                                       
#> [14] "        uses: actions/checkout@v4"                                                                 
#> [15] "      - name: Setup R"                                                                             
#> [16] "        uses: r-lib/actions/setup-r@v2"                                                            
#> [17] "      - name: Install pandoc"                                                                      
#> [18] "        uses: r-lib/actions/setup-pandoc@v2"                                                       
#> [19] "      - name: Install dependencies"                                                                
#> [20] "        env:"                                                                                      
#> [21] "          GITHUB_PAT: ${{ secrets.GH_PAT }}"                                                       
#> [22] "        run: |"                                                                                    
#> [23] "          options(pkgType = \"binary\")"                                                           
#> [24] "          options(install.packages.check.source = \"no\")"                                         
#> [25] "          install.packages(c(\"distill\", \"downlit\", \"memoiR\", \"rmdformats\", \"tinytex\"))"  
#> [26] "          tinytex::install_tinytex(bundle = \"TinyTeX\")"                                          
#> [27] "          tinytex::tlmgr_install(\"hyphen-french\")"                                               
#> [28] "          tinytex::tlmgr_install(\"hyphen-italian\")"                                              
#> [29] "        shell: Rscript {0}"                                                                        
#> [30] "      - name: Render Rmarkdown files"                                                              
#> [31] "        env:"                                                                                      
#> [32] "          GITHUB_PAT: ${{ secrets.GH_PAT }}"                                                       
#> [33] "        run: |"                                                                                    
#> [34] "          Sys.setlocale(\"LC_TIME\", \"en_US\")"                                                   
#> [35] "          lapply(list.files(pattern = \"*.Rmd\"), function(file) rmarkdown::render(file, \"all\"))"
#> [36] "          memoiR::build_githubpages()"                                                             
#> [37] "        shell: Rscript {0}"                                                                        
#> [38] "      - name: Upload artifact"                                                                     
#> [39] "        uses: actions/upload-artifact@v4"                                                          
#> [40] "        with:"                                                                                     
#> [41] "          name: ghpages"                                                                           
#> [42] "          path: docs"                                                                              
#> [43] "  checkout-and-deploy:"                                                                            
#> [44] "    runs-on: ubuntu-latest"                                                                        
#> [45] "    needs: render"                                                                                 
#> [46] "    permissions:"                                                                                  
#> [47] "      contents: write"                                                                             
#> [48] "    steps:"                                                                                        
#> [49] "      - name: Download artifact"                                                                   
#> [50] "        uses: actions/download-artifact@v4"                                                        
#> [51] "        with:"                                                                                     
#> [52] "          name: ghpages"                                                                           
#> [53] "          path: docs"                                                                              
#> [54] "      - name: Deploy to GitHub Pages"                                                              
#> [55] "        uses: Cecilapp/GitHub-Pages-deploy@v3"                                                     
#> [56] "        env:"                                                                                      
#> [57] "          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}"                                               
#> [58] "        with:"                                                                                     
#> [59] "          email: ${{ secrets.EMAIL }}"                                                             
#> [60] "          build_dir: docs"                                                                         
#> [61] "          jekyll: yes"                                                                             

## End of the example: cleanup
# Return to the original working directory and clean up
setwd(original_wd)
unlink(wd, recursive = TRUE)
```

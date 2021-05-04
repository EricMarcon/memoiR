#' memoiR
#'
#' R Markdown and Bookdown templates to publish documents,
#' especially relying on the memoir LaTeX package
#'
#' @name memoiR
#' @docType package
NULL


#' Knit
#'
#' Create documents from templates
#'
#' These functions are used to test the templates and produce a gallery.
#' - `knit_template()` produces an HTML and a PDF output of the chosen template.
#' - `knit_all()` runs knit_template() on all templates of the package.
#' The `output_format` argument selects the way templates are rendered:
#' - articles may be rendered in HTML by [bookdown::html_document2], [bookdown::gitbook], [rmdformats::downcute] (and others, see the package **rmdformats**) and in PDF by [bookdown::pdf_book].
#' - books may be rendered in HTML by [bookdown::gitbook] and in PDF by [bookdown::pdf_book].
#' - slides may be rendered in  HTML by [bookdown::ioslides_presentation2], [bookdown::ioslides_presentation2] and in PDF by [bookdown::beamer_presentation2].
#'
#' @param template name of the template to knit, e.g. "simple_article".
#' @param output_format A character vector of the output formats to convert to. Each value must be the name of a function producing an output format object, such as "bookdown::pdf_book".  
#' @param destination name of the folder containing GitHub pages or equivalent.
#' @param gallery name of the subfolder of `destination` to store the knitted documents.
#'
#' @name Knit
NULL

#' @rdname Knit
#' @export
knit_all <- function(destination=usethis::proj_path("docs"), gallery="gallery") {
  knit_template("simple_article", 
                output_format=c("bookdown::pdf_book", 
                                "rmdformats::downcute", 
                                "bookdown::html_document2"), 
                destination=destination, gallery=gallery)
  knit_template("stylish_article", 
                output_format=c("bookdown::pdf_book"), 
                destination=destination, gallery=gallery)
  knit_template("memoir", 
                output_format=c("bookdown::pdf_book", 
                                "bookdown::gitbook"), 
                destination=destination, gallery=gallery)
  knit_template("beamer_presentation", 
                output_format=c("bookdown::beamer_presentation2", 
                                "bookdown::ioslides_presentation2", 
                                "bookdown::slidy_presentation2"), 
                destination=destination, gallery=gallery)
}

#' @rdname Knit
#' @export
knit_template <- function(template, output_format, destination=usethis::proj_path("docs"), gallery="gallery") {
  # Save knitr.table.format option (for kable)
  knitr_table_format <- options("knitr.table.format")
  # Save working directory
  OriginalWD <- getwd()
  # Evaluate destination before changing working directory (or lazy evaluation will fail)
  destination <- destination
  # Go to temp directory
  tmpdir <- tempdir()
  setwd(tmpdir)
  # Clean up the working folder
  unlink(template, recursive=TRUE)
  # Create a draft based on the template
  rmarkdown::draft(template, template=template, package="memoiR", edit=FALSE)
  setwd(template)
  if (template == "memoir") {
    # Delete the useless file created by draft
    unlink(paste(template, ".Rmd", sep=""))
  }
  
  # Knit
  for (format in output_format) {
    if (format %in% c("bookdown::gitbook", 
                      "bookdown::html_document2", 
                      "rmdformats::downcute", 
                      "bookdown::ioslides_presentation2", 
                      "bookdown::slidy_presentation2")) {
      # Knit to HTML
      options(knitr.table.format="html")
      if (template == "memoir") {
        # Book
        bookdown::render_book(input="index.Rmd",
                              output_format=format,
                              output_dir=paste(gallery, "/", 
                                               template, "/", 
                                               gsub("::", "_", format),
                                               sep=""))
      } else {
        # Article or presentation
        rmarkdown::render(input=paste(template, ".Rmd", sep=""),
                          output_format=format,
                          output_dir=paste(gallery, "/", 
                                           template, "/", 
                                           gsub("::", "_", format),
                                           sep=""))
      }
    }
    if (format %in% c("bookdown::pdf_book", 
                      "bookdown::beamer_presentation2",
                      "bookdown::beamer_presentation2")) {
      # Knit to PDF
      options(knitr.table.format="latex")
      if (template == "memoir") {
        # Book
        bookdown::render_book(input="index.Rmd",
                              output_format=format,
                              output_dir=paste(gallery, "/", 
                                               template, "/", 
                                               gsub("::", "_", format),
                                               sep=""))
      } else {
        # Article or presentation
        rmarkdown::render(input=paste(template, ".Rmd", sep=""),
                          output_format=format,
                          output_dir=paste(gallery, "/", 
                                           template, "/", 
                                           gsub("::", "_", format),
                                           sep=""))
      }
    }
  }

  # Copy to destination
  docsDirs <- list.dirs(path=gallery, full.names=TRUE, recursive=TRUE)
  if (length(docsDirs) > 0) {
    docsFiles <- list.files(gallery, full.names=TRUE, recursive=TRUE)
    # Create destination under the working directory
    vapply(paste(destination, "/", docsDirs, sep=""),
           dir.create,
           showWarnings=FALSE,
           recursive=TRUE,
           FUN.VALUE = TRUE)
    file.copy(from=docsFiles,
              to=paste(destination,  "/", docsFiles, sep=""),
              overwrite=TRUE)
  }
  # Clean up
  setwd(OriginalWD)
  unlink(paste(tmpdir, "/", template, sep=""), recursive=TRUE)
  options(knitr.table.format=knitr_table_format)
}


#' Build GitHub Pages
#'
#' Copy the files produced by knitting to the destination folder.
#'
#' Produced files are HTML pages and their companions (css, figures, libraries) and PDF documents.
#' The function moves them all and the `README.md` file into the destination folder.
#' GitHub Pages allow making a website to present them:
#' - `README.md` is the home page. Make it with [build_index()] to have links to the HTML and PDF outputs.
#' - knit both HTML and PDF versions to avoid dead links.
#' - run `build_githubpages()` when a document is knitted to move the outputs into the `docs` folder.
#' - push to GitHub and activate GitHub Pages on the main branch and the `docs` folder.
#' The function is useless in book projects: the _Build the Book_ (i.e. the [bookdown::render_book()] function) takes care of every step.
#'
#' @param destination destination folder of the knitted documents.
#'
#' @export
#' 
#' @examples
#' # Save working directory
#' original_wd <- getwd()
#' # Get a temporary working directory
#' wd <- tempfile("example")
#' # Simulate File > New File > R Markdown... > From Template > Stylish Article
#' rmarkdown::draft(wd, template="stylish_article", package="memoiR", edit=FALSE)
#' # Go to temp directory
#' setwd(wd)
#' # Make it the current project
#' usethis::proj_set(path = ".", force = TRUE)
#' # render: knit to downcute
#' rmarkdown::render(input=list.files(pattern="*.Rmd"), 
#'                   output_format="rmdformats::downcute")
#' # Build index, HTML only
#' build_index(PDF=FALSE)
#' # Build GitHub Pages
#' build_githubpages(destination="docs")
#' # List the GitHub Pages files
#' setwd("docs")
#' list.files(recursive=TRUE)
#' # Return to the original working directory and clean up
#' setwd(original_wd)
#' unlink(wd, recursive=TRUE)
build_githubpages <- function(destination=usethis::proj_path("docs")) {

  # Quit if the project is a book
  if (file.exists(usethis::proj_path("_bookdown.yml")))
    stop("Book projects do not need build_githubpages()")

  # Save the working directory
  OriginalWD <- getwd()
  # Make the project directory the working directory
  setwd(usethis::proj_path())

  # Create the destination folder
  if (!dir.exists(destination)) dir.create(destination)
  # Move knitted html files
  htmlFiles <- list.files(pattern="*.html")
  if (length(htmlFiles) > 0)
    file.rename(from=htmlFiles, to=paste(destination, "/", htmlFiles, sep=""))
  # Copy css files
  cssFiles <- list.files(pattern="*.css")
  if (length(cssFiles) > 0)
    file.copy(from=cssFiles, to=paste(destination, "/", cssFiles, sep=""), overwrite=TRUE)
  # Copy generated figures
  html_filesDir <- list.files(pattern="*_files")
  if (length(html_filesDir) > 0) {
    sapply(paste(destination, "/", html_filesDir, sep=""), dir.create, showWarnings=FALSE)
    sapply(paste(destination, "/", html_filesDir, "/figure-html", sep=""), dir.create, showWarnings=FALSE)
    html_files <- list.files(path=paste(html_filesDir, "/figure-html/", sep=""), full.names = TRUE, recursive=TRUE)
    if (length(html_files) > 0)
      file.copy(from=html_files, to=paste(destination, "/", html_files, sep = ""), overwrite=TRUE)
  }
  # Copy libs
  libsDirs <- list.dirs(path="libs", full.names=TRUE, recursive=TRUE)
  if (length(libsDirs) > 0) {
    sapply(paste(destination, "/", libsDirs, sep = ""), dir.create, showWarnings=FALSE)
    libsFiles <- list.files("libs", full.names = TRUE, recursive=TRUE)
    file.copy(from=libsFiles, to=paste(destination, "/", libsFiles, sep = ""), overwrite=TRUE)
  }
  # Copy static image files. MUST be in /images, may be in subfolders.
  imagesDirs <- list.dirs(path="images", full.names=TRUE, recursive=TRUE)
  if (length(imagesDirs) > 0) {
    sapply(paste(destination, "/", imagesDirs, sep = ""), dir.create, showWarnings=FALSE)
    imagesFiles <- list.files("images", full.names = TRUE, recursive=TRUE)
    file.copy(from=imagesFiles, to=paste(destination, "/", imagesFiles, sep = ""), overwrite=TRUE)
  }
  # Move knitted pdf files
  RmdFiles <- list.files(pattern="*.Rmd")
  # Change .Rmd files extension
  pdfFiles <- gsub(".Rmd", ".pdf", RmdFiles)
  if (length(pdfFiles) > 0)
    suppressWarnings(file.rename(from=pdfFiles, to=paste(destination, "/", pdfFiles, sep="")))
  # Move knitted PPTx files
  PPTxFiles <- gsub(".Rmd", ".pptx", RmdFiles)
  if (length(PPTxFiles) > 0)
    suppressWarnings(file.rename(from=PPTxFiles, to=paste(destination, "/", PPTxFiles, sep="")))
  # Move knitted docx files
  docxFiles <- gsub(".Rmd", ".docx", RmdFiles)
  if (length(docxFiles) > 0)
    suppressWarnings(file.rename(from=docxFiles, to=paste(destination, "/", docxFiles, sep="")))
  # Copy README.md to docs
  file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)

  cat("Output files moved to", destination)
  # Restore the working directory
  setwd(OriginalWD)
}


#' Build Index
#'
#' Build a README.md file that will be used as index of GitHub Pages.
#'
#' R Markdown files of the project are used to get the title and abstract of the published documents.
#' Run this function once in each project created from a memoiR template, before [build_githubpages()].
#' A link to their HTML and, optionally, PDF versions is added.
#' Metadata fields are read in the .Rmd files YAML header: title, abstract and `URL`.
#' The function is useless in book projects: the _Build the Book_ (i.e. the [bookdown::render_book()] function) takes care of every step.
#'
#' @param PDF if `TRUE` (by default), a link to the PDF output is added.
#' 
#' @export
build_index <- function(PDF = TRUE) {
  # Quit if the project is a book
  if (file.exists(usethis::proj_path("_bookdown.yml")))
    stop("Book projects do not need build_index()")
  # Save the working directory
  OriginalWD <- getwd()
  # Make the project directory the working directory
  setwd(usethis::proj_path())
  # Find the markdown files
  RmdFiles <- list.files(pattern="*.Rmd")
  lines <- character()
  for (RmdFile in RmdFiles) {
    yaml_header <- rmarkdown::yaml_front_matter(RmdFile)
    # Eliminate the extension
    RmdFileName <- gsub(".Rmd", "", RmdFile)
    if (PDF) {
      lines <- c(lines,
                 paste("# ", yaml_header$title, "\n", sep=""),
                 yaml_header$abstract,
                 "Formats:\n",
                 paste("- [HTML](", yaml_header$url, RmdFileName, ".html)", sep=""),
                 paste("- [PDF](", yaml_header$url, RmdFileName, ".pdf)\n", sep=""),
                 "\n")
    } else{
      lines <- c(paste("# [", 
                       yaml_header$title, "](", 
                       yaml_header$url, RmdFileName, "html)\n", 
                       sep=""),
                 yaml_header$abstract)
    }
  }
  usethis::write_over(usethis::proj_path("README.md"), lines)
  # Restore the working directory
  setwd(OriginalWD)
}


#' Build .gitignore
#'
#' Build a .gitignore file suitable for R Markdown projects. 
#'
#' The .gitignore file contains the list of files (file name patterns) that must not be controlled by git.
#' Run this function once in each project created from a memoiR template, before activating version control.
#'
#' @export
build_gitignore <- function() {
  lines <- c("# History files",
             ".Rhistory",
             ".Rapp.history",
             "# Session Data files",
             ".RData",
             "# Package file",
             ".Rbuildignore",
             "# RStudio files",
             ".Rproj.user/",
             "",
             "# knitr and R markdown default cache directories",
             "/*_files/",
             "/*_cache/",
             "/libs/",
             "",
             "# Latex files",
             "*.aux",
             "*-blx.bib",
             "*.log",
             "*.xml",
             "*.bbl",
             "*.bcf",
             "*.blg",
             "*.synctex.gz",
             "*.out",
             "*.toc",
             "*-concordance.tex",
             "*(busy)",
             "*.nav",
             "*.snm",
             "*.vrb",
             "",
             "# Template specific",
             "packages.bib",
             "",
             "# Uncomment if CI builds docs/",
             "# docs/")
  
  usethis::write_over(usethis::proj_path(".gitignore"), lines)
}

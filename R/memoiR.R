#' Package memoiR
#'
#' R Bookdown templates to publish documents,
#' especially relying on the memoir LaTeX package
#'
#' @name memoiR
#' @docType package
NULL


#' RStudio Project
#' 
#' This function is run by the RStudio project wizard to create a new document project.
#'
#' @param path the path to the newly created project
#' @param ... extra arguments passed by the New Project Wizard
#'
#' @return Used for side effects.
#' @keywords internal
draft_memoir <- function(path, ...) {
  # Read dots. Arguments come from inst/rstudio/templates/project/memoir.dcf
  dots <- list(...)
  template <- dots[[1]]
  # Create a draft based on the template
  templates <- c("simple_article", "stylish_article", "memoir", "beamer_presentation")
  names(templates) <- c("Simple Article", "Stylish Article", "Memoir", "Beamer Presentation")
  rmarkdown::draft(path, template=templates[template], package="memoiR", edit=FALSE)
}


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
#' These functions are mainly used for test and documentation purposes.
#' In projects based on the templates, use the _Knit_ button (articles, presentations) or the _Build the Book_ button (memoirs) or [bookdown::render_book()].
#' 
#' @param template name of the template to knit, e.g. "simple_article".
#' @param output_format A character vector of the output formats to convert to. Each value must be the name of a function producing an output format object, such as "bookdown::pdf_book".  
#' @param destination name of the folder containing GitHub pages or equivalent.
#' @param gallery name of the subfolder of `destination` to store the knitted documents.
#'
#' @return `TRUE` if all documents have been knitted and copied to the gallery, invisibly.
#' 
#' @name Knit
NULL

#' @rdname Knit
#' @export
knit_all <- function(destination=usethis::proj_path("docs"), gallery="gallery") {
  done <- knit_template("simple_article",
                        output_format=c("bookdown::pdf_book", 
                                        "rmdformats::downcute", 
                                        "bookdown::html_document2"), 
                        destination=destination, gallery=gallery)
  if (done)
    done <- knit_template("stylish_article", 
                          output_format=c("bookdown::pdf_book"), 
                          destination=destination, gallery=gallery)
  if (done)
    done <- knit_template("memoir", 
                          output_format=c("bookdown::pdf_book", 
                                          "bookdown::gitbook"), 
                          destination=destination, gallery=gallery)
  if (done)
    done <- knit_template("beamer_presentation", 
                          output_format=c("bookdown::beamer_presentation2", 
                                          "bookdown::ioslides_presentation2", 
                                          "bookdown::slidy_presentation2"), 
                          destination=destination, gallery=gallery)
  return(invisible(done))
}

#' @rdname Knit
#' @export
knit_template <- function(template, output_format, destination=usethis::proj_path("docs"), gallery="gallery") {
  done <- FALSE
  # Save knitr.table.format option (for kable)
  knitr_table_format <- options("knitr.table.format")
  # Save working directory
  OriginalWD <- getwd()
  # Evaluate destination before changing working directory (or lazy evaluation will fail)
  destination <- destination
  # Get temp directory
  tmpdir <- tempdir()
  # Prepare clean up
  on.exit({
    setwd(OriginalWD)
    unlink(paste(tmpdir, "/", template, sep=""), recursive=TRUE)
    options(knitr.table.format=knitr_table_format)
  })
  
  # Go to temp directory
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
  tryCatch({
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
    done <- TRUE
  },
  error = function(e) e
  )
  
  return(done)
}


#' Build GitHub Pages
#'
#' Copy the files produced by knitting to the destination folder.
#'
#' Produced files are HTML pages and their companions (css, figures, libraries) and PDF documents.
#' The function moves them all and the `README.md` file into the destination folder.
#' GitHub Pages allow making a website to present them:
#' - `README.md` is the home page. Make it with [build_readme()] to have links to the HTML and PDF outputs.
#' - knit both HTML and PDF versions to avoid dead links.
#' - run `build_githubpages()` when a document is knitted to move the outputs into the `docs` folder.
#' - push to GitHub and activate GitHub Pages on the main branch and the `docs` folder.
#' The function is useless in book projects: the _Build the Book_ (i.e. the [bookdown::render_book()] function) takes care of every step.
#'
#' @param destination destination folder of the knitted documents.
#'
#' @return A vector with the names of the files and directory that were copied if they existed (some may not be knitted), invisibly.
#'
#' @export
#' @examples
#' \dontrun{
#' ## Simulate the creation of a new project
#' # Save working directory
#' original_wd <- getwd()
#' # Get a temporary working directory
#' wd <- tempfile("example")
#' # Simulate File > New File > R Markdown... > From Template > Simple Article
#' rmarkdown::draft(wd, template="simple_article", package="memoiR", edit=FALSE)
#' # Go to temp directory
#' setwd(wd)
#' # Make it the current project
#' usethis::proj_set(path = ".", force = TRUE)
#' 
#' ## Sequence of actions to build a complete project
#' # Build .gitignore
#' build_gitignore()
#' ## Activate source control, edit your files, commit
#' # Build README, link to HTML output only in this example
#' build_readme(PDF=FALSE)
#' # render: knit to HTML Document (interactively: click the Knit button)
#' rmarkdown::render(input=list.files(pattern="*.Rmd"), 
#'                   output_format="bookdown::html_document2")
#' # Build GitHub Pages
#' build_githubpages()
#' # List the GitHub Pages files
#' setwd("docs")
#' list.files(recursive=TRUE)
#' ## Commit and push. Outputs will be in /docs of the master branch.
#' 
#' ## End of the example: cleanup
#' # Return to the original working directory and clean up
#' setwd(original_wd)
#' unlink(wd, recursive=TRUE)
#' }
build_githubpages <- function(destination=usethis::proj_path("docs")) {

  # Quit if the project is a book
  if (file.exists(usethis::proj_path("_bookdown.yml")))
    stop("Book projects do not need build_githubpages()")

  processed <- ""
  # Save the working directory
  OriginalWD <- getwd()
  # Prepare clean up
  on.exit(setwd(OriginalWD))
  # Make the project directory the working directory
  setwd(usethis::proj_path())

  # Create the destination folder
  if (!dir.exists(destination)) dir.create(destination)
  # Move knitted html files
  htmlFiles <- list.files(pattern="*.html")
  if (length(htmlFiles) > 0) {
    processed <- c(processed, htmlFiles)
    file.rename(from=htmlFiles, to=paste(destination, "/", htmlFiles, sep=""))
  }
  # Copy css files
  cssFiles <- list.files(pattern="*.css")
  if (length(cssFiles) > 0) {
    processed <- c(processed, cssFiles)
    file.copy(from=cssFiles, to=paste(destination, "/", cssFiles, sep=""), overwrite=TRUE)
  }
  # Copy generated figures
  html_filesDir <- list.files(pattern="*_files")
  if (length(html_filesDir) > 0) {
    processed <- c(processed, html_filesDir)
    sapply(paste(destination, "/", html_filesDir, sep=""), dir.create, showWarnings=FALSE)
    sapply(paste(destination, "/", html_filesDir, "/figure-html", sep=""), dir.create, showWarnings=FALSE)
    html_files <- list.files(path=paste(html_filesDir, "/figure-html/", sep=""), full.names = TRUE, recursive=TRUE)
    if (length(html_files) > 0)
      file.copy(from=html_files, to=paste(destination, "/", html_files, sep = ""), overwrite=TRUE)
  }
  # Copy libs
  libsDirs <- list.dirs(path="libs", full.names=TRUE, recursive=TRUE)
  if (length(libsDirs) > 0) {
    processed <- c(processed, libsDirs)
    sapply(paste(destination, "/", libsDirs, sep = ""), dir.create, showWarnings=FALSE)
    libsFiles <- list.files("libs", full.names = TRUE, recursive=TRUE)
    file.copy(from=libsFiles, to=paste(destination, "/", libsFiles, sep = ""), overwrite=TRUE)
  }
  # Copy static image files. MUST be in /images, may be in subfolders.
  imagesDirs <- list.dirs(path="images", full.names=TRUE, recursive=TRUE)
  if (length(imagesDirs) > 0) {
    processed <- c(processed, imagesDirs)
    sapply(paste(destination, "/", imagesDirs, sep = ""), dir.create, showWarnings=FALSE)
    imagesFiles <- list.files("images", full.names = TRUE, recursive=TRUE)
    file.copy(from=imagesFiles, to=paste(destination, "/", imagesFiles, sep = ""), overwrite=TRUE)
  }
  # Move knitted pdf files
  RmdFiles <- list.files(pattern="*.Rmd")
  # Change .Rmd files extension
  pdfFiles <- gsub(".Rmd", ".pdf", RmdFiles)
  if (length(pdfFiles) > 0) {
    processed <- c(processed, pdfFiles)
    suppressWarnings(file.rename(from=pdfFiles, to=paste(destination, "/", pdfFiles, sep="")))
  }
  # Move knitted PPTx files
  PPTxFiles <- gsub(".Rmd", ".pptx", RmdFiles)
  if (length(PPTxFiles) > 0) {
    processed <- c(processed, PPTxFiles)
    suppressWarnings(file.rename(from=PPTxFiles, to=paste(destination, "/", PPTxFiles, sep="")))
  }
  # Move knitted docx files
  docxFiles <- gsub(".Rmd", ".docx", RmdFiles)
  if (length(docxFiles) > 0) {
    processed <- c(processed, PPTxFiles)
    suppressWarnings(file.rename(from=docxFiles, to=paste(destination, "/", docxFiles, sep="")))
  }
  # Copy README.md to docs
  file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)
  processed <- c(processed, "README.md")
  
  cat("Output files moved to", destination)
  return(invisible(processed))
}


#' Build README
#'
#' Build a `README.md` file that will be used as index of GitHub Pages.
#'
#' R Markdown files of the project are used to get the title and abstract of the published documents.
#' Run this function once in each project created from a memoiR template, before [build_githubpages()].
#' A link to their HTML and, optionally, PDF versions is added.
#' Metadata fields are read in the .Rmd files YAML header: title, abstract and `URL`.
#'
#' @param PDF if `TRUE` (by default), a link to the PDF output is added.
#' 
#' @return The content of the `README.md` file as a vector of characters, invisibly. Each element is a line of the file.
#' 
#' @export
#' @examples
#' ## Simulate the creation of a new project
#' # Save working directory
#' original_wd <- getwd()
#' # Get a temporary working directory
#' wd <- tempfile("example")
#' # Simulate File > New File > R Markdown... > From Template > Simple Article
#' rmarkdown::draft(wd, template="simple_article", package="memoiR", edit=FALSE)
#' # Go to temp directory
#' setwd(wd)
#' # Make it the current project
#' usethis::proj_set(path = ".", force = TRUE)
#' 
#' # Build README.md file
#' build_readme()
#' # Content
#' readLines("README.md")
#' 
#' ## End of the example: cleanup
#' # Return to the original working directory and clean up
#' setwd(original_wd)
#' unlink(wd, recursive=TRUE)
#' 
build_readme <- function(PDF = TRUE) {
  # Is this a book project?
  is_memoir <- file.exists(usethis::proj_path("_bookdown.yml"))
  # Save the working directory
  OriginalWD <- getwd()
  # Prepare clean up
  on.exit(setwd(OriginalWD))
  # Make the project directory the working directory
  setwd(usethis::proj_path())
  # Find the markdown files
  RmdFiles <- list.files(pattern="*.Rmd")
  lines <- character()
  if (is_memoir) {
    yaml_header <- rmarkdown::yaml_front_matter(usethis::proj_path("index.Rmd"))
    if (length(yaml_header$backcover))
      abstract <- yaml_header$backcover[[1]]$abstract
    else
      abstract <- ""
    lines <- c(paste("# [",
                     yaml_header$title, "](",
                     yaml_header$url, "/index.html)\n",
                     sep=""),
               yaml_header$description,
               "\n",
               abstract)
  } else {
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
  }
  usethis::write_over(usethis::proj_path("README.md"), lines)
  return(invisible(lines))
}


#' Build .gitignore
#'
#' Build a `.gitignore` file suitable for R Markdown projects. 
#'
#' The .gitignore file contains the list of files (file name patterns) that must not be controlled by git.
#' Run this function once in each project created from a memoiR template, before activating version control.
#'
#' @return The content of the `.gitignore` file as a vector of characters, invisibly. Each element is a line of the file.
#' 
#' @export
#' @examples
#' ## Simulate the creation of a new project
#' # Save working directory
#' original_wd <- getwd()
#' # Get a temporary working directory
#' wd <- tempfile("example")
#' # Simulate File > New File > R Markdown... > From Template > Simple Article
#' rmarkdown::draft(wd, template="simple_article", package="memoiR", edit=FALSE)
#' # Go to temp directory
#' setwd(wd)
#' # Make it the current project
#' usethis::proj_set(path = ".", force = TRUE)
#' 
#' # Build .gitignore file
#' build_gitignore()
#' # Content
#' readLines(".gitignore")
#' 
#' ## End of the example: cleanup
#' # Return to the original working directory and clean up
#' setwd(original_wd)
#' unlink(wd, recursive=TRUE)
#' 
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
  return(invisible(lines))
}


#' Add hyphenation patterns
#' 
#' This function is called by [build_ghworkflow()] to install hyphenation patterns.
#'
#' @param lang a language code, such as "fr-FR"
#'
#' @return A line of the GitHub Actions script to install the hyphenation package. 
#' `NULL` if `lang` is not recognized.
#' @keywords internal
add_hyphen <- function(lang) {
  lang_2 <- substr(lang, start=1, stop=2)
  hyphen_package <- switch(lang_2,
                           de = "hyphen-german",
                           fr = "hyphen-french",
                           it = "hyphen-italian",
                           pt = "hyphen-portuguese",
                           sp = "hyphen-spanish")
  if (is.null(hyphen_package)) {
    return(NULL)
  } else {
    return(paste('          tinytex::tlmgr_install("', hyphen_package, '")', sep=""))
  }
}


#' Add fonts
#' 
#' This function is called by [build_ghworkflow()] to install fonts.
#'
#' @param font a font file name
#'
#' @return A line of the GitHub Actions script to install the font package. 
#' `NULL` if `font` is not recognized.
#' @keywords internal
add_font <- function(font) {
  # Reference: https://r2src.github.io/top10fonts/
  # DejaVu
  if (substr(font, start=1, stop=6) == "dejavu") {
    font_package <- "dejavu-otf"
  }
  # Garamond Libre
  if (substr(font, start=1, stop=13) == "GaramondLibre") {
    font_package <- "garamond-libre"
  }
  # Garamond Math
  if (substr(font, start=1, stop=13) == "Garamond-Math") {
    font_package <- "garamond-math"
  }
  # KP-fonts
  if (substr(font, start=1, stop=2) == "Kp") {
    font_package <- "kpfonts-otf"
  }
  # Libertine
  if (substr(font, start=1, stop=11) == "LinBiolinum" |
      substr(font, start=1, stop=12) == "LinLibertine") {
    font_package <- "libertine"
  }
  # TeX Gyre
  if (substr(font, start=1, stop=7) == "texgyre") {
    font_package <- "tex-gyre"
    # TeX Gyre math
    if (substr(font, nchar(font)-4, nchar(font)) == "-math")
      font_package <- "tex-gyre-math"
  }
  
  # Build the line
  if (is.null(font_package)) {
    return(NULL)
  } else {
    return(paste('          tinytex::tlmgr_install("', font_package, '")', sep=""))
  }
}

#' Build GitHub Action Workflow
#'
#' Build a YAML file (`.gihub/workflows/memoir.yml`) to knit the documents 
#' of the project to GitHub Pages. 
#
#' The workflow knits all R Markdown files according their header: all output 
#' formats are produced and stored into the `gh-pages` branch of the project.
#' 
#' All HTML outputs have the same name so the last one knitted overwrites the
#' previous ones.
#' Keep only one HTML format in the header of each RMarkdown file.
#' 
#' No `DESCRIPTION` file is necessary in the project to install packages.
#' They must be declared in the options code chunk of each .Rmd file
#' (index.Rmd for the memoir template).
#' 
#' Two secrets must have been stored in the GitHub account:
#' - GH_PAT: a valid access token,
#' - EMAIL: the email address to send the workflow results to.
#'
#' @return The content of the YAML file as a vector of characters, invisibly. Each element is a line of the file.
#' 
#' @export
#' @examples
#' ## Simulate the creation of a new project
#' # Save working directory
#' original_wd <- getwd()
#' # Get a temporary working directory
#' wd <- tempfile("example")
#' # Simulate File > New File > R Markdown... > From Template > Simple Article
#' rmarkdown::draft(wd, template="simple_article", package="memoiR", edit=FALSE)
#' # Go to temp directory
#' setwd(wd)
#' # Make it the current project
#' usethis::proj_set(path = ".", force = TRUE)
#' 
#' # Build GitHub Actions Workflow script
#' build_ghworkflow()
#' # Content
#' readLines(".github/workflows/memoir.yml")
#' 
#' ## End of the example: cleanup
#' # Return to the original working directory and clean up
#' setwd(original_wd)
#' unlink(wd, recursive=TRUE)
#' 
build_ghworkflow <- function() {
  
  # Save the working directory
  OriginalWD <- getwd()
  # Prepare clean up
  on.exit(setwd(OriginalWD))
  # Make the project directory the working directory
  setwd(usethis::proj_path())
  
  # Is this a book project?
  is_memoir <- file.exists("_bookdown.yml")
  # Find the header
  if (is_memoir) {
    yaml_header <- rmarkdown::yaml_front_matter("index.Rmd")
  } else {
    Rmd_files <- list.files(pattern="*.Rmd")
    yaml_header <- rmarkdown::yaml_front_matter(Rmd_files[1])
  }
  
  # Workflow
  lines <- c(
    'on:',
    '  push:',
    '   branches:',
    '     - master',
    '',
    'name: rmarkdown',
    '',
    'jobs:',
    '  render:',
    '    runs-on: macOS-latest',
    '    steps:',
    '      - name: Checkout repo',
    '        uses: actions/checkout@v2',
    '      - name: Setup R',
    '        uses: r-lib/actions/setup-r@v1',
    '      - name: Install pandoc',
    '        uses: r-lib/actions/setup-pandoc@v1',
    '      - name: Install dependencies',
    '        run: |',
    '          options(pkgType = "binary")',
    '          options(install.packages.check.source = "no")',
    '          install.packages(c("memoiR", "rmdformats", "tinytex"))',
    '          tinytex::install_tinytex()')
  
  # Read languages in header
  langs <- c(yaml_header$lang, yaml_header$otherlangs)
  # Add hyphenation packages
  for (lang in langs) {
    lines <- c(lines, add_hyphen(lang))
  }
  
  # Read fonts in header
  font_packages <- lapply(
    c(yaml_header$mainfont, yaml_header$monofont, yaml_header$mathfont),
    add_font)
  if (length(font_packages) > 0) {
    # Eliminate duplicates
    font_packages <- unique(simplify2array(font_packages))
    lines <- c(lines, font_packages)
  } 
  
  lines <- c(lines,
    '        shell: Rscript {0}'
  )
  
  # render a book or a simple document
  if (is_memoir) {
    lines <- c(lines,
    '      - name: Render pdf book',
    '        run: |',
    '          bookdown::render_book("index.Rmd", "bookdown::pdf_book")',
    '        shell: Rscript {0}',
    '      - name: Render gitbook',
    '        run: |',
    '          bookdown::render_book("index.Rmd", "bookdown::gitbook")',
    '        shell: Rscript {0}'
    )
  } else {
    lines <- c(lines,
    '      - name: Render Rmarkdown files',
    '        run: |',
    '          RMD_PATH=($(ls | grep "[.]Rmd$"))',
    '          Rscript -e \'for (file in commandArgs(TRUE)) rmarkdown::render(file, "all")\' ${RMD_PATH[*]}',
    '          Rscript -e \'memoiR::build_githubpages()\''
    )
  }
  
  # Publish
  lines <- c(lines,
    '      - name: Upload artifact',
    '        uses: actions/upload-artifact@v1',
    '        with:',
    '          name: ghpages',
    '          path: docs',
    '  checkout-and-deploy:',
    '    runs-on: ubuntu-latest',
    '    needs: render',
    '    steps:',
    '      - name: Checkout',
    '        uses: actions/checkout@v2',
    '      - name: Download artifact',
    '        uses: actions/download-artifact@v1',
    '        with:',
    '          name: ghpages',
    '          path: docs',
    '      - name: Deploy to GitHub Pages',
    '        uses: Cecilapp/GitHub-Pages-deploy@v3',
    '        env:',
    '          GITHUB_TOKEN: ${{ secrets.GH_PAT }}',
    '        with:',
    '          email: ${{ secrets.EMAIL }}',
    '          build_dir: docs')
  
  # Jekyll site for simple documents
  if (is_memoir) {
    lines <- c(lines,
    '          jekyll: no'
    )
  } else {
    lines <- c(lines,
    '          jekyll: yes'
    )
  }
  
  # Create the workflow file
  dir.create(".github/workflows", showWarnings=FALSE, recursive=TRUE)
  usethis::write_over(".github/workflows/memoir.yml", lines)
  return(invisible(lines))
}

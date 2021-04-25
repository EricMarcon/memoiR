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
#' Used to test the templates
#'
#' @param template name of the template to knit.
#' @param type type of the template to knit. May be "document", "book" or "slides".
#' @param destination name of the folder containing GitHub pages or equivalent.
#' @param gallery name of the subfolder of destination to store the knitted documents.
#'
#' @name Knit
NULL

#' @rdname Knit
#' @export
knit_all <- function(destination=usethis::proj_path("docs"), gallery="gallery") {
  knit_template("simple_article", type="document", destination=destination, gallery=gallery)
  knit_template("stylish_article", type="document", destination=destination, gallery=gallery)
  knit_template("memoir", type="book", destination=destination, gallery=gallery)
  knit_template("beamer_presentation", type="slides", destination=destination, gallery=gallery)
}

#' @rdname Knit
#' @export
knit_template <- function(template, type, destination=usethis::proj_path("docs"), gallery="gallery") {
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
  if (type == "book") {
    # Delete the useless file created by draft
    unlink(paste(template, ".Rmd", sep=""))
  }
  # Knit to HTML
  options(knitr.table.format='html')
  if (type == "document") {
    rmarkdown::render(input=paste(template, ".Rmd", sep=""),
                      output_format="rmdformats::downcute",
                      output_dir=paste(gallery , "/", template, sep=""))
  }
  if (type == "book"){
    bookdown::render_book(input="index.Rmd",
                          output_format="bookdown::gitbook",
                          output_dir=paste(gallery , "/", template, sep=""))
  }
  if (type == "slides") {
    rmarkdown::render(input="beamer_presentation.Rmd",
                      output_format="rmarkdown::ioslides_presentation",
                      output_dir=paste(gallery , "/", template, sep=""))
  }
  # Knit to pdf
  options(knitr.table.format='latex')
  if (type == "document") {
    rmarkdown::render(input=paste(template, ".Rmd", sep=""),
                      output_format="bookdown::pdf_book",
                      output_dir=paste(gallery , "/", template, sep=""))
  }
  if (type == "book"){
    bookdown::render_book(input="index.Rmd",
                          output_format="bookdown::pdf_book",
                          output_dir=paste(gallery , "/", template, sep=""))
  }
  if (type == "slides") {
    rmarkdown::render(input="beamer_presentation.Rmd",
                      output_format=rmarkdown::beamer_presentation(
                        includes=list(in_header="latex/header.tex"),
                        df_print="kable", fig_caption=FALSE, slide_level=2),
                      output_dir=paste(gallery , "/", template, sep=""))
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
#'
#' @param destination destination folder of the knitted documents.
#'
#' @export
build_githubpages <- function(destination=usethis::proj_path("docs")) {
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

  # Copy README.md to docs
  file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)

  cat("Output files moved to", destination)
}


#' Build Index
#'
#' Build a README.md file that will be used as index of GitHub Pages.
#'
#' R Markdown files of the project are used to get the title and abstract of the published documents.
#' A link to their HTML and PDF versions is added.
#' Metadata fields are needed in the .Rmd files YAML header: title, abstract and `URL`.
#'
#' @export
build_index <- function() {
  # Find the markdown files
  RmdFiles <- list.files(pattern="*.Rmd")
  lines <- character()
  for (RmdFile in RmdFiles) {
    yaml_header <- rmarkdown::yaml_front_matter(RmdFile)
    # Eliminate the extension
    RmdFileName <- gsub(".Rmd", "", RmdFile)
    lines <- c(lines,
                paste("# ", yaml_header$title, "\n", sep=""),
                yaml_header$abstract,
                "Formats:\n",
                paste("- [HTML](", yaml_header$url, RmdFileName, ".html)", sep=""),
                paste("- [PDF](", yaml_header$url, RmdFileName, ".pdf)\n", sep=""),
                "\n"
                )
  }
  usethis::write_over(usethis::proj_path("README.md"), lines)
}

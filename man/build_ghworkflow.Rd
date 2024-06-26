% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/memoiR.R
\name{build_ghworkflow}
\alias{build_ghworkflow}
\title{Build GitHub Action Workflow}
\usage{
build_ghworkflow()
}
\value{
The content of the YAML file as a vector of characters, invisibly. Each element is a line of the file.
}
\description{
Build a YAML file (\code{.gihub/workflows/memoir.yml}) to knit the documents
of the project to GitHub Pages.
The workflow knits all R Markdown files according their header: all output
formats are produced and stored into the \code{gh-pages} branch of the project.
}
\details{
All HTML outputs have the same name so the last one knitted overwrites the
previous ones.
Keep only one HTML format in the header of each RMarkdown file.

No \code{DESCRIPTION} file is necessary in the project to install packages.
They must be declared in the options code chunk of each .Rmd file
(index.Rmd for the memoir template).

Two secrets must have been stored in the GitHub account:
\itemize{
\item GH_PAT: a valid access token,
\item EMAIL: the email address to send the workflow results to.
}
}
\examples{
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

# Build GitHub Actions Workflow script
build_ghworkflow()
# Content
readLines(".github/workflows/memoir.yml")

## End of the example: cleanup
# Return to the original working directory and clean up
setwd(original_wd)
unlink(wd, recursive = TRUE)

}

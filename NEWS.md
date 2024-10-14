# memoiR 1.2-10

## Improvements
* updated Cecilapp/GitHub-Pages-deploy action version to v3 with new syntax in `build_ghworkflow()`.
* fixed URL format in DESCRIPTION.
* updated upload/download-artifact action version to v4.


# memoiR 1.2-9

## Improvements

* `kableExtra::kbl()` is preferred to `knitr::kable()` format tables after *kableExtra* v.1.4.0 (*kableExtra* issue [#831](https://github.com/haozhu233/kableExtra/issues/831)).


# memoiR 1.2-7

## Improvements

* The useless checkout step before deploying documents to GH pages by CI has been deleted.
* Documentation about tables has been improved in templates.
* Chunk options format is updated.
* `urlcolor: blue` is by default in stylish articles.


# memoiR 1.2-4

## External changes

* codecov.io URL in `README.md`.
* Github actions versions updated.
* Pending issue in [kableExtra](https://github.com/haozhu233/kableExtra/issues/750).

## Bug Correction

* Updated package help file following roxygen2 v.7 [breaking change](https://github.com/r-lib/roxygen2/issues/1491).


# memoiR 1.2-2

## Improvements

* All output format libraries are now installed with memoiR.


# memoiR 1.2-1

## Improvements

* Local tocs in PDF memoirs.
* Localized quotes in PDF.
* `urlcolor: blue` available in all templates.
* The logo in the epigraph of the PDF output of memoirs is now declared in the YAML header.
* Colored text blocks in memoirs. See the template's documentation.


# memoiR 1.2-0

## Improvements

* Full-width figures supported in memoirs.
* bs4_book css added to memoir template to support *Summary* block style.
* Date format is localized by `build_ghworkflow()`.
* distill format allowed for HTML articles.
* Better prevention of overfull lines in PDF articles.

## Bug Correction

* In article templates, check that `lang` is declared before selecting it.


# memoiR 1.1-4

## Bug Correction

* In all templates, knitr `message` option was spelled `messages`. Corrected.

## New features

* `urlcolor: blue` in beamer presentations.

## Improvements

* r-lib/actions v2 in `build_ghworkflow()`.


# memoiR 1.1-3

## Bug Correction

* Italic fonts were not declared by default in memoir headers.

## New features

* Bootstrap 4 HTML output is available for memoirs.
* Double space and line numbers in PDF Simple Articles are documented.
* Font size and table of contents depth can be changed in PDF articles.
* More options in headers:

  * message: false from code chunks
  * longbibliography: false in memoirs


# memoiR 1.1-2

## Bug Correction

* `build_ghworkflow()` failed if no font was declared in a memoir header.


# memoiR 1.1-0

## New features

* Logo on the last page of memoirs is optional (delete `cover-image:` in header).
* Paper and Stock sizes may be different in Memoir. See the customization [article](https://ericmarcon.github.io/memoiR/articles/customize.html).


# memoiR 1.0-0

## New features

* New Project wizard in RStudio.
* Customization of memoirs.


# memoiR 0.5-0

## New features

* Simple article, Stylish article, Memoir and Beamer templates.
* XeLaTex and polyglossia for all templates.
* Function to build GitHub Pages with knitted documents.
* Functions to build `.gitignore`, `README.md` and GitHub Actions workflow.

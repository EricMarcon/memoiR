# memoiR 1.1-4.9005

## Improvements

* full-width figures supported in memoirs.
* bs4_book css added to memoir template to support *Summary* block style.
* date format is localized by `build_ghworkflow()`. 

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

## New features

* Logo on the last page of memoirs is optional (delete `cover-image:` in header).
* Paper and Stock sizes may be different in Memoir. See the customization [article](https://ericmarcon.github.io/memoiR/articles/articles/memoir.html).


# memoiR 1.1-0

## New features

* Logo on the last page of memoirs is optional (delete `cover-image:` in header).
* Paper and Stock sizes may be different in Memoir. See the customization [article](https://ericmarcon.github.io/memoiR/articles/articles/memoir.html).


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

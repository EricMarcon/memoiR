# Changelog

## memoiR 1.3-1.9000

### Improvements

- next version

## memoiR 1.3-1

CRAN release: 2025-05-01

### Improvements

- cleaned up the code.
- allowed all authors on the same line in Stylish Article PDF.
- allowed ORCID link in Stylish Article PDF.

## memoiR 1.3-0

CRAN release: 2025-01-07

### Improvements

- added the “main” branch name to
  [`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md).
- corrected the Stylish Article template (Thanks to Florence Puech,
  [\#5](https://github.com/EricMarcon/memoiR/issues/5)).
- added JEL codes and acknowledgements to Stylish Article template.
- added a vignette about tables.

## memoiR 1.2-10

CRAN release: 2024-10-15

### Improvements

- updated Cecilapp/GitHub-Pages-deploy action version to v3 with new
  syntax in
  [`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md).
- fixed URL format in DESCRIPTION.
- updated upload/download-artifact action version to v4.

## memoiR 1.2-9

CRAN release: 2024-04-22

### Improvements

- [`kableExtra::kbl()`](https://rdrr.io/pkg/kableExtra/man/kbl.html) is
  preferred to
  [`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) format
  tables after *kableExtra* v.1.4.0 (*kableExtra* issue
  [\#831](https://github.com/haozhu233/kableExtra/issues/831)).

## memoiR 1.2-7

CRAN release: 2024-02-26

### Improvements

- The useless checkout step before deploying documents to GH pages by CI
  has been deleted.
- Documentation about tables has been improved in templates.
- Chunk options format is updated.
- `urlcolor: blue` is by default in stylish articles.

## memoiR 1.2-4

CRAN release: 2023-09-14

### External changes

- codecov.io URL in `README.md`.
- Github actions versions updated.
- Pending issue in
  [kableExtra](https://github.com/haozhu233/kableExtra/issues/750).

### Bug Correction

- Updated package help file following roxygen2 v.7 [breaking
  change](https://github.com/r-lib/roxygen2/issues/1491).

## memoiR 1.2-2

CRAN release: 2022-09-23

### Improvements

- All output format libraries are now installed with memoiR.

## memoiR 1.2-1

CRAN release: 2022-08-14

### Improvements

- Local tocs in PDF memoirs.
- Localized quotes in PDF.
- `urlcolor: blue` available in all templates.
- The logo in the epigraph of the PDF output of memoirs is now declared
  in the YAML header.
- Colored text blocks in memoirs. See the template’s documentation.

## memoiR 1.2-0

CRAN release: 2022-07-10

### Improvements

- Full-width figures supported in memoirs.
- bs4_book css added to memoir template to support *Summary* block
  style.
- Date format is localized by
  [`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md).
- distill format allowed for HTML articles.
- Better prevention of overfull lines in PDF articles.

### Bug Correction

- In article templates, check that `lang` is declared before selecting
  it.

## memoiR 1.1-4

CRAN release: 2022-01-20

### Bug Correction

- In all templates, knitr `message` option was spelled `messages`.
  Corrected.

### New features

- `urlcolor: blue` in beamer presentations.

### Improvements

- r-lib/actions v2 in
  [`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md).

## memoiR 1.1-3

CRAN release: 2021-11-13

### Bug Correction

- Italic fonts were not declared by default in memoir headers.

### New features

- Bootstrap 4 HTML output is available for memoirs.

- Double space and line numbers in PDF Simple Articles are documented.

- Font size and table of contents depth can be changed in PDF articles.

- More options in headers:

  - message: false from code chunks
  - longbibliography: false in memoirs

## memoiR 1.1-2

CRAN release: 2021-09-03

### Bug Correction

- [`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md)
  failed if no font was declared in a memoir header.

## memoiR 1.1-0

CRAN release: 2021-07-26

### New features

- Logo on the last page of memoirs is optional (delete `cover-image:` in
  header).
- Paper and Stock sizes may be different in Memoir. See the
  customization
  [article](https://ericmarcon.github.io/memoiR/articles/customize.html).

## memoiR 1.0-0

CRAN release: 2021-06-07

### New features

- New Project wizard in RStudio.
- Customization of memoirs.

## memoiR 0.5-0

CRAN release: 2021-05-11

### New features

- Simple article, Stylish article, Memoir and Beamer templates.
- XeLaTex and polyglossia for all templates.
- Function to build GitHub Pages with knitted documents.
- Functions to build `.gitignore`, `README.md` and GitHub Actions
  workflow.

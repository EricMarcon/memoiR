# memoiR <img src="man/figures/logo.png" align="right" alt="" width="120" />

![stability-wip](https://img.shields.io/badge/lifecycle-stable-green.svg)
![R-CMD-check](https://github.com/EricMarcon/memoiR/workflows/R-CMD-check/badge.svg)
[![codecov](https://codecov.io/github/EricMarcon/memoiR/branch/master/graphs/badge.svg)](https://app.codecov.io/github/EricMarcon/memoiR)
[![CRAN version](https://www.r-pkg.org/badges/version/memoiR)](https://CRAN.r-project.org/package=memoiR)
[![](https://cranlogs.r-pkg.org/badges/grand-total/memoiR)](https://CRAN.R-project.org/package=memoiR)
[![](https://cranlogs.r-pkg.org/badges/memoiR)](https://CRAN.R-project.org/package=memoiR)


This R package provides templates to publish well-formatted documents both in HTML and PDF formats. 
Documents can be produced locally or hosted on GitHub, where GitHub actions can update the published documents continuously.

Long documents are the main purpose of this package. 
Along with a GitBook or Bootstrap 4 version to be read online, their PDF version based on the LaTeX class memoir can be highly customized (see examples 1 and 2).

Functions are provided to make the publication of the documents on GitHub very easy, including their continuous integration.

Gallery:

- Memoir:
    - [HTML GitBook](https://ericmarcon.github.io/memoiR/gallery/memoir/bookdown_gitbook/index.html)
    - [HTML Bootstrap 4 book](https://ericmarcon.github.io/WorkingWithR/)
    - [PDF, small-margin layout](https://ericmarcon.github.io/memoiR/gallery/memoir/bookdown_pdf_book/MyBook.pdf)
    - [PDF, wide-margin layout](https://ericmarcon.github.io/MesuresBioDiv2/MesuresBD.pdf)
- Simple Article: 
    - [HTML Document](https://ericmarcon.github.io/memoiR/gallery/simple_article/bookdown_html_document2/simple_article.html)
    - [Downcute HTML](https://ericmarcon.github.io/memoiR/gallery/simple_article/rmdformats_downcute/simple_article.html)
    - The [distill article](https://ericmarcon.github.io/memoiR/gallery/stylish_article/bookdown_html_document2/stylish_article.html) format which is the Stylish Article default, is available too.
    - The HTML Gitbook format is similar to that of the [memoir](https://ericmarcon.github.io/memoiR/gallery/memoir/bookdown_gitbook/index.html) template
    - [PDF](https://ericmarcon.github.io/memoiR/gallery/simple_article/bookdown_pdf_book/simple_article.pdf)
- Stylish Article: 
    - [PDF](https://ericmarcon.github.io/memoiR/gallery/stylish_article/bookdown_pdf_book/stylish_article.pdf)
    - [distill](https://ericmarcon.github.io/memoiR/gallery/stylish_article/bookdown_html_document2/stylish_article.html)
    - Other HTML outputs are identical to those of the Simple Article.
- Beamer Presentation: 
    - [HTML IOSlide](https://ericmarcon.github.io/memoiR/gallery/beamer_presentation/bookdown_ioslides_presentation2/beamer_presentation.html)
    - [HTML Slidy](https://ericmarcon.github.io/memoiR/gallery/beamer_presentation/bookdown_slidy_presentation2/beamer_presentation.html)
    - [PDF (Beamer)](https://ericmarcon.github.io/memoiR/gallery/beamer_presentation/bookdown_beamer_presentation2/beamer_presentation.pdf)

A quick [introduction](https://ericmarcon.github.io/memoiR/articles/memoiR.html) is in `vignette("memoiR")`.

The development version documentation is available [here](https://ericmarcon.github.io/memoiR/dev/).

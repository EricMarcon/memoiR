# Tables with memoiR

The purpose here is to print a dataframe as a formated table.

Many packages are dedicated to tables but few of them meet the
requirements of memoiR:

- Support of numbered captions for cross-references (such as “Table 1:
  caption”).
- Support of HTML, LaTeX (ultimately PDF) and hopefully Word outputs.
- Support of 2-column LaTeX documents.
- Support of maths in all formats.

**kableExtra** is memoiR’s first choice because it supports LaTeX better
than the others. **huxtable** is an alternative if Word support is
needed.

## kableExtra

### Basic use

**bookdown** was built with the
[`kable()`](https://rdrr.io/pkg/knitr/man/kable.html) function[¹](#fn1),
completed by the **kableExtra** package.

This basic example shows how to produce a simple, well-formatted table.
The label of the code chunk is `cars`.

``` r
library("kableExtra")
mtcars[1:5, 1:6] |>
  kbl(
    caption = "Demo table", 
    booktabs = TRUE
  ) |>
  kable_styling()
```

|                   |  mpg | cyl | disp |  hp | drat |    wt |
|:------------------|-----:|----:|-----:|----:|-----:|------:|
| Mazda RX4         | 21.0 |   6 |  160 | 110 | 3.90 | 2.620 |
| Mazda RX4 Wag     | 21.0 |   6 |  160 | 110 | 3.90 | 2.875 |
| Datsun 710        | 22.8 |   4 |  108 |  93 | 3.85 | 2.320 |
| Hornet 4 Drive    | 21.4 |   6 |  258 | 110 | 3.08 | 3.215 |
| Hornet Sportabout | 18.7 |   8 |  360 | 175 | 3.15 | 3.440 |

Table 1: Demo table

The [`kableExtra::kbl()`](https://rdrr.io/pkg/kableExtra/man/kbl.html)
function replaces
[`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) starting
from version 1.2 of **kableExtra** to avoid incorrect caption format. A
consequence is that the table caption can’t be included in the chunk
header with option `tab.cap` which works only with
[`kable()`](https://rdrr.io/pkg/knitr/man/kable.html). The table caption
is thus in the argument `caption` of
[`kbl()`](https://rdrr.io/pkg/kableExtra/man/kbl.html). Formatted
captions, possibly with maths, can be used with text
references[²](#fn2):

- add the reference somewhere in the text (just above the code chunk is
  a good place), such as

&nbsp;

    (ref:cars) Caption with _italics_ and maths: $\pi$

- call the reference in the chunk with
  `caption = "Caption with `*`italics`*` and maths: ``\(\pi\)``."`. Note
  that **knitr** shows the value of the text reference in the chunk
  below.

``` r
library("kableExtra")
mtcars[1:5, 1:6] |>
  kbl(
    caption = "Caption with italics and maths: \(\pi\).", 
    booktabs = TRUE
  ) |>
  kable_styling()
```

|                   |  mpg | cyl | disp |  hp | drat |    wt |
|:------------------|-----:|----:|-----:|----:|-----:|------:|
| Mazda RX4         | 21.0 |   6 |  160 | 110 | 3.90 | 2.620 |
| Mazda RX4 Wag     | 21.0 |   6 |  160 | 110 | 3.90 | 2.875 |
| Datsun 710        | 22.8 |   4 |  108 |  93 | 3.85 | 2.320 |
| Hornet 4 Drive    | 21.4 |   6 |  258 | 110 | 3.08 | 3.215 |
| Hornet Sportabout | 18.7 |   8 |  360 | 175 | 3.15 | 3.440 |

Table 2: Caption with *italics* and maths: \\\pi\\.

Argument `booktabs = TRUE` provides clean horizontal rules and should
always be used.

Last,
[`kable_styling()`](https://rdrr.io/pkg/kableExtra/man/kable_styling.html)
formats the table for printing. It has many arguments that are not
detailed here: read the documentation of the package[³](#fn3). More
details are given in the document templates of memoiR, including the
code to place tables in a single column or across the full page in the
Stylish Article template.

Cross references (such as table [2](#tab:cars)) are called by
`table \@ref(tab:cars)`: the name of the code snippet (“cars” here) is
prefixed by `tab:`.

### Limitations

**kableExtra** used to produce clean tables in Word with a
workaround[⁴](#fn4) that was included in previous versions of memoiR but
this no longer the case since its version 1. Tables are rendered with a
single cell per row.

The solution is to produce the HTML version of the document, copy its
tables and paste them into the Word version[⁵](#fn5).

## huxtable

### Basic use

**huxtable** works perfectly with memoiR after adding the LaTeX packages
in the `preamble` section of the YAML header. Run
[`huxtable::report_latex_dependencies()`](https://hughjonesd.github.io/huxtable/reference/report_latex_dependencies.html)
and copy all of them to obtain something like

    preamble: >
      \usepackage{array}
      \usepackage{caption}
      ...

Add **huxtable** in the vector of packages to install in the “Options”
chunk:

``` r
# Add necessary packages here
packages <- c("tidyverse", "huxtable")
```

Tables are produced by
[`as_hux()`](https://hughjonesd.github.io/huxtable/reference/as_huxtable.html)
and formatting is made possible by a large set of functions.

``` r
library("huxtable")
mtcars[1:5, 1:6] |>
  as_hux() |>
  set_header_rows(1, value = TRUE) |> 
  style_headers(bold = TRUE) |> 
  theme_article() |>
  set_caption("Made by huxtable")
```

|  mpg | cyl | disp |  hp | drat |   wt |
|-----:|----:|-----:|----:|-----:|-----:|
| 21   |   6 |  160 | 110 | 3.9  | 2.62 |
| 21   |   6 |  160 | 110 | 3.9  | 2.88 |
| 22.8 |   4 |  108 |  93 | 3.85 | 2.32 |
| 21.4 |   6 |  258 | 110 | 3.08 | 3.21 |
| 18.7 |   8 |  360 | 175 | 3.15 | 3.44 |

Table 3: Made by **huxtable**

Read its documentation[⁶](#fn6).

### Limitations

Word output is correct, unlike **kableExtra**, but LaTeX support is more
limited. In Stylish Articles, tables are always printed in full width.
There seems to be no way to make them fit a single column.

## gt

**gt** is the a promising table package, developped by the RStudio team
with an approach similar to that of **ggplot2**, i.e. the definition of
a grammar of tables.

It has been focusing on HTML output and somehow neglected LaTeX in its
first versions. LaTeX support was improved in version 0.11 but it can’t
be used in memoiR yet because the numbered captions are not correct when
the document is rendered with
[`bookdown::html_document2()`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html),
as shown below.

``` r
library("gt")
```

    ## 
    ## Attaching package: 'gt'

    ## The following object is masked from 'package:huxtable':
    ## 
    ##     fmt_percent

``` r
mtcars[1:5, 1:6] |>
  gt(
    caption = "Demo table"
  )
```

| mpg  | cyl | disp | hp  | drat | wt    |
|------|-----|------|-----|------|-------|
| 21.0 | 6   | 160  | 110 | 3.90 | 2.620 |
| 21.0 | 6   | 160  | 110 | 3.90 | 2.875 |
| 22.8 | 4   | 108  | 93  | 3.85 | 2.320 |
| 21.4 | 6   | 258  | 110 | 3.08 | 3.215 |
| 18.7 | 8   | 360  | 175 | 3.15 | 3.440 |

Table 4: Demo table

## flextable

**flextable** supports all output formats but it does not produce
standard table captions. Even though they are numbered and support
cross-referencing, they rely on their own style, which makes them
different from figure captions. This requires extra work to harmonize
the documents.

More problematic, knitting to PDF fails with memoiR templates because
the LaTeX templates are not compatible.

In conclusion, flextable is not supported.

------------------------------------------------------------------------

1.  <https://bookdown.org/yihui/rmarkdown-cookbook/kable.html>

2.  <https://bookdown.org/yihui/bookdown/markdown-extensions-by-bookdown.html#text-references>

3.  <https://haozhu233.github.io/kableExtra/>

4.  <https://github.com/haozhu233/kableExtra/issues/308>

5.  <https://haozhu233.github.io/kableExtra/kableExtra_and_word.html>

6.  <https://hughjonesd.github.io/huxtable/reference/>

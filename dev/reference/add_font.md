# Add fonts

This function is called by
[`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md)
to install fonts.

## Usage

``` r
add_font(font)
```

## Arguments

- font:

  a font file name

## Value

A line of the GitHub Actions script to install the font package. `NULL`
if `font` is not recognized.

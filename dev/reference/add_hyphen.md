# Add hyphenation patterns

This function is called by
[`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md)
to install hyphenation patterns.

## Usage

``` r
add_hyphen(lang)
```

## Arguments

- lang:

  a language code, such as "fr-FR"

## Value

A line of the GitHub Actions script to install the hyphenation package.
`NULL` if `lang` is not recognized.

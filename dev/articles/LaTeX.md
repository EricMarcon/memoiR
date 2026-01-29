# Production of LaTeX Documents

Producing a PDF file from a R Markdown (`.Rmd`) document requires
several steps:

- **knitR** (Xie 2015) runs the code chunks to produce results and
  figures.
- **bookdown** (Xie 2016) (or **rmarkdown**: Xie, Allaire, and
  Grolemund 2018) produces a plain Markdown document. **memoiR**
  templates all rely on **bookdown** to benefit from cross references
  and figure/table numbering.
- Pandoc[¹](#fn1) is run to produce either directly an HTML document or
  a LaTeX file (`.tex`). The bibliography of HTML documents is processed
  by Pandoc at this stage[²](#fn2). **memoiR** templates delay it for
  LaTeX documents.
- A LaTeX engine is run to compile the LaTeX file and produce a PDF
  document. It uses reference management software (BibTeX[³](#fn3) or
  Biber[⁴](#fn4)) and a LaTeX package (natbib[⁵](#fn5) or
  biblatex[⁶](#fn6)) for bibliography.

**memoiR** templates rely on XeLaTeX[⁷](#fn7) to compile LaTeX documents
to PDF files. Among XeLaTex advantages over the classical pdflatex
engine[⁸](#fn8), including native UTF-8 encoding, the language support
by Polyglossia[⁹](#fn9) rather than Babel[¹⁰](#fn10) (required by
pdflatex) is similar to that of Pandoc to produce HTML formats, based on
IETF language tags[¹¹](#fn11) such as “en-US”. In short, this solution
is simpler and more robust: just fill the `lang` field in the document
header.

In the *memoir* template, bibliography is managed by biber and biblatex.
This appears to be the best solution for long documents, allowing
sidenote citations and cross-references from the bibliography to the
text containing the citation. The bibliographic style is
*verbose-inote*[¹²](#fn12) by default: it can be changed in the memoir
header.

In short documents, i.e. articles and presentations, bibtex and natbib
are preferred because the advanced formatting abilities of biblatex are
not very useful, more citation styles are available (`.bst`
files[¹³](#fn13)) and many journals expect them to be used.

## References

Xie, Yihui. 2015. *Dynamic Documents with R and Knitr*. 2nd ed. Boca
Raton, Florida: Chapman; Hall/CRC. <https://yihui.org/knitr/>.

———. 2016. *Bookdown: Authoring Books and Technical Documents with R
Markdown*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://github.com/rstudio/bookdown>.

Xie, Yihui, J. J. Allaire, and Garrett Grolemund. 2018. *R Markdown: The
Definitive Guide*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown>.

------------------------------------------------------------------------

1.  <https://pandoc.org/>

2.  <https://pandoc.org/MANUAL.html#citations>

3.  <http://www.bibtex.org/>

4.  <https://en.wikipedia.org/wiki/Biber_(LaTeX)>

5.  <https://en.wikibooks.org/wiki/LaTeX/Bibliography_Management#Natbib>

6.  <https://en.wikibooks.org/wiki/LaTeX/Bibliographies_with_biblatex_and_biber>

7.  <https://en.wikipedia.org/wiki/XeTeX>

8.  <https://en.wikipedia.org/wiki/PdfTeX>

9.  <https://ctan.org/pkg/polyglossia>

10. <https://ctan.org/pkg/babel>

11. <https://en.wikipedia.org/wiki/IETF_language_tag>

12. <https://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/examples/73-style-verbose-inote-biber.pdf>

13. <https://www.reed.edu/cis/help/LaTeX/bibtexstyles.html>

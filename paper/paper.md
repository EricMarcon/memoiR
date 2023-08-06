---
title: 'memoiR: R Markdown and Bookdown Templates to Publish Documents'
tags:
  - R
  - Markdown
  - litterate programming
authors:
  - name: Eric Marcon
    orcid: 0000-0002-5249-321X
    affiliation: 1
affiliations:
 - name: AgroParisTech, UMR AMAP, CIRAD, CNRS, INRAE, IRD, Univ Montpellier, Montpellier, France
   index: 1
date: 1 August 2023
bibliography: paper.bib
---

# Summary

memoiR is a package for R that provides templates to publish well-formatted documents both in HTML and PDF formats. 
Documents can be produced locally or hosted on GitHub, where GitHub actions can update the published documents continuously.

Long documents are the main purpose of this package.
Along with HTML output to be read online, their PDF version based on the LaTeX class **memoir** can be highly customized.

Functions are provided to make the publication of the documents on GitHub very easy, including their continuous integration.

Templates include:

- "Memoir": a book template based on memoir. 
The HTML version is a GitBook or a Bootstap 4 book and the PDF version is formatted by the memoir LaTeX template.
- "Stylish Article": an article for self archiving. 
The HTML versions are optimized to be read online and the PDF version is a two-column, well formatted article to be printed.
- "Simple Article":  simpler than the stylish article. 
The HTML versions are the same and the PDF version follows the classical 'article' LaTeX template.
- "Beamer Slideshow": the HTML version is either IOSlide or Slidy and the PDF version is a Beamer slideshow.

Available HTML formats for articles are:

- GitBook: `bookdown::gitbook`
- Bookdown's HTML format (`bookdown::html_document2`)
- Any format from the **rmdformats** package.
- distill article from the **distill** package.

A gallery is provided on the GitHub pages of the project.


# Statement of need

Reproducibility is a major concern of science [@Ioannidis2005], that induced propositions to improve it [@Munafo2017].

Experimental design and data curation are out of the scope of this paper but a lot can be done in the last steps of the production of scientific documents, namely data processing, inclusion of the results (including tables and figures) into a written document, and the final formatting.

Literate programming [@Knuth1984] is the framework: the code used to process the data is included into the text of the document, and run each time the document is produced.[@]
In the R [@R] environment, its first implementation was Sweave [@Leisch2002], that included code chunks into LaTeX documents.
The knitR package [@Xie2015] made its processing easy.

The emergence of Markdown [@Gruber2004] and its inclusion in Pandoc [@MacFarlane2006] motivated the development of R Markdown [@Xie2018] so that R users could switch from LaTeX to Markdown, enlarging the audience with less technical skills needed, and produce HTML outputs along with PDF documents.
R Markdown allows producing simple documents (the so-called R Markdown notebooks).
The bookdown package [@Xie2016] extends its features to the required standards for scientific publishing, namely bibliographic citations, numbered figures and equations, and cross-references in multi-chapter documents.
The powerful features of bookdown allow the simultaneous production of HTML and PDF documents, along with other formats such as Microsoft Word.

The memoiR package builds on bookdown with two main goals: provide a full set of well-formated templates and simplify the integration with GitHub pages to efficiently publish the documents.
The full process is summarized in figure \autoref{fig:process}.

![Processing documents with R and Markdown. memoiR provides templates and helpers to organize continuous integration and publication of the document of GitHub.\label{fig:process}](process.png)


The memoir LaTeX package[@Wilson2006] allows publishing high-quality long documents such as books and theses. 
The memoiR package for R makes it available for R users.
A wide set of options allows extensive customisation of the documents.
Other available formats are a simple and a stylish article, and a beamer slideshow.

To ensure reproducibility, the continuous integration supported by GitHub Actions and publication on GitHub pages are powerfull tools.
memoiR provides the functions to simplify their use, inclufing the production of the necessary scripts.


# Acknowledgements

This work benefited from the support of “Investissements d’avenir” of the French National Agency for Research (Labex CEBA, ref. ANR-10-LABX-25-01).
The author thanks [Mathias Legrand](https://www.mcgill.ca/mecheng/people/staff/mathias-legrand) for the original LaTeX class of the stylish article.

# References

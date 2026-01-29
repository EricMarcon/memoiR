# Upgrade a Project

Document projects made by **memoiR** can be knitted without the package,
which is used only to create them. Yet, new versions of the package may
support new features that should be included in an existing project.
Upgrading a document project to a new version of **memoiR** may be done
according to two different strategies. This may take some time so do it
only if necessary and keep a copy of the old version of the project.

## Create a new project

The simplest solution consists of creating a new project from scratch
with an updated version of the package. Then, copy and paste the content
of the old project:

- memoir chapters (`.Rmd` files) and text from the `index.Rmd` files in
  memoirs,
- text of `.Rmd` files from article or presentation projects
- the yaml headers of `.Rmd` files: they contain the parameters of the
  project (its title, its language…)

Run the commands again:
[`build_gitignore()`](https://EricMarcon.github.io/memoiR/dev/reference/build_gitignore.md)
to build the `.gitignore` file,
[`build_ghworkflow()`](https://EricMarcon.github.io/memoiR/dev/reference/build_ghworkflow.md)
to activate continuous integration,
[`build_readme()`](https://EricMarcon.github.io/memoiR/dev/reference/build_readme.md)
for the `README.md` file.

## Upgrade the helper files of an existing project

In the alternative strategy, the existing project is modified to assess
the new helper files from the package.

Create a new project of the same type as the project to upgrade,
e.g. “Stylish Article”. Copy files from the new project to the same
folder of the old one:

- replace the content of the `latex` folder (but do not overwrite your
  changes in `preamble.tex`, `before_body.tex` and `after_body.tex`).
- upgrade the `.css` files.
- add any new file that do not exist in the old project,
  e.g. `bs4_style.css` to allow Bootstrap 4 style in memoirs.

## Conclusion

Existing document projects can be upgraded to benefit from new features
of a recent **memoiR** version, at the price of copying new files from
the package. Changes in modified files, e.g. new options in the yaml
header of an existing `.Rmd` file require comparing the new and old file
structures and updating the new files line by line.

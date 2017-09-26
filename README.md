[![DOI](https://zenodo.org/badge/10928/surh/RosetteDetector.svg)](https://zenodo.org/badge/latestdoi/10928/surh/RosetteDetector)

[![Build Status](https://travis-ci.org/surh/RosetteDetector.svg?branch=master)](https://travis-ci.org/surh/RosetteDetector)

# RosetteDetector

An R package for detecting annd measuring size of Arabidopsis rosettes.

Uses a Support Vector Machine to find the plant.

# Installation

If you have not done it before, you will need to [install git lfs](https://help.github.com/articles/installing-git-large-file-storage/).

It is also recommended that you install the R package devtools. Just launch R and type

```r
install.packages("devtools")
```

Once you have git lfs installed, you can clone this repository.

```sh
git clone https://www.github.com/surh/RosetteDetector.git
```

Once you have cloned the repository, there are various ways to install the package, but the simplest and
recomended is to launch R from the same terminal location and type:

```r
devtools::install("RosetteDetector/")
```

For the development version, one must switch to the `dev` branch. After cloning the repository, go into
the newly created directory and switch branches by typing:

```sh
cd RosetteDetector
git checkout dev
```
Once this is done, you can use devtools to install the version in the development branch.
Just launch R from the repository directory and type:

```r
devtools::install("./")
```

## Dependencies

The full list of dependencies is specified in the "Imports" and "Suggests" fields of the [DESCRIPTION](DESCRIPTION) file.

R should automatically pull and install all the dependencies that are on CRAN. You can also manually install them with
the base R function `install.packages`.

[**EBImage**](https://www.bioconductor.org/packages/release/bioc/html/EBImage.html) must be installed via bioconductor and
you can find installation instructions that package's website. Typically you would type the following in the R prompt:

```r
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")
```

# Usage

For a basic introduction to the usage. Please look at the [basic pipeline vignette](inst/doc/pipeline.html).

# Referencing

For referencing please use the version doi.

[![DOI](https://zenodo.org/badge/10928/surh/RosetteDetector.svg)](https://zenodo.org/badge/latestdoi/10928/surh/RosetteDetector)

# Copyright & license

    (C) Copyright 2017 Sur Herrera Paredes

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


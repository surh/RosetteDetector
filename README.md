[![DOI](https://zenodo.org/badge/10928/surh/RosetteDetector.svg)](https://zenodo.org/badge/latestdoi/10928/surh/RosetteDetector) [![Build Status](https://travis-ci.org/surh/RosetteDetector.svg?branch=master)](https://travis-ci.org/surh/RosetteDetector) [![codecov](https://codecov.io/gh/surh/RosetteDetector/branch/master/graph/badge.svg)](https://codecov.io/gh/surh/RosetteDetector)
# RosetteDetector

An R package for detecting annd measuring size of Arabidopsis rosettes.

Uses a Support Vector Machine to find the plant.

Visit the [package's website](https://surh.github.io/RosetteDetector/).

# Installation

It is also recommended that you install the R package devtools. Just launch R and type:

```r
install.packages("devtools")
```

Once you have devtools installed, you can install with:

```r
devtools::install_github("surh/RosetteDetector/")
```

## Development version

[![Build Status](https://travis-ci.org/surh/RosetteDetector.svg?branch=dev)](https://travis-ci.org/surh/RosetteDetector) [![codecov](https://codecov.io/gh/surh/RosetteDetector/branch/dev/graph/badge.svg)](https://codecov.io/gh/surh/RosetteDetector)

For the development version, one must switch to the `dev` branch. 

```r
devtools::install_github("surh/RosetteDetector/", ref='dev')
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

For a basic introduction to the usage. Please look at the [basic pipeline vignette](https://surh.github.io/RosetteDetector/articles/pipeline.html).

If you have already installed the package you can use the following
command in the R prompt:

```r
vignette('pipeline', package = 'RosetteDetector')
```

You can also find where the vignette was installed in your system by
typing:

```r
system.file("doc",package = "RosetteDetector", mustWork = TRUE)
```

For the full documentation, please look at the [package's reference](https://surh.github.io/RosetteDetector/reference/index.html)

# Citation

If you use this code, please use the version's DOI.

[![DOI](https://zenodo.org/badge/10928/surh/RosetteDetector.svg)](https://zenodo.org/badge/latestdoi/10928/surh/RosetteDetector)

# Copyright & license

    (C) Copyright 2017-2018 Sur Herrera Paredes

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


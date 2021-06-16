# snappmarketvoice

<!-- badges: start -->
[![R-CMD-check](https://github.com/r-lib/devtools/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/devtools/actions)
[![Coverage Status](https://codecov.io/github/r-lib/devtools/coverage.svg?branch=master)](https://codecov.io/github/r-lib/devtools?branch=master)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/devtools)](https://cran.r-project.org/package=devtools)
<!-- badges: end -->

The aim of this package is to enhance some important functions in 'tuneR' and 'seewave' packages by the data.table (The Great).
For not loosing the tracks of the main packages we add only one 'f_' before the name of each function which represents its faster.

## Installation

```r
# Install devtools from CRAN
install.packages("devtools")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("MohammadShahbazi/snappmarketvoice")
```


## Usage

All devtools functions accept a path as an argument, e.g.
`load_all("path/to/mypkg")`. If you don't specify a path, devtools will
look in the current working directory - this is a recommended practice.

### Frequent development tasks:

* `f_fpeaks` is similar to seewave::fpeaks but faster for the comparison see the below.

```r
 p=Sys.time()
 a=fpeaks(spec,plot = F)
 p-Sys.time()
Time difference of -12.9078 mins
 p=Sys.time()
 a=f_fpeaks(spec)
 p-Sys.time()
Time difference of -0.5607369 secs
```

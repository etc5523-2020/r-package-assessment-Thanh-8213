
<!-- README.md is generated from README.Rmd. Please edit that file -->

# icecovid19

<!-- badges: start -->

<!-- badges: end -->

The goal of icecovid19 is to …

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-Thanh-8213")
```

## Examples

``` r
library(icecovid19)
library(tibble)
library(DT)
```

### Dataset example: Data\_total

``` r
as.tibble(data_total)
#> Warning: `as.tibble()` is deprecated as of tibble 2.0.0.
#> Please use `as_tibble()` instead.
#> The signature and semantics have changed, see `?as_tibble`.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_warnings()` to see where this warning was generated.
#> # A tibble: 48,692 x 7
#>    `Country/Region` date         Lat  Long confirmed deceased recovered
#>    <chr>            <date>     <dbl> <dbl>     <dbl>    <dbl>     <dbl>
#>  1 Afghanistan      2020-01-22  33.9  67.7         0        0         0
#>  2 Afghanistan      2020-01-23  33.9  67.7         0        0         0
#>  3 Afghanistan      2020-01-24  33.9  67.7         0        0         0
#>  4 Afghanistan      2020-01-25  33.9  67.7         0        0         0
#>  5 Afghanistan      2020-01-26  33.9  67.7         0        0         0
#>  6 Afghanistan      2020-01-27  33.9  67.7         0        0         0
#>  7 Afghanistan      2020-01-28  33.9  67.7         0        0         0
#>  8 Afghanistan      2020-01-29  33.9  67.7         0        0         0
#>  9 Afghanistan      2020-01-30  33.9  67.7         0        0         0
#> 10 Afghanistan      2020-01-31  33.9  67.7         0        0         0
#> # ... with 48,682 more rows
```

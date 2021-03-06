
<!-- README.md is generated from README.Rmd. Please edit that file -->

# icecovid19

<!-- badges: start -->

<!-- badges: end -->

The goal of the package is to deploy a shiny app and the data and
functions required for the app to run.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-Thanh-8213")
```

## Examples

### Dataset example: Data\_total

``` r
as_tibble(data_total)
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

### Function example

Here are some example of the functions in this package:

#### summariseData function

``` r
as_tibble(summariseData(data_total, date))
#> # A tibble: 259 x 4
#>    date       Confirmed Deceased `Estimated Recoveries`
#>    <date>         <dbl>    <dbl>                  <dbl>
#>  1 2020-01-22       555       17                     28
#>  2 2020-01-23       654       18                     30
#>  3 2020-01-24       941       26                     36
#>  4 2020-01-25      1434       42                     39
#>  5 2020-01-26      2118       56                     52
#>  6 2020-01-27      2927       82                     61
#>  7 2020-01-28      5578      131                    107
#>  8 2020-01-29      6167      133                    126
#>  9 2020-01-30      8235      171                    143
#> 10 2020-01-31      9927      213                    222
#> # ... with 249 more rows
```

#### getSummaryDT function

``` r
getSummaryDT(data_total, `Country/Region`)
```

<img src="man/figures/README-function2-1.png" width="100%" />

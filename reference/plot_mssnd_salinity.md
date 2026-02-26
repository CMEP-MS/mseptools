# Plot Mississippi Sound Salinity Data

Creates a plotly visualization of salinity data from USGS monitoring
stations in the Mississippi portion of the Mississippi Sound. The plot
is stacked by default, with instantaneous values in the top graph and
daily means on the bottom. A range slider is on the bottom to allow
viewing of a smaller portion of time.

## Usage

``` r
plot_mssnd_salinity(data, nrow = 2, colors = NULL)
```

## Arguments

- data:

  A list with three required elements: `data` (instantaneous
  measurements), `daily` (daily averages), and `siteInfo` (station
  metadata). This is typically the output from the
  [`get_mssnd_data()`](https://cmep-ms.github.io/mseptools/reference/get_mssnd_data.md)
  function.

- nrow:

  Integer. Number of rows in the subplot layout. Default is 2
  (instantaneous data on top, daily means on bottom). Change to 1 if you
  prefer the graphs side-by-side.

- colors:

  Character vector of color codes to use for different stations. Can be
  a named vector. If NULL (default), the khroma package's "roma" scheme
  will be used.

## Value

A plotly object with interactive time series plots of salinity data. The
top plot shows instantaneous measurements, and the bottom plot shows
daily means. Both plots share x and y axes. A date range slider is
included for easier navigation of the time series.

## Examples

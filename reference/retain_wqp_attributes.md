# Restore WQP attributes after column removal

This function restores attributes that are lost when empty columns are
removed from a Water Quality Portal (WQP) data download. It is intended
to be used after applying `janitor::remove_empty("cols")` (or similar)
to a WQP data frame, which drops important metadata stored as attributes
(e.g., site information, characteristic metadata, and request URLs).

## Usage

``` r
retain_wqp_attributes(data_full, data_reduced)
```

## Arguments

- data_full:

  A data frame returned directly from the Water Quality Portal (WQP)
  download function
  [`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html),
  containing the full set of WQP attributes.

- data_reduced:

  A data frame derived from `data_full` with empty columns removed
  (e.g., via `janitor::remove_empty("cols")`), which has lost some or
  all of the original attributes.

## Value

A data frame with the same columns as `data_reduced` and the attributes
from `data_full` restored where missing. The returned object preserves
WQP metadata such as site information, variable descriptions, and
request details.

## Details

The function copies attributes from the original full data frame and
re-attaches any attributes that are missing from the reduced data frame,
returning a data frame with fewer columns but the original WQP metadata
intact.

## See also

[`remove_empty`](https://sfirke.github.io/janitor/reference/remove_empty.html),
[`get_wqp_data`](https://cmep-ms.github.io/mseptools/reference/get_wqp_data.md)

## Examples

``` r
if (FALSE) { # \dontrun{
full <- get_wqp_data(...)
reduced <- janitor::remove_empty(full, "cols")
restored <- retain_wqp_attributes(full, reduced)
} # }
```

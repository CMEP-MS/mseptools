# Changelog

## mseptools 0.2.2

- added more tests for plotting and mapping functions

## mseptools 0.2.1

- modified multiple HUC selection inside
  [`get_wqp_data()`](https://cmep-ms.github.io/mseptools/reference/get_wqp_data.md).
  (after I learned how to bump versions and use git tags.)

## mseptools 0.2.0

- added function
  [`get_wqp_data()`](https://cmep-ms.github.io/mseptools/reference/get_wqp_data.md)
  to pull data from the Water Quality Portal for only MSEP areas. This
  is a wrapper function for
  [`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html).  
- added function
  [`retain_wqp_attributes()`](https://cmep-ms.github.io/mseptools/reference/retain_wqp_attributes.md)
  to keep attributes/metadata after using functions that strip away
  attributes (like
  [`janitor::remove_empty()`](https://sfirke.github.io/janitor/reference/remove_empty.html)).
  Mostly a helper function for
  [`get_wqp_data()`](https://cmep-ms.github.io/mseptools/reference/get_wqp_data.md),
  but could be useful in other situations.  
- added unit tests for all functions.

## mseptools 0.1.0

- created.

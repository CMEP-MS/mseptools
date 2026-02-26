# Retrieve Water Quality Portal (WQP) data for predefined Mississippi areas

A wrapper around
[`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html)
that simplifies data retrieval for commonly used Mississippi Sound
Estuary Program watershed, basin, and coastal-county groupings. The
function handles multi-county queries internally and binds results into
a single data frame.

## Usage

``` r
get_wqp_data(
  area = c("watershedComplete", "3coastalCounties", "6coastalCounties",
    "basinCoastalStreams"),
  sampleMedia = "Water",
  service = "Result",
  dataProfile = "resultPhysChem",
  ...
)
```

## Arguments

- area:

  Character string specifying the spatial area to query. Must be one of:

  `"watershedComplete"`

  :   complete Mississippi Sound Watershed, HUCs 0317 and 0318. May
      return data from Alabama and Louisiana as well as Mississippi.

  `"3coastalCounties"`

  :   Jackson, Harrison, and Hancock counties (MS)

  `"6coastalCounties"`

  :   Jackson, Harrison, Hancock, George, Stone, and Pearl River
      counties (MS)

  `"basinCoastalStreams"`

  :   MDEQ's Coastal Streams Basin: HUC 03170009

- sampleMedia:

  Character string passed to
  [`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html)
  specifying the sample media (default is `"Water"`).

- service:

  Character string specifying the WQP service to query (default is
  `"Result"`).

- dataProfile:

  Character string specifying the WQP data profile (default is
  `"resultPhysChem"`, as this format includes method detection limit
  information).

- ...:

  Additional arguments passed directly to
  [`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html),
  such as `startDateLo`, `startDateHi`, `characteristicName`,
  `characteristicType` (anything you would put in 'Characteristic Group'
  in the WQP Advanced Query page to narrow down data types - some
  desirable ones are `"Physical"`, `"Nutrients"`,
  `"Biological, Algae, Phytoplankton"`, `"Inorganic, Major, Metals"`,
  `"Inorganic, Minor, Metals"`, or `siteType`. **NOTE:**
  `characteristicType` **DOES NOT WORK** with complex areas like
  multiple HUCs or counties, even through the WQP site itself. Inside
  this function, the `characteristicType` option only works with
  `area = "basinCoastalStreams"`.

## Value

A data frame containing WQP results for the requested area. Empty
columns are removed.

## Details

This function preserves Water Quality Portal (WQP) metadata stored as
attributes on the returned data frame, even when empty columns are
removed during post-processing. As a result, the output can be passed
directly to
[`dataRetrieval::create_WQP_bib()`](https://rdrr.io/pkg/dataRetrieval/man/create_WQP_bib.html)
to generate an appropriate data citation for the WQP query.

## See also

[`retain_wqp_attributes()`](https://cmep-ms.github.io/mseptools/reference/retain_wqp_attributes.md),
[`dataRetrieval::create_WQP_bib()`](https://rdrr.io/pkg/dataRetrieval/man/create_WQP_bib.html),
[`dataRetrieval::readWQPdata()`](https://rdrr.io/pkg/dataRetrieval/man/readWQPdata.html)

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve data for MDEQ's Coastal Streams Basin for 2020
dat1 <- get_wqp_data(
  area = "basinCoastalStreams",
  startDateLo = "2020-01-01",
  startDateHi = "2020-12-31"
)

# Retrieve DO only data for the three coastal counties in 2020
dat2 <- get_wqp_data(
  area = "3coastalCounties",
  characteristicName = "Dissolved oxygen (DO)",
  startDateLo = "2020-01-01",
  startDateHi = "2020-12-31"
)
} # }
```

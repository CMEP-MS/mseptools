# Mississippi Sound Salinity Data from 2019

Salinity data from 8 Mississippi Sound USGS stations, subsetted from
`mssnd_salinity` to only include the year 2019. All available readings
were downloaded through the USGS NWIS API using `get_mssnd_salinity()`,
a wrapper for
[`dataRetrieval::readNWISuv`](https://rdrr.io/pkg/dataRetrieval/man/readNWISuv.html).
Readings were also processed into daily min, mean, and max. Station
metadata is provided in `siteInfo`.

## Usage

``` r
mssnd_salinity2019
```

## Format

### `mssnd_salinity`

A list containing 3 data frames:

- data:

  data frame of all salinity readings

- siteInfo:

  data frame of station metadata, including lat/long coordinates and
  cleaned names. Cleaned names are a factor, ordered from west to east.

- daily:

  data frame of min, max, and mean salinity per day by station.

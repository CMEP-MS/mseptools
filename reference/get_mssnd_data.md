# Get data from USGS stations

This function is largely a wrapper function for
\`dataRetrieval::readNWISuv\`, but focused on salinity at the 8 USGS
stations in the Mississippi portion of the Mississippi Sound.

## Usage

``` r
get_mssnd_data(
  stations = c("301001089442600", "300722089150100", "301429089145600",
    "301912088583300", "301527088521500", "302318088512600", "301849088350000",
    "301141089320300"),
  params = "00480",
  startDate = Sys.Date() %m-% months(1),
  endDate = Sys.Date(),
  tz = "America/Regina"
)
```

## Arguments

- stations:

  Character vector of USGS station IDs. Defaults to all 8 USGS stations
  located in the Mississippi portion of the Mississippi Sound.

- params:

  Character vector of USGS parameter codes. Defaults to \`00480\`, which
  corresponds to salinity.

- startDate:

  Date object or character string in \`YYYY-MM-DD\` format. Defaults to
  one month ago based on the system date.

- endDate:

  Date object or character string in \`YYYY-MM-DD\` format. Defaults to
  the current system date.

- tz:

  Character string indicating the desired time zone. The underlying USGS
  function retrieves data in UTC, and this wrapper defaults to
  \`America/Regina\` - local standard time (does not adjust for daylight
  saving time).

## Value

A named list with 2 or 3 components:

- \`data\`:

  A data frame of raw unit-value (instantaneous) data from the USGS.

- \`siteInfo\`:

  Metadata for the stations, extracted from the attributes of the
  returned data frame.

- \`daily\`:

  (Optional) A data frame summarizing daily minimum, mean, and maximum
  salinity values for each site and date. This is only included if
  salinity data (\`Sal\`) is detected in the returned dataset.

## Details

This function downloads high-frequency data via the USGS NWIS portal. It
is specific to Mississippi Sound salinity data and does some processing
as well. The function downloads high-frequency water quality data
(typically salinity) from the USGS National Water Information System for
selected monitoring stations in the Mississippi portion of the
Mississippi Sound. The function returns raw data, site metadata, and (if
salinity data is present) daily summaries of minimum, mean, and maximum
salinity values.

The function relies on several external packages:

- dataRetrieval for retrieving and renaming USGS data via
  \`readNWISuv()\` and \`renameNWISColumns()\`

- stringr for pattern matching and replacement in variable names via
  \`str_replace()\` and \`str_detect()\`

- dplyr for data manipulation, grouping, and summarizing

- lubridate for date arithmetic (e.g., \`

The default behavior focuses on salinity (parameter code 00480), but any
other available parameters can be passed.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get salinity data for the past month at default stations
result <- get_mssnd_data()

# Retrieve water temp data from two stations

# View daily summary if salinity was included
head(result$daily)
} # }
```

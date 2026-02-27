# Maps and Plots

``` r
library(mseptools)
```

### Examine Data

We’ll work with the built-in 2019 salinity dataset.

``` r
dat <- mssnd_salinity2019
```

Look at the head of the main data frame. This contains salinity readings
at 30-minute intervals.

``` r
head(dat$data)
#>   agency_cd         site_no            dateTime Sal_Inst Sal_Inst_cd
#> 1      USGS 300722089150100 2019-01-31 11:00:00       13           A
#> 2      USGS 300722089150100 2019-01-31 11:30:00       13           A
#> 3      USGS 300722089150100 2019-01-31 12:00:00       13           A
#> 4      USGS 300722089150100 2019-01-31 12:30:00       13           A
#> 5      USGS 300722089150100 2019-01-31 13:00:00       13           A
#> 6      USGS 300722089150100 2019-01-31 13:30:00       13           A
#>            tz_cd
#> 1 America/Regina
#> 2 America/Regina
#> 3 America/Regina
#> 4 America/Regina
#> 5 America/Regina
#> 6 America/Regina
```

Look at the head of the daily averages data frame.

``` r
head(dat$daily)
#>           site_no       date  sal_mean sal_min sal_max
#> 1 301001089442600 2019-01-01  2.858333     2.7       3
#> 2 300722089150100 2019-01-31 13.000000    13.0      13
#> 3 300722089150100 2019-02-01 13.895833    13.0      15
#> 4 300722089150100 2019-02-02 15.000000    15.0      15
#> 5 300722089150100 2019-02-03 14.645833    14.0      15
#> 6 300722089150100 2019-02-04 14.000000    14.0      14
```

Something strange might be going on with January 1st.

``` r
dat$daily |> 
    dplyr::arrange(date) |> 
    head()
#>           site_no       date sal_mean sal_min sal_max
#> 1 301001089442600 2019-01-01 2.858333     2.7     3.0
#> 2 301001089442600 2019-01-01 2.652778     2.4     3.0
#> 3 301001089442600 2019-01-02 2.366667     2.1     2.5
#> 4 301001089442600 2019-01-03 2.104167     1.5     2.4
#> 5 301001089442600 2019-01-04 1.993750     1.2     2.4
#> 6 301001089442600 2019-01-05 2.329167     2.3     2.4
```

Yes, I probably need to fix something inside the function that
calculates daily averages - there’s probably some UTC-to-LST conversion
issue.

And let’s see what’s in the site info data frame.

``` r
head(dat$siteInfo)
#>                                           station_nm         site_no agency_cd
#> 1                Rigolets at Hwy 90 near Slidell, LA 301001089442600      USGS
#> 2  EAST PEARL RIVER AT CSX RAILROAD NR CLAIBORNE, MS 301141089320300      USGS
#> 3                  Mississippi Sound near Grand Pass 300722089150100      USGS
#> 4 MISSISSIPPI SOUND AT USGS MERRILL SHELL BANK LIGHT 301429089145600      USGS
#> 5       MISSISSIPPI SOUND AT USGS GULFPORT LIGHT, MS 301912088583300      USGS
#> 6   MISSISSIPPI SOUND AT USGS EAST SHIP ISLAND LIGHT 301527088521500      USGS
#>   timeZoneOffset timeZoneAbbreviation dec_lat_va dec_lon_va       srs
#> 1         -06:00                  CST   30.16694  -89.74056 EPSG:4326
#> 2         -06:00                  CST   30.19472  -89.53417 EPSG:4326
#> 3         -06:00                  CST   30.12278  -89.25028 EPSG:4326
#> 4         -06:00                  CST   30.23825  -89.24282 EPSG:4326
#> 5         -06:00                  CST   30.31861  -88.97222 EPSG:4326
#> 6         -06:00                  CST   30.25444  -88.86889 EPSG:4326
#>   siteTypeCd    hucCd stateCd countyCd network
#> 1      OC-CO 08090203      22    22071    NWIS
#> 2         ST 03180004      28    28045    NWIS
#> 3      OC-CO 08090203      22    22087    NWIS
#> 4         ES 03170009      28    28059    NWIS
#> 5      OC-CO 03170009      28    28047    NWIS
#> 6      OC-CO 03170009      28    28047    NWIS
#>                                    clean_nm
#> 1                 Rigolets, Hwy 90, Slidell
#> 2 East Pearl River, Csx Railroad, Claiborne
#> 3                                Grand Pass
#> 4                  Merrill Shell Bank Light
#> 5                            Gulfport Light
#> 6                    East Ship Island Light
```

### Plot

This graph uses `plotly`, which makes the graphics interactive. In
addition to hovering over parts of the graph to see the exact values,
you can click on a legend entry to remove (or re-show) a station;
double-click to show *only* that station. There is a slider bar below so
you can narrow the date range.

``` r
plot_mssnd_salinity(dat)
```

### Map the stations

This function uses `leaflet` to show the USGS monitoring stations on a
map.

``` r
map_mssnd_usgs(dat$siteInfo)
```

### Color palette

[`plot_mssnd_salinity()`](https://cmep-ms.github.io/mseptools/reference/plot_mssnd_salinity.md)
takes a named vector of colors; `leaflet` does not. A common palette can
be created and used in both functions as follows:

``` r
stns <- sort(dat$siteInfo$clean_nm)

# static color palette
colors_static <- as.character(khroma::color("roma")(length(stns)))
names(colors_static) <- stns

# color function
color_function <- leaflet::colorFactor(palette = colors_static,
                                       domain = names(colors_static))

# plot and map with these palettes
plot_mssnd_salinity(dat, colors = colors_static)
```

``` r
map_mssnd_usgs(dat$siteInfo, color_function = color_function)
```

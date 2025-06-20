library(sf)
library(dplyr)

msep_boundary <- st_read(here::here("data-raw",
                                    "MSEP_outline.shp"))  |>
    dplyr::select(sourcrg,
                  loaddat,
                  geometry) |>
    st_simplify(dTolerance = 1)

usethis::use_data(msep_boundary, overwrite = TRUE,
                  compress = "xz")

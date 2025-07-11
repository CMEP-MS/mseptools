library(msepBoundaries)
library(sf)
library(dplyr)

msep_boundary <- outline_full |>
    st_simplify(dTolerance = 500)


mapview::mapview(outline_full,
                 alpha.regions = 0) +
    mapview::mapview(msep_boundary,
                     col.regions = "red",
                     color = "red",
                     alpha.regions = 0)

usethis::use_data(msep_boundary, overwrite = TRUE,
                  compress = "xz")

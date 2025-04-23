load(here::here("data", "mssnd_salinity.rda"))
mssnd_salinity2019 <- mssnd_salinity
mssnd_salinity2019$data <- mssnd_salinity2019$data |>
    dplyr::filter(lubridate::year(dateTime) == 2019)
mssnd_salinity2019$daily <- mssnd_salinity2019$daily |>
    dplyr::filter(lubridate::year(date) == 2019)

usethis::use_data(mssnd_salinity2019, overwrite = TRUE,
                  compress = "xz")

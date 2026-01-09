test_that("map_mssnd_salinity works", {
    to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
        dplyr::filter(date == as.Date("2023-06-01"))

    expect_no_condition(map_mssnd_salinity(to_map))
})

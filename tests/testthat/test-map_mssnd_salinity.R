test_that("map_mssnd_salinity works", {
    to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
        dplyr::filter(date == as.Date("2023-06-01"))

    # shouldn't fail
    expect_no_condition(m <- map_mssnd_salinity(to_map))

    # should have leaflet and html widget in its class
    expect_setequal(class(m), c("leaflet", "htmlwidget"))


    # should be 6 points on the map on this date. find the call to add them.
    point_calls <- purrr::keep(m$x$calls, ~ .x$method == "addCircleMarkers")
    # make sure there's only the one call.
    expect_length(point_calls, 1)
    # make sure the vector of latitudes contains 6 points.
    expect_length(point_calls[[1]]$args[[1]], 6)


    # make sure there's a legend and the title is right
    legend_calls <- purrr::keep(m$x$calls, ~ .x$method == "addLegend")
    expect_length(legend_calls, 1)
    expect_equal(
        legend_calls[[1]]$args[[1]]$title,
        "Salinity<br>(ppt)"
    )
})

test_that("function gets salinity data", {
    # it doesn't throw an error at all
    expect_no_error(tmp <- get_mssnd_data(startDate = "2025-01-01",
                                          endDate = "2025-01-15"))

    # it downloaded salinity
    downloaded_var <- attributes(tmp$data)$variableInfo$variableName
    expect_true(stringr::str_detect(downloaded_var, "Salinity"))

    # there are 3 data frames in the list (i.e. it calculated daily mean sal)
    expect_equal(length(tmp), 3)

})

test_that("function customization works", {
    # should download fine
    expect_no_error(
        tmp <- get_mssnd_data(
            startDate = "2025-01-01",
            endDate = "2025-01-15",
            stations = c("301001089442600",
                         "300722089150100"),
            params = "00010"
        )
    )

    # make sure it downloaded water temp
    downloaded_var <- attributes(tmp$data)$variableInfo$variableName
    expect_true(stringr::str_detect(downloaded_var, "Temperature, water"))

    # make sure it downloaded data from 2 stations
    expect_equal(length(unique(tmp$data$site_no)), 2)

    # there are 2 data frames in the list (no daily mean calcs for non-salinity)
    expect_equal(length(tmp), 2)
})


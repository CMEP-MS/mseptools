test_that("hucs work", {

    # whole watershed because it involves two hucs; make sure both hucs appear in attributes
    tmp <- get_wqp_data(area = "watershedComplete",
                        startDateLo = "2021-01-01",
                        startDateHi = "2021-01-15")

    tmp_sites <- attributes(tmp)$siteInfo
    tmp_huc4s <- sort(unique(stringr::str_sub(tmp_sites$HUCEightDigitCode, 1, 4)))
    expect_setequal(tmp_huc4s, c("0317", "0318"))


    # coastal streams basin because it's only one huc
    tmp <- get_wqp_data(area = "basinCoastalStreams",
                        startDateLo = "2021-01-01",
                        startDateHi = "2021-01-15")

    tmp_sites <- attributes(tmp)$siteInfo
    tmp_huc8 <- sort(unique(tmp_sites$HUCEightDigitCode))
    expect_equal(tmp_huc8, "03170009")

})

test_that("coastal counties work", {
    cty_codes_3 <- c("045", "047", "059")
    cty_codes_6 <- c(cty_codes_3, "039", "109", "131")

    # 6 coastal counties
    tmp <- get_wqp_data(area = "6coastalCounties",
                        startDateLo = "2024-01-01",
                        startDateHi = "2024-01-15")

    tmp_sites <- attributes(tmp)$siteInfo
    tmp_cts_6 <- unique(tmp_sites$CountyCode)

    # time period may not have all the counties but those
    # in tmp_cts should at least be a subset of the 6
    expect_in(tmp_cts_6, cty_codes_6)


    # 3 coastal cts - should all be included
    tmp <- get_wqp_data(area = "3coastalCounties",
                        startDateLo = "2024-01-01",
                        startDateHi = "2024-01-15")

    tmp_sites <- attributes(tmp)$siteInfo
    tmp_cts_3 <- unique(tmp_sites$CountyCode)

    expect_setequal(tmp_cts_3, cty_codes_3)
})

test_that("additional args (dots) work", {

    # try a certain parameter, and make sure it matches input
    tmp <- get_wqp_data(area = "3coastalCounties",
                        startDateLo = "2024-01-01",
                        startDateHi = "2024-01-15",
                        characteristicName = "Dissolved oxygen (DO)")
    tmp_vars_ctsDO <- attributes(tmp)$variableInfo
    expect_equal(tmp_vars_ctsDO$characteristicName, "Dissolved oxygen (DO)")

    # try a characteristic type, and make sure that works
    # it does for using hucs
    tmp <- get_wqp_data(area = "basinCoastalStreams",
                        startDateLo = "2024-01-01",
                        startDateHi = "2024-01-15",
                        characteristicType = "Nutrient")
    tmp_vars_basinNut <- attributes(tmp)$variableInfo
    expect_contains(tmp_vars_basinNut$characteristicName, c("Phosphorus", "Ammonia-nitrogen"))

    # # but not for coastal counties - whyyyyyyy
    # # this actually doesn't even work from the website
    # tmp <- get_wqp_data(area = "3coastalCounties",
    #                     startDateLo = "2024-01-01",
    #                     startDateHi = "2024-01-15",
    #                     characteristicType = "Nutrient")
    # tmp_vars_ctsNut <- attributes(tmp)$variableInfo
    # expect_contains(tmp_vars_ctsNut$characteristicName, c("Phosphorus", "Ammonia-nitrogen"))
    #
    #
    # # multiple hucs?
    # # nope
    # tmp <- get_wqp_data(area = "watershedComplete",
    #                     startDateLo = "2024-01-01",
    #                     startDateHi = "2024-01-15",
    #                     characteristicType = "Nutrient")
    # tmp_vars_hucNut <- attributes(tmp)$variableInfo
    # expect_contains(tmp_vars_hucNut$characteristicName, c("Phosphorus", "Ammonia-nitrogen"))

})

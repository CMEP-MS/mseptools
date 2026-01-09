test_that("mapping USGS stations works", {
  expect_no_condition(map_mssnd_usgs(mssnd_salinity2019$siteInfo))
})

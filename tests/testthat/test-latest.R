library("ropenaq")

#################################################################################################
context("latest")
#################################################################################################
test_that("latest returns a list of 3 data.frames (tbl_df)", {
  skip_on_cran()
  output <- aq_latest(page = 1, limit = 100)
  expect_that(output, is_a("tbl_df"))
  expect_that(attr(output, "meta"), is_a("tbl_df"))
  expect_that(attr(output, "timestamp"), is_a("tbl_df"))
  expect_that(aq_latest(page = 1, latitude = 0, longitude = 0, radius = 10000000, limit = 100),
              is_a("tbl_df"))
  expect_that(aq_latest(page = 1, latitude = 0, longitude = 0, limit = 100),
              is_a("tbl_df"))
})

test_that("latest has the right columns", {
  skip_on_cran()
  output <- aq_latest(page = 1, limit = 10)
  tableRes <- output
  expect_true(all(names(tableRes) %in% c("location",
                                       "city",
                                       "country",
                                       "latitude",
                                       "longitude",
                                       "parameter",
                                        "value",
                                       "lastUpdated",
                                       "unit",
                                       "sourceName",
                                       "cityURL",
                                       "locationURL",
                                       "averagingPeriod_unit",
                                       "averagingPeriod_value")))
  expect_true(class(tableRes$location) == "character")
  expect_true(class(tableRes$parameter) == "character")
  expect_true(class(tableRes$value) == "numeric")
  expect_true(class(tableRes$unit) == "character")
  expect_true(class(tableRes$country) == "character")
  expect_true(class(tableRes$city) == "character")
  expect_true(class(tableRes$cityURL) == "character")
  expect_true(class(tableRes$locationURL) == "character")
  expect_true(class(tableRes$lastUpdated)[1] == "POSIXct")
  expect_true(class(tableRes$longitude) == "numeric" |
                class(tableRes$longitude) == "logical")
  expect_true(class(tableRes$latitude) == "numeric" |
                class(tableRes$latitude) == "logical")
  meta <- attr(output, "meta")
  expect_true(all(names(meta) == c("name", "license",
                                   "website", "page",
                                   "limit", "found")))
  expect_is(attr(output, "timestamp")$queriedAt, "POSIXt")
})



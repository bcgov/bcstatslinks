# Copyright 2025 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

library(testthat)
library(mockery)
library(shiny)
library(bcstatslinks)

# ---- Tests for load_link_csv ----

test_that("load_link_csv returns a data frame with correct columns", {
  df <- load_link_csv()
  testthat::expect_s3_class(df, "data.frame")
  testthat::expect_true(all(c("name", "url") %in% names(df)))
})

test_that("load_link_csv returns NULL on error", {
  mock_read_csv <- mockery::mock(stop("Simulated error"))
  mockery::stub(load_link_csv, "readr::read_csv", mock_read_csv)
  testthat::expect_warning(
    testthat::expect_null(load_link_csv()),
    "Failed to load link list from GitHub")
})

test_that("load_link_csv returns NULL if csv is missing required column names", {
  malformed_csv <- data.frame(name = "table with name column only")
  mock_read_csv <- mockery::mock(malformed_csv)
  mockery::stub(load_link_csv, "readr::read_csv", mock_read_csv)
  testthat::expect_warning(
    testthat::expect_null(load_link_csv()),
    "Failed to load link list from GitHub")
})

# ---- Tests for linkModUI ----

test_that("linkModUI returns a shiny tagList", {
  ui <- linkModUI("test")
  testthat::expect_true(inherits(ui, "shiny.tag.list"))
})

# ---- Tests for linkModServer ----

test_that("linkModServer renders dropdown with fallback message when CSV is NULL", {
  mock_loader <- mockery::mock(NULL)
  mockery::stub(linkModServer, "load_link_csv", mock_loader)

  shiny::testServer(linkModServer, args = list(id = "test"), {
    output_ui <- output$linkList$html
    testthat::expect_true(grepl("select", output_ui))
    testthat::expect_true(grepl("Links are currently unavailable", as.character(output_ui)))
  })
})

test_that("linkModServer renders dropdown when CSV is valid", {
  mock_data <- data.frame(
    name = c("Dashboard A", "Dashboard B"),
    url = c("https://example.com/a", "https://example.com/b")
  )
  mock_loader <- mockery::mock(mock_data)
  mockery::stub(linkModServer, "load_link_csv", mock_loader)

  shiny::testServer(linkModServer, args = list(id = "test"), {
    output_ui <- output$linkList$html
    testthat::expect_true(grepl("select", output_ui))
    testthat::expect_true(grepl("Dashboard A", output_ui))
  })
})

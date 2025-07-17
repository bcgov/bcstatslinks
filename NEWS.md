# bcstatslinks 0.1.0

## Improvements
* Added improved error handling for missing external CSV file.
  * Introduced a new helper function `load_link_csv()` that wraps CSV loading in a `tryCatch()` block.
  * Updated `linkModServer()` to handle `NULL` results from `load_link_csv()` gracefully using `ifelse()` logic.

## Testing
* Added unit tests to improve test coverage and ensure robustness of new error handling logic.



# bcstatslinks 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.

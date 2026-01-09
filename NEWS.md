# mseptools 0.2.0  

### 1/9/2026  
* added function `get_wqp_data()` to pull data from the Water Quality Portal for only MSEP areas. This is a wrapper function for `dataRetrieval::readWQPdata()`.  
* added function `retain_wqp_attributes()` to keep attributes/metadata after using functions that strip away attributes (like `janitor::remove_empty()`). Mostly a helper function for `get_wqp_data()`, but could be useful in other situations.  
* added unit tests for all functions.

# mseptools 0.1.0

### 4/21/2025
* created.

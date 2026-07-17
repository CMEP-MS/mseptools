# mseptools 0.3.0

* added `MDEQ_beach_stations` data object with information on 21 MDEQ beach sampling stations, so it will be easier to associate WQX data with the station IDs actually used on the [DEQ beaches website](https://beaches.mdeq.ms.gov/) (which doesn't provide lats and longs but does provide, under 'Historical Data', historical advisory and closure information like start and end dates for each instance).  
* moved tests that call APIs to a `dev` folder, which has been added to `.R/buildignore` so it won't check the API every time I run tests. Will have to run these manually every so often.

# mseptools 0.2.3  

* pkgdown site created: https://cmep-ms.github.io/mseptools/  
* documentation updates  

# mseptools 0.2.2  

* added more tests for plotting and mapping functions

# mseptools 0.2.1  

* modified multiple HUC selection inside `get_wqp_data()`. (after I learned how to bump versions and use git tags.)

# mseptools 0.2.0  

* added function `get_wqp_data()` to pull data from the Water Quality Portal for only MSEP areas. This is a wrapper function for `dataRetrieval::readWQPdata()`.  
* added function `retain_wqp_attributes()` to keep attributes/metadata after using functions that strip away attributes (like `janitor::remove_empty()`). Mostly a helper function for `get_wqp_data()`, but could be useful in other situations.  
* added unit tests for all functions.

# mseptools 0.1.0

* created.

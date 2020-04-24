# world_bank

`world_bank` is an R script to download and format data from the World Bank. It downloads the entire World Bank database and formats the data series you desire in a way that is convenient for cross-country analysis.

### How to use `world_bank`

**Step 1.** Source `1_download.R`. This will download the World Bank dataset and put it in a folder called `world_bank_dataset`. 

**Step 2.** Inside the `metadata` folder you will find a csv file called `wdi_metadata.csv`. This file contains codes and descriptions for every World Bank series. Find the series you want, and copy the codes into the file `2_data_series_to_get.csv`. (See examples included in the file.)

**Step 3.** Source `3_retrieve_series.R`. This will retrieve the series you selected and output the data in the `your_data` folder under the filename `wdi_select.csv`.

**Step 4.** Analyze the data as you see fit.


### Example

`world_bank` is designed to make it easy to plot cross-country data using [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html). In `example.R`, you'll find code to download and format the data to produce the following plot. It shows how carbon emissions per capita grow with energy use. Each line is the path through time of a country.

![Carbon emissions vs energy use per person](https://economicsfromthetopdown.files.wordpress.com/2020/04/energy_carbon_plot.png)







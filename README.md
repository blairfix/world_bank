# world_bank

Here are some scripts that help me work with World Bank data. You can download the whole World Bank database [here](http://databank.worldbank.org/data/download/WDI_csv.zip). The problem with it, though, is that it is in a 'wide' format, which I find difficult to work with. These scripts  download the whole database, select the data that you want, and convert it to long format.

Here's how to use them. In the `get_series.csv` file, enter the codes for the data series that you want to get. (I've included a few series for examples.) Then run the `runall.sh` shell script. The result will be a file called `wdi.csv` containing the data that you want.


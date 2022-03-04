#!/bin/bash

# make raw data dir
mkdir raw
cd ./raw

# download wdi database
wget -O WDI_data.zip http://databank.worldbank.org/data/download/WDI_csv.zip

# unzip
unzip -o WDI_data.zip

# remove zip file
rm WDI_data.zip

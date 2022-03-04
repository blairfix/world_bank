#!/bin/bash

# download wdi data
./1_download.sh

# get the data we want
Rscript 2_format.R

# remove raw data
./3_clean.sh

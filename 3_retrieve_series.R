
library(data.table)
library(here)
library(magrittr)

dir = here()
setwd(dir)

# data codes that you want to get
codes = fread("2_data_series_to_get.csv")

# World Bank data
wd = file.path(dir, "world_bank_dataset")
setwd(wd)
wdi= fread("WDIData.csv", header = F)

# get years
info = wdi[1,] %>% t() %>% as.vector()
y = suppressWarnings( as.numeric(info) ) 
y = y[-c(1:4)]

# keep data for countries only (not regions)
wd = file.path(dir, "metadata")
setwd(wd)
country.only = fread("country_only_codes.csv")
wdi= wdi[V2 %in% country.only$Code]

# find location of series that you want and isolate this data 
series.codes = wdi[,4] %>% t() %>% as.vector()
ids = which(series.codes %in% codes$code)
keep = wdi[ids, ]

# make vectors for country name, country code and year
sub = keep[V4 == codes$code[1]]
n = ncol(sub)-4

country = rep(sub$V1, each = n)
country.code = rep(sub$V2, each = n)
year = rep(y, nrow(sub))

# initialize output data table
output = data.table(country, country.code, year)

# loop over codes you want and format in columns
for(i in 1:nrow(codes)){
  
  # selected code
  s.code = codes$code[i]
  
  # put data for selected code in long format
  sub = keep[V4 == s.code]
  values = sub[, 5:ncol(sub)] 
  long = values %>% t() %>% as.vector() %>% as.numeric()
  
  # make sure there's data
  # if there is, bind it to output data table
  l = nrow(sub)
  
  if(l >0){
    output = cbind(output, long)
  }
  
  # make column names with data code
  name = names(output)
  name = gsub("long", s.code, name)
  names(output) = name
  
}

# order output by country code and year
output = output[order(country.code, year),]

# Export your data
setwd(dir)
dir.create("your_data", showWarnings = F)

wd = file.path(dir, "your_data")
setwd(wd)
fwrite(output, "wdi_select.csv")

# remove raw data 
# comment this out if you want to keep the raw data
setwd(dir)
unlink("world_bank_dataset", recursive = T)


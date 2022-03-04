library(data.table)
library(here)
library(magrittr)

dir = here()
setwd(dir)

# country codes
countries = fread("countries.csv")

# data series we want
series = fread("get_series.csv")

# WDI data
#--------------------------------------------------

# read WDI database 
setwd("./raw")
d = fread("WDIData.csv", header = F)

# get column names
col_names = d[1,] %>% t() %>% as.vector()

# get years from column names
year_vec = as.numeric(col_names) 
year_vec = year_vec[-c(1:4)]

# keep only data for countries
d = d[V2 %in% countries$Code]

# keep only the data for the series we want
series.codes = d[, 4] %>% t() %>% as.vector()
ids = which(series.codes %in% series$code)
d = d[ids, ]

	    
# get list of unique country codes
code_vec = unique(d$V2)

# loop over codes and make long-form data
final = NULL

for(code in code_vec){

    # subset data
    sub = d[V2 == code]

    # make it long form
    sub = t(sub)

    # series codes
    series_codes = sub[4, ] %>% tolower()

    # country
    country = sub[1, 1]

    # get data values
    values = sub[ -1:-4, ]

    # bind data
    output = data.table(
			country = country,
			code = code,
			year = year_vec,
			values
			)

    # name columns
    col_names = c(
		  "country",
		  "code",
		  "year",
		  series_codes
		  )

    names(output) = col_names
	
    # bind final results
    final = rbind(final, output)
}

# remove blank years
final = final[ ! is.na(year) ]

# export
setwd(dir)
fwrite(final, "wdi.csv")


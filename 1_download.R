library(here)
library(data.table)

dir = here()
setwd(dir)

# World Bank download link
wd = file.path(dir, "metadata")
setwd(wd)
url = readLines("link.txt")

# Make raw data directory
setwd(dir)
dir.create("world_bank_dataset", showWarnings = F)

# Download World Bank data
wd = file.path(dir, "world_bank_dataset")
setwd(wd)
download.file(url, "WDI.zip")

unzip("WDI.zip")
unlink("WDI.zip")


# clean metadata and export it for your use
wdi_series = fread("WDISeries.csv")
wdi_keep = data.table(code =  wdi_series$`Series Code`, title = wdi_series$`Indicator Name`)

wd = file.path(dir, "metadata")
setwd(wd)
fwrite(wdi_keep,"wdi_metadata.csv")

setwd(dir)


library(here)
library(ggplot2)
library(gridExtra)
library(ggrepel)

dir = here()
setwd(dir)

# download World Bank data and retrieve data series
source("1_download.R")
source("3_retrieve_series.R")

# read in data
wd = file.path(dir, "your_data")
setwd(wd)
wdi_data = fread("wdi_select.csv")
wdi_data = na.omit(wdi_data)

# make labels
wdi_data = wdi_data[order(EG.USE.PCAP.KG.OE)]
wdi_data$label = wdi_data$country.code

keep = seq(1, nrow(wdi_data), length.out = 20) %>% round()
wdi_data$label[-keep] = ""

# reorder for plot
wdi_data = wdi_data[order(country, year)]

# make ggplot
energy_carbon_plot = ggplot( data = wdi_data ) +
  geom_path(aes(x = EG.USE.PCAP.KG.OE, y = EN.ATM.CO2E.PC, col = country), 
            size = 0.5, alpha = 0.7) +
  geom_text_repel(aes(x = EG.USE.PCAP.KG.OE, y = EN.ATM.CO2E.PC, label = label), 
            size = 2, box.padding = 0.2, segment.color = "grey20") +
  scale_x_log10("Energy use per person\n(kg oil equivalent)") +
  scale_y_log10("Carbon emissions per person\n(metric tons)") +
  coord_cartesian(xlim = c(50, 10^4.5)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = "none",
        text = element_text(size = 10, family="Times"))


# export
setwd(dir)
gA = ggplotGrob(energy_carbon_plot)

png("energy_carbon_plot.png", width = 5, height = 5, units = 'in', res = 300)
grid.arrange(gA)
dev.off()





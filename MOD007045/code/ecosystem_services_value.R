## natural capital; carbon

## https://www.science.org/doi/10.1126/science.1234379?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed

library(readxl); library(sf); library(tidyverse)

tmp <- tempfile()

curl::curl_download("https://www.science.org/doi/suppl/10.1126/science.1234379/suppl_file/1234379.data.zip", tmp)

p <-here::here("~/Dropbox/My Mac (Julians-MBP-2)/Downloads")

data <- read_excel(paste0(p, "/1234379s.xlsx"), sheet = 2)
fields <- read_excel(paste0(p, "/1234379s.xlsx"), sheet = 3)
glimpse(data)

data_sf <- data %>%
  st_as_sf(coords= c(x = "POINT_X", y = "POINT_Y"), crs = 27700)

data_sf %>%
  ggplot() +
  geom_sf(aes(fill = adt_lsl_j, colour = adt_lsl_j), pch = 0, size = 0.05) +
  viridis::scale_fill_viridis(option = "turbo") +
  viridis::scale_color_viridis(option = "turbo") +
  theme_void()




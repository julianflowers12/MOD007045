library(sf); library(ggspatial);library(tidyverse)

h <- here::here("MOD007045/shp")
f <- list.files(h, "shp", full.names = T)

shps <- map(f[3:4], st_read)
shps_tx <- map(shps, st_transform, crs = 27700)

urbn_area <- st_area(shps_tx[[1]][1])
green_area <- st_area(shps_tx[[2]])
green_sum <- sum(green_area)

shps_tx[[2]] %>%
  bind_cols(area = green_area) %>%
  group_by(function.) %>%
  summarise(sum = sum(area),
            tot = green_sum,
            prop = sum/tot,
            prop_urb = 100 * sum / urbn_area,
            n = n(),
            plots = sum / 250,
            mean = sum / n / 10000)

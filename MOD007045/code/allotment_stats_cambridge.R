library(sf); library(ggspatial);library(tidyverse)

h <- here::here("MOD007045/shp")
f <- list.files(h, "shp", full.names = T)

shps <- map(f[1:3], st_read)
shps_tx <- map(shps, st_transform, crs = 27700)

urbn_area <- st_area(shps_tx[[3]]) %>%
  cbind(., shps_tx[[3]]) %>%
  mutate(area = as.numeric(.))

urbn_area %>%
  group_by(function.) %>%
  summarise(area_sum = sum(area) / 10000)

ggplot(shps_tx[[2]]) +
  ggspatial::annotation_map_tile() +
  geom_sf(fill = "darkgreen") +
  coord_sf() +
  theme_void()


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

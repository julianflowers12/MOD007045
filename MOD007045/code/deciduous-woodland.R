### deciduous woodland

library(pacman)
p_load(tidyverse, sf, readxl, here)

h <- here::here("MOD007045/shp")

f <- list.files(h, "shp", full.names = T)

dw <- st_read(f[6])

dw

dw %>%
  ggplot() +
  ggspatial::annotation_map_tile() +
  geom_sf()



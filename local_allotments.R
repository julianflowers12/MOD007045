## local allotments

library(pacman)
p_load(sf, tidyverse, ggspatial)

path <- here::here("MOD007045/shp")
files <- list.files(path, "shp", full.names = TRUE)

gs <- st_read(files[2])

gs %>%
  st_transform(crs = 4326) %>%
  mutate(gs = ifelse(is.na(name), "Allotment", "Development")) %>%
  ggplot() +
  annotation_map_tile(zoomin = -1) +
  annotation_north_arrow(location = "tr") +
  annotation_scale(location = "br") +
  geom_sf(aes(fill = gs)) +
  scale_fill_manual(values = c("darkgreen", "blue"), name = NULL) +
  #coord_sf(crs = 27700) +
  labs(caption = "Source: OS Greenspace Mapping") +
  theme_void()

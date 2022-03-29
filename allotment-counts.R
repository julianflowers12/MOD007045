## allotment stats

library(pacman)
p_load(sf, tidyverse, ggspatial)

rosm::osm.types()

path <- here::here("MOD007045/data/Cherry Hinton CP/data/TL")
files <- list.files(path, "shp", full.names = TRUE)

path1 <- here::here("MOD007045/shp")
files1 <- list.files(path1, "shp", full.names = TRUE)

site <- st_read(files1[6]) %>%
  st_transform(crs = 4326)


greenspace <- map_dfr(files1[6], st_read) %>%
  st_transform(crs = 4326)
joined <- st_union(greenspace, site)

total_area <- greenspace %>%
  st_area() %>%
  bind_cols(., greenspace)

total_area %>%
  group_by(Category = priFunc) %>%
  summarise(`Area (hectares)` = round(as.numeric(sum(...1))/10000, 1) ) %>%
  mutate(`prop (% total area)` = round(100 * `Area (hectares)` / sum(`Area (hectares)`), 1)) %>%
  gt::gt()

total_greensp_area <- as.numeric(sum(total_area$...1) / 10000)

total_area

allot <- greenspace %>%
  filter(str_detect(priFunc, "Allot"))

allot %>%
  ggplot() +
  annotation_map_tile(zoomin = -1, type = "osm") +
  annotation_north_arrow(location = "tr") +
  annotation_scale(location = "br") +
  geom_sf(fill = "blue") +
  geom_sf(data = site, fill = "red") +
  coord_sf() +
  theme_void()

allot_area <- st_area(allot) %>%
  tibble() %>%
  set_names("area")

allot <- allot %>%
  bind_cols(allot_area)

g <- allot %>%
  mutate(area = log(as.numeric(area)),
         ha = ifelse(area > 10000, 1, 0))

g %>%
  ggplot() +
  geom_histogram(aes(area)) +
  geom_vline(xintercept = mean)

mean <- log(as.numeric(mean(allot$area)))

g +
  geom_vline(xintercept = mean)


sum(st_area(allot))/10000
median(st_area(allot))



range(allot_area)

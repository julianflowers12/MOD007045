## bryophytes
library(ggspatial)
mosses <- read_csv(glue(here(), "/data/records-2022-02-17_bryophytes.csv"), show_col_types = FALSE)

mosses %>%
  janitor::clean_names() %>%
  filter(str_detect(scientific_name, "Tortula vahliana")) %>%
  dplyr::select(start_date, locality, latitude_wgs84, longitude_wgs84) %>%
  st_as_sf(coords = c("longitude_wgs84", "latitude_wgs84"), crs = 4326) %>%
  ggplot() +
  annotation_map_tile(zoomin = 0) +
  geom_sf() +
  coord_sf()

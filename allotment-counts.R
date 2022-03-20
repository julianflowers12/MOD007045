## allotment stats

library(pacman)
p_load(sf, tidyverse, ggspatial)

path <- here::here("MOD007045/data/Cherry Hinton CP/data")
files <- list.files(path, "shp", full.names = TRUE)

greenspace <- st_read(files[2])

allot <- greenspace %>%
  filter(str_detect(function., "Allot"))

sum(st_area(allot))/10000

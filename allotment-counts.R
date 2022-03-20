## allotment stats

library(pacman)
p_load(sf, tidyverse, ggspatial)

path <- here::here("MOD007045/data/Cherry Hinton CP/data")
files <- list.files(path, "shp", full.names = TRUE)

greenspace <- st_read(files[2])

total_area <- greenspace %>%
  st_area() %>%
  bind_cols(., greenspace)

total_area %>%
  group_by(function.) %>%
  summarise(tot_area = sum(...1)) %>%
  mutate(prop = 100 * tot_area / sum(tot_area))

total_area

allot <- greenspace %>%
  filter(str_detect(function., "Allot"))

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

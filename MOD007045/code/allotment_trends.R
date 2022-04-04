## allotment data from https://allotments.net/2021/12/18/updated-survey-of-cambridge-allotments/

data <- data.frame(
  name = c("Wenvoe", "Blacklands", "Burnside", "Perne",
           "Fairfax", "Baldock", "Peverel", "Holbrook",
           "Elfreda", "Fanshawe", "Pakenham", "Vinery",
           "Hawthorn", "Stourbridge", "Maple", "Auckland",
           "Clay", "Glebe Farm", "Nuffield", "Trumpington",
           "Bateson", "Kendal", "Histon", "Fulbrooke",
           "Empty", "New", "Victoria", "Nine Wells", "Foster"),
  size_ha = c(0.69, 2.17, 3.3, 0.66, 1.64, 1.5, 0.5, 2.31, 4.13,
              .58, 4.86, 1.44, .17, 3.44, .06, .29, 1.5, .27, 2.23,
              .9, .13, .24, 5.76, .136, 1.31, .49, .23, .32, 1.63),
  plots = c(20, 64, 103, 23, 66, 56, 16, 86, 135, 29, 174,
            47, 5, 113, 2, 12, 44, 8, 77, 18, 4, 10, 194, 4, 41, 18, 18, 9, 55),
  tenants = c(41, 92, 122, 24,
              78, 85, 17, 105,
              126, 45, 274, 63,
              14, 124, 5, 29,
              151, 27, 132, 63,
              15, 32, 210, 30,
              102, 42, 35, 32, 96),
  waiting = c(30, 7, 39, 5,
              21, 22, 1, 13,
              6, 107, 28, 46,
              69, 6, 32, 41,
              40, 17, 13, 26,
              79, 50, 47, 7,
              163, 16, 25, 11, 151),
  tenant_2009 = c(25, 87, 88, 24,
                  53, 61, 16, 81,
                  126, 26, 165, 26,
                  8, 108, 3, 15,
                  0, 0, 77, 0,
                  4, 5, 202, 21,
                  48, 21, 26, 0, 87 ),
  waiting_2009 = c(15, 12, 3, 10,
                   40, 11, 2, 15,
                   6, 12, 70, 4,
                   7, 4, 8, 51,
                   0, 0, 36, 0,
                   4, 5, 31, 2,
                   67, 44, 10, 0, 25),
  size_2019 = c(.7, 2.17, 3.3, .66,
                1.64, 1.5, .5, 2.31,
                4, .58, 4.86, 1.44,
                .17, 3.44, .06, .29,
                0, 0, 2.23, 0,
                .13, .1, 5.76, .136,
                1.31, .49, .4, 0, 1.63),
  plots_2009 = c(17, 72, 98, 23,
                 61, 56, 16, 85.5,
                 126, 29, 180, 47,
                 5, 109.5, 2, 12,
                 0,0, 77, 0,
                 4, 3, 191.5, 5.5,
                 47, 18, 16, 0, 49.25)
)

data <- data %>%
  mutate(p_ha = plots / size_ha,
         t_ha = tenants / size_ha,
         t_plot = tenants / plots,
         w_plot = waiting / plots,
         new_old = tenants / tenant_2009) %>%
  arrange(name)

data

data %>%
  ggplot() +
  geom_density(aes(t_ha))

data %>%
  mutate_at(.vars = 2:ncol(.), as.numeric) %>%
  .[,2:5] %>%
  map_dbl(.,sum)


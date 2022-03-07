## cherry hinton landscape areas
library(tidyverse)

areas <- data.frame(
  habitat = c("Broadleaf wood",
              "Dense Scrub",
              "Scattered scrub",
              "Semi-improved grassland",
              "Calcareous grassland"),
  Area_m2 = c(34631,
                      10600,
                      8853,
                      3140,
                      52000)
) %>%
  mutate(hectares = Area_m2/ 10000 / sum(Area_m2/ 10000))


areas %>% ggplot(aes(reorder(habitat, hectares), 100 * hectares)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(y = "Percentage of survey site (%)",
       x = "",
       title = "Distribution of habitat types at Cherry Hinton Chalk Pits") +
  theme_minimal() +
  theme(plot.title.position = "plot")


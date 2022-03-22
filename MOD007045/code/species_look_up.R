library(taxize); library(tidyverse)

species_list <- c("cornflower", "moon carrot", "great pignut", 
                  "white helleborine", "basil thyme", "chalk eyebright", 
                  "candytuft", "early marsh orchid", "kidney vetch", 
                  "wild thyme", "upright brome", "yellow-wort", "perennial flax")

scientific_names <- taxize::comm2sci(com = species_list, db = 'itis')

scientific_names %>%
  enframe() %>%
  unnest("value") %>%
  slice(c(9, 94, 95, 97, 122))

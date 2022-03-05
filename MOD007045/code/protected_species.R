## protected bird species

library(myScrapers); library(tidyverse); library(rvest)

url <- "https://www.bto.org/our-science/projects/ringing/taking-part/protected-birds/s1-list"

bto <- read_html(url) %>%
  html_table()

bto_text <- get_page_text(url)

bt <- bto_text %>%
  enframe() %>%
  slice(c(1, 3))

bto[[1]] %>%
  select(1:2) %>%
  mutate(len = str_length(Species)) %>%
  filter(len != 1) %>%
  knitr::kable()

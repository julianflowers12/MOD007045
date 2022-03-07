## priority landscapes/ habitats

library(rvest)
url <- "https://jncc.gov.uk/our-work/uk-bap-priority-habitats/#list-of-uk-bap-priority-habitats"


habitats <- read_html(url) %>%
  html_table()

habitats <- habitats[[1]]

colnames(habitats) <- habitats %>% slice(1)
habitats <- habitats %>% slice(-1)

habitats %>%
  gt::gt()


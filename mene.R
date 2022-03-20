## mene survey

library(myScrapers)
url <- "http://publications.naturalengland.org.uk/publication/5102691145744384"

xls <- get_page_links(url)
xls <- xls %>%
  .[grepl("file", .)] %>%
  enframe() %>%
  mutate(link = map(value, ~(paste0("http://publications.naturalengland.org.uk/", .x))))

xls %>%
  unnest("link") %>%
  .[1,]

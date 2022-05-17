## POST articles on environmnental issues

library(myScrapers); library(rvest); library(tidyverse)

post <- "https://post.parliament.uk/topic/environment/"
posts <- paste0(post, "page/", 2:16, "/")

post_list <- c(post, posts)



post_titles <- function(url){
  read_html(url) %>%
  html_node(".component") %>%
  html_text()
}

db1 <- purrr::map(post_list, post_titles) %>%
  str_squish() %>%
  enframe()

db1 %>%
  mutate(title = str_extract_all(value, "^POSTnote.*\\d{2}.*\\d{4}$")) %>%
  unnest("title")

%>%
  select(name, title)

## webscraping conservation evidence

library(myScrapers); library(tidyverse); library(rvest)

url <- "https://conservationevidence.com/actions/"

urls <- paste0(url, 1:2700)

links <- get_page_links(urls[2])

links

get_effectiveness <- function(url){
  url %>%
  read_html() %>%
  html_nodes(".align-items-start") %>%
  html_text() %>%
  str_squish()

}

get_assessment <- function(url){
  get_effectiveness(url) %>%
  str_remove(. , "Overall effectiveness category") %>%
  str_remove(., "Share Tweet Icons/envelope Email") %>%
  str_remove(., "Number.+")
}

get_assessment(urls[2])

get_no_studies <- function(url){
  get_effectiveness(url) %>%
    str_remove(., "Share Tweet Icons/envelope Email") %>%
    str_extract(., "Number.+")
}

get_no_studies(urls[2])

get_action <- function(url){

  require(myScrapers)
  require(stringr)
  assessment <- get_assessment(url)
  studies <- get_no_studies(url)
  links <- get_page_links(url)
  links1 <- links[c(12:13)]
  links2 <- links %>%
   .[grep("/journalsearcher/synopsis#", .)]
  action <- links1[2] %>%
    str_remove(., "&body.+")
  action <- action %>%
    str_remove(., "mailto:\\?subject=")
  taxon <- links2 %>%
    str_remove(., "/journalsearcher/synopsis#")
  out = data.frame(taxon = taxon,
                   action = action,
                   assessment = assessment,
                   no_studies = studies
             )

}

t1 <- get_action(urls[4])




db_100 <- purrr::map(urls[1:500], possibly(get_action, otherwise = NA_real_))
db_200 <- purrr::map(urls[501:1000], possibly(get_action, otherwise = NA_real_))
db_300 <- purrr::map(urls[1001:1500], possibly(get_action, otherwise = NA_real_))
db_400 <- purrr::map(urls[1501:2000], possibly(get_action, otherwise = NA_real_))
db_500 <- purrr::map(urls[2001:2500], possibly(get_action, otherwise = NA_real_))
db_600 <- purrr::map(urls[2500:2600], possibly(get_action, otherwise = NA_real_))

db_100[!is.na(db_100)]

db_list <- list(db_100, db_200, db_300, db_400, db_500, db_600)

db_na <- map(db_list, ~.x[!is.na(.x)])

evidence_db <- map_dfr(db_na, bind_rows)



beneficical_interventions <- evidence_db %>%
  #filter(str_detect(assessment, "[Bb]enefi")) %>%
  reactable::reactable(sortable = TRUE, searchable = TRUE, filterable = TRUE,
                       defaultPageSize = 50, paginationType = "jump",
                       resizable = TRUE, compact = TRUE, selection = "multiple"
                        )

beneficical_interventions

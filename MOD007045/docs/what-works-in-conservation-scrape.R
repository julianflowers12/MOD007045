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

evidence_db %>% write_rds("evidence.rds")

evidence_db %>%
  mutate(action = tolower(action)) %>%
  full_join(threats1, by = c("action" = "intervention")) %>%
  write_rds("evidence.rds")

str(evidence_db)

evidence %>%
  DT::datatable(filter = "top", options = list(pageLength = 25))




beneficical_interventions <- evidence_db %>%
  #filter(str_detect(assessment, "[Bb]enefi")) %>%
  reactable::reactable(sortable = TRUE, searchable = TRUE, filterable = TRUE,
                       defaultPageSize = 50, paginationType = "jump",
                       resizable = TRUE, compact = TRUE, selection = "multiple"
                        )

beneficical_interventions


#######################

ci <- read_csv("~/Dropbox/Mac (2)/Desktop/MOD007045/conservation_interventions.csv")

evidence_db %>%
  mutate_all(tolower) %>%
  filter(str_detect(taxon, "mammal"))

ci %>%
  reactable::reactable(sortable = TRUE, searchable = TRUE, filterable = TRUE,
                       defaultPageSize = 50, paginationType = "jump",
                       resizable = TRUE, compact = TRUE, selection = "multiple"
  )

########################
library(myScrapers)
cs <- "https://www.gov.uk/countryside-stewardship-grants/"

cs_links <- get_page_links(cs) %>%
  enframe() %>%
  filter(str_detect(value, "^/countryside-steward")) %>%
  mutate(text = paste0("https://www.gov.uk",  value),
         text1 = map(text, get_page_text))
cs_links %>%
  unnest("text1") %>%
  select(-value) %>%
  filter(!str_detect(text1, "cookie")) %>%
 filter(!str_detect(text1, "^\\\n")) %>%
  filter(!str_detect(text1, "^Depart")) %>%
  filter(!str_detect(text1, "^News")) %>%
  filter(!str_detect(text1, "^Detailed")) %>%
  filter(!str_detect(text1, "^Reports")) %>%
  filter(!str_detect(text1, "^Consult")) %>%
  filter(!str_detect(text1, "^Data,")) %>%
  filter(!str_detect(text1, "^Find out ")) %>%
  mutate(text = str_remove(text, "https://www.gov.uk/countryside-stewardship-grants/"))







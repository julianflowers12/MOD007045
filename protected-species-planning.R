### protected species surveys
#<https://www.gov.uk/guidance/protected-species-how-to-review-planning-applications>
library(myScrapers);library(rvest)

url <- "https://www.gov.uk/guidance/protected-species-how-to-review-planning-applications"


url %>%
  read_html() %>%
  html_table()

planning_advice <- url %>%
  get_page_links() %>%
  .[grepl("advice-for-making",.)] %>%
  .[grepl("^https", .)] %>%
  enframe()

planning_advice_text <- planning_advice %>%
  mutate(text = map(value, get_page_text)) %>%
  unnest("text") %>%
  group_by(name) %>%
  slice(-c(1:12)) %>%
  mutate(species = str_remove(value, "https://www.gov.uk/guidance/"))

protected_species_survey <- planning_advice %>%
  mutate(on_links = map(value, get_page_links)) %>%
  unnest("on_links") %>%
  group_by(name) %>%
  slice(-c(1:39)) %>%
  mutate(species = str_remove(value, "https://www.gov.uk/guidance/")) %>%
  filter(str_detect(on_links, "survey"))

survey_docs_cieem <- protected_species_survey$on_links[3] %>%   # chartered institute of ecology and environment management
  get_page_docs() %>%
  map(., readtext::readtext)



## Bats

bats <- "https://www.gov.uk/guidance/bats-advice-for-making-planning-decisions"
bat_survey <- "https://www.bats.org.uk/resources/guidance-for-professionals/bat-surveys-for-professional-ecologists-good-practice-guidelines-3rd-edition"

get_page_text(bats)
get_page_text(bat_survey)


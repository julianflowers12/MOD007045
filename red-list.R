## bocc 5

library(readtext); library(pdftools);library(tabulizer); library(rJava); library(tidytext)
library(readxl)

jncc <- "https://hub.jncc.gov.uk/assets/478f7160-967b-4366-acdf-8941fd33850b"

red_list <- tempfile()
red_list_jncc <- curl::curl_download("https://data.jncc.gov.uk/data/478f7160-967b-4366-acdf-8941fd33850b/consolidated-red-list-extract-20220202.xlsx", red_list)

red_list_jncc <- red_list_jncc %>%
  read_excel(sheet = 2) %>%
  janitor::clean_names()

survey_data <- read_csv(paste0(here(), "/data/records-2022-02-17.csv"), show_col_types = FALSE) %>%
  janitor::clean_names()

survey_full <- survey_data %>%
  left_join(red_list_jncc, by = c("species_id_tvk" = "recommended_taxon_version_key"))

pdf <- "https://britishbirds.co.uk/sites/default/files/BB_Dec21-BoCC5-IUCN2.pdf"

pdftools::pdf_text(pdf) %>%
  map(., str_squish)

pdftools::pdf_data(pdf)

rt <- readtext(pdf)

bocc_list <- rt$text %>%
  str_split(., "\n")

bocc_words <- bocc_list[[1]][560:903] %>%
  str_squish() %>%
  data.frame() %>%
  janitor::clean_names() %>%
  janitor::remove_empty("rows") %>%
  unnest_tokens(word, x, "words")

bocc_words %>%
  #count(word, sort = TRUE) %>%
  filter(!str_detect(word, "\\d.*")) %>%
  #anti_join(stop_words) %>%
  #head(40)
  filter(!word %in% c("hdrec", "bdmp1", "br", "lc", "n", "vu", "en", "nt", "a2b", "cr", "d", "a4b", "bdp1", "ii",
                      "erlob", "bdp2", "wr", "bl", "wi", "wl", "ne", "3c", "w", "e", "hd", "vuo", "cont", "iucn", "british",
                      "birds", "december", "eno", "populations", "our", "bird", "the", "status", "of", "bi", "and",
                      "stanbury", "table", "et", "al", "mto", "nto", "iv")) %>%
  mutate(len = ifelse(nchar(word) == 1, "iucn", "sp")) %>%
  group_by(len) %>%
  mutate(id1 = ifelse(len == "iucn", seq(from = 1, to = 4, by = 1),  0),
         id3 = ifelse(len == "sp", seq(from = 1, to = 4, by = 1),  0)) %>%
  ungroup() %>%
  mutate(id2 = lag(id1)) %>%
  mutate(len = ifelse(id2 == 4, "iucn", len),
         w = ifelse(id1 > 0 | id2 > 0, word, "") ) %>%
  drop_na() %>%
  select(!contains("id2")) %>%
  mutate(id1 = ifelse(nchar(w) > 1, 5, id1),
         word = ifelse(word == w, NA, word)) %>%
  View()




  %>%
  fill(word) %>%
  filter(id1 > 3) %>%
  mutate(w1 = lag(w)) %>%
  filter(w == "g", w1 == "red") %>%
  left_join(bocc_words) %>%
  View()

%>%
  filter(id1 == 4 & w == "g", id1 == 5 & w == "red")
  head(20)



%>%



  pivot_wider(names_from = "len", values_from =  "w", ) %>%
  unnest_auto("word")




%>%
)
  View()
  mutate(l = ifelse(len == max(id), 0, 1))

%>%
  group_by(len) %>%
  ungroup() %>%
  mutate(id1 = lag(word)) %>%
  mutate(l = paste(len, word))

  separate(x, remove = T, c("common", "scientific", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e"), sep = " ")


%>%
  str_squish()
  head() %>%
  dim()
  enframe() %>%
  mutate(value = str_squish(value))

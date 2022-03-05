### TL45 taxon list from https://database.bsbi.org/reports/sitetaxa.php?gridref=TL45X&minfreq=0&minyear=2010&maxyear=2020&sortrecent=1

library(myScrapers); library(rvest);library(tidyverse);library(tidytext);library(quanteda)

url <- "https://database.bsbi.org/reports/sitetaxa.php?gridref=TL45X&minfreq=0&minyear=2010&maxyear=2021"

taxon_list <- read_html(url) %>%
  html_nodes("section") %>%
  html_text()


dt_tok <- tokens(taxon_list) %>%
  unlist() %>%
  enframe() %>%
  data.table::setDT() %>%
  filter(value != "(", value != ")") %>%
  mutate(val = parse_number(value),
         val1 = str_remove(value, "\\d{1,}")) %>%
  slice(-c(2124:2126)) %>%
  mutate(type = ifelse(str_detect(val,"\\d{4}"),  "year",
                       ifelse(nchar(val1) > 0|is.na(val) , "species", "count")
                          ),
         type = ifelse(is.na(type), "species", type))  %>%
  pivot_wider(names_from = "type", values_from = "value") %>%
  rename(sp = val1) %>%
  fill(year, .direction = "up") %>%
  mutate(count = ifelse(is.na(count) & !str_detect(val, "\\d{4}"), val, count),
         sp = str_remove(sp, " \\sx")) %>%
  select(name, sp, count, year) %>%
  filter(!sp %in% c("s.s.", "agg", "s.l.", "s.s", "s.l", ".", "agg.", "x")) %>%
  mutate(count1 = lead(count, 3)) %>%
  select(-count) %>%
  filter(!is.na(count1)) %>%
  #View()%>%
  mutate(first = str_detect(sp, "^[:upper:]")|str_detect(sp, "^\\.")) %>%
  group_by(first) %>%
  mutate(id = row_number()) %>%
  group_by(id) %>%
  mutate(species = paste(sp, collapse = " "),
         count1 = as.numeric(count1)) %>%
  pivot_wider(names_from = c("first"),  values_from = "sp") %>%
  pivot_wider(names_from = "year", values_from = "count1", values_fill = 0) %>%
  select(id:species, `2010`, `2011`, `2012`, `2013`, `2014`, `2015`, `2016`, `2017`, `2018`, `2019`, `2020`, `2021`)


%>%
  reactable::reactable(searchable = TRUE, sortable = TRUE)

  dt_tok[] %>%
    tail(20)



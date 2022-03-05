### what works in conservation

library(pacman)
p_load(tidyverse, readtext, pdftools, myScrapers, tidytext, quanteda, here)

here()

path <- glue::glue(here(), "/MOD007045/docs/")

pdfs <- list.files(path, ".pdf", full.names = T)

wwic <- pdfs[4]

wwic_t <- readtext(wwic)

wwic_t$text

assessment <- kwic(corpus(wwic_t, text_field = "text"), pattern = "assessment", window = 20)

assessment <- data.table::setDT(assessment)

assessment %>%
  reactable::reactable(searchable = TRUE, filterable = TRUE, sortable = TRUE)

s <- wwic_t %>%
  unnest_tokens(sent, text, "sentences") %>%
  mutate(sent = str_squish(sent))

threats <- s %>%
  filter(str_detect(sent, "threat: residential") ) %>%
  mutate(split = str_split(sent, pattern = "\\\b")) %>%
  unnest("split") %>%
  select(-sent) %>%
  mutate(split = str_remove(split, "^\\d{1,}"),
         threat = str_extract(split, "\\d\\.\\d threat.*"),
         conservation = ifelse(str_detect(split, "conservation$"), word(split, -2), NA),
         threat = ifelse(nchar(threat) > 1, threat, NA),
         conservation = ifelse(nchar(conservation) > 1, conservation, NA)) %>%
  fill(threat, .direction = "down") %>%
  fill(conservation)

threats %>%
  dplyr::select(target = conservation, threat, intervention = split)%>%
  mutate(intervention = str_squish(intervention)) %>%
  filter(threat != intervention) %>%
  mutate(intervention = str_remove(intervention, "\\d{1,}\\.\\d{1,}\\.\\d{1,}\\s")) %>%
  write_csv("conservation_interventions.csv")









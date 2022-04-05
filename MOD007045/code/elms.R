## environmental land management schemes

library(quanteda)

elms <- "https://www.gov.uk/government/publications/environmental-land-management-schemes-outcomes/environmental-land-management-schemes-outcomes"

elms_targets <- myScrapers::get_page_text(elms) %>%
  .[19:34] %>%
  paste(., collapse = " ")



corpus(elms_targets) %>%
  kwic(., phrase("We will"), window = 10)

corpus(elms_targets) %>%
  kwic(., phrase("Local nature"), window = 15)


corpus(elms_targets) %>%
  kwic(., phrase("Landscape recovery"), window = 15)

corpus(elms_targets) %>%
  kwic(., phrase("Sustainable"), window = 15)

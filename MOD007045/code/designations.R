library(readxl)
master_list <- tempfile()
curl::curl_download("https://data.jncc.gov.uk/data/478f7160-967b-4366-acdf-8941fd33850b/Taxon-designations-20220202.xlsx", master_list)


ml <- read_excel(master_list, sheet = 2, skip = 1) %>%
  janitor::clean_names()

ml_counts <- ml %>%
  #glimpse()
  count(reporting_category, designation)

ml_counts %>%
  DT::datatable()

ml %>%
  filter(reporting_category == "The Conservation of Habitats and Species Regulations 2010") %>%
  gt::gt()

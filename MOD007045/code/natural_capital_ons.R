### oms natural capital

library(rvest); library(tidyverse); library(myScrapers)

url <- "https://www.ons.gov.uk/economy/environmentalaccounts/methodologies/naturalcapital"

get_page_links(url)

nc_2021 <- "https://www.ons.gov.uk/economy/environmentalaccounts/bulletins/uknaturalcapitalaccounts/2021"

p_text <- get_page_text(nc_2021)

key_points <- p_text %>%
  .[c(12:29)]


library(readxl)
nc_data <- tempfile()
curl::curl_download("https://www.ons.gov.uk/file?uri=%2feconomy%2fenvironmentalaccounts%2fdatasets%2fuknaturalcapitalaccounts2020%2f2021/uknaturalcapitalaccounts2021summary.xlsx", nc_data)

excel_sheets(nc_data)

read_excel(nc_data, sheet = 2, skip = 3)  %>%
  slice(-1) %>%
  mutate_at(.vars = 3:ncol(.), as.numeric) %>%
  pivot_longer(names_to = "year",
               values_to = "vals",
               cols = 3:ncol(.)) %>%
  ggplot(aes(year, vals, colour = ...1, group = 1)) +
  geom_line()

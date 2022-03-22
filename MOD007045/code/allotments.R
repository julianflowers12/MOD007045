library(myScrapers)

search <- "allotments (biodiversity OR ecosystem services)"
key <- Sys.getenv("ncbi_key")

end <- 2022
start <- 2000

out <- pubmedAbstractR(search = search, start = start, end = end, ncbi_key = key)

out$abstracts$title

all_ss <- myScrapers::get_ss_data(search = search)

all_ss$data$title

all_ss$data[c(1, 5, 22, 32, 37, 45, 49, 59, 58, 63, 66, 70, 77, 79, 85, 90),] %>%
  View()

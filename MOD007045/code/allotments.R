library(myScrapers)

search <- "food desert[tw] OR food bank[tw]"
key <- Sys.getenv("ncbi_key")

end <- 2022
start <- 2000

out <- pubmedAbstractR(search = search, start = start, end = end, ncbi_key = key)

out$abstracts$title

all_ss <- myScrapers::get_ss_data(search = search)

all_ss$data$title

all_ss$data[c(5, 17, ),] %>%
  View()

#### climate change

library(readtext)

cccs <- readtext("https://www.cambridge.gov.uk/media/9581/climate-change-strategy-2021-2026.pdf")


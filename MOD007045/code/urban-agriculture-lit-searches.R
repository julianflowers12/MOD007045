## srs of urban agriculture and well being, fv consumption

library(myScrapers)

search <- "(urban agriculture OR community garden OR allotment) systematic[sb]"
search_covid <- "(urban agriculture OR community garden OR allotment) covid"
search_biodiversity <- "(urban agriculture[tw] OR community garden*[tw] OR allotment) ecosystem service*[tw]"

start <- 2000
end <- 2022
ncbi_key <- Sys.getenv("ncbi_key")


res <- pubmedAbstractR(search = search, end = end, start = start, ncbi_key = ncbi_key)

res$abstracts %>%
 .[c(8, 9, 12, 16, 19, 21, 26, 29, 32, 40, 55), ] %>%
  pluck(., "pmid")



res_covid <- pubmedAbstractR(search = search_covid, end = end, start = start, ncbi_key = ncbi_key)

res_covid$abstracts %>%
  .[c(19, 24, 31, 32, 36, 49, 86, 120, 126 ),] %>%
  pluck(., "pmid")


res_bd <- pubmedAbstractR(search = search_biodiversity, end = end, start = start, ncbi_key = ncbi_key)

res_bd$search
res_bd$abstracts %>%
  DT::datatable(selection = TRUE, filter = "top")

%>%
  .[c(19, 24, 31, 32, 36, 49, 86, 120, 126 ),] %>%
  pluck(., "pmid")

## microplastics and human health

library(myScrapers); library(europepmc); library(tidypmc)

search <- "plasticenta"

n <- 13
start <- 2000
end <- 2022

key <- Sys.getenv("ncbi_key")

res <- pubmedAbstractR(search = search, n = n, start = start, end = end, ncbi_key = key)

res$abstracts$abstract

pmc <- pluck(res$abstracts, "pmid")
pmc <- map(pmc, epmc_details) %>%
  map(., "basic")

glimpse(pmc)


search1 <- "plastic pollution health human[mh] review[pt ]"

n <- 146
start <- 2000
end <- 2022

key <- Sys.getenv("ncbi_key")

res1 <- pubmedAbstractR(search = search1, n = n, start = start, end = end, ncbi_key = key)

abs <- res1$abstracts

anno <- myScrapers::annotate_abstracts(abs$abstract, abs$pmid)
np <- myScrapers::abstract_nounphrases(anno)

glimpse(np)

np %>%
  drop_na(term) %>%
  group_by(doc_id) %>%
    summarise(term = paste(term, collapse = ", ")) %>%
  left_join(abs, by = c("doc_id" = "pmid")) %>%
  gt::gt()


search2 <- "microplastic pollution public health human[mh] review[pt ]"

n <- 146
start <- 2000
end <- 2022

key <- Sys.getenv("ncbi_key")

res2 <- pubmedAbstractR(search = search2, n = n, start = start, end = end, ncbi_key = key)

abs1 <- res2$abstracts

anno1 <- myScrapers::annotate_abstracts(abs1$abstract, abs1$pmid)
np1 <- myScrapers::abstract_nounphrases(anno1)

glimpse(np1)

np1 %>%
  drop_na(term) %>%
  group_by(doc_id) %>%
  summarise(term = paste(term, collapse = ", ")) %>%
  left_join(abs1, by = c("doc_id" = "pmid")) %>%
  gt::gt()


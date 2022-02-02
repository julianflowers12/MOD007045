## microplastics and human health

library(myScrapers)

search <- "microplastics AND (health) human[mh] systematic[sb]"

n <- 3
start <- 2000
end <- 2022

key <- Sys.getenv("ncbi_key")

res <- pubmedAbstractR(search = search, n = n, start = start, end = end, ncbi_key = key)

res$abstracts$title

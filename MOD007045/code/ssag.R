## using semantic scholar academic graph API

get_ss_papers <- function(search = "microplastics health", offset = 0, `next` = 100){

  require(jsonlite)
  require(stringr)
  search <- str_replace(search, "\\s", "+")
  url <- paste0("https://api.semanticscholar.org/graph/v1/paper/search?query=", search, "&", offset, "&", `next` )
  df <- fromJSON(url, simplifyDataFrame = TRUE)
  df
}

get_ss_papers("microplastics health")

## allotment literature

library(myScrapers)

search <- "allotment biodiversity ecosystem services"

ss_allot <- get_ss_data(search = search)

a1 <- ss_allot$data %>%
  .[c(5, 6, 9, 11, 12, 14, 17, 26, 61),]

search1 <- "allotment biodiversity"

ss_allot_1 <- get_ss_data(search = search1)

a2 <- ss_allot_1$data %>%
  .[c(1, 2, 6, 13, 27, 40, 62, 65, 88),]

search2 <- "allotment ecosystem"

ss_allot_2 <- get_ss_data(search = search2)

a3 <- ss_allot_2$data %>%
.[c(3, 4, 5, 24, 32, 88),]


a4 <- bind_rows(a1, a2, a3)

a4$externalIds.DOI

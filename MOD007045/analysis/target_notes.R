## target notes

target_notes <- read_csv("MOD007045/data/Cherry Hinton CP/target_notes.csv")

target_notes <- target_notes %>%
  arrange(fid) %>%
  mutate(Georeference = paste(round(ycoord,4), round(xcoord, 4), sep = ", "),
         Date = "08-02-2022",
         Significance = NA) %>%
  rename(`Point of interest` = Title) %>%
  select(Number = fid, Date, Georeference, everything()) %>%
  select(-contains("coord"))

target_notes %>%
  write_csv("t_notes_1.csv")

fruit_and_veg_prices <- read_csv("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1063460/fruitvegprices-28mar22.csv")

fruit_and_veg_prices %>%
  filter(unit == "kg") %>%
  ggplot(aes(date, price, colour = variety, group = variety)) +
  #geom_line(show.legend = F) +
  geom_smooth(se = F, show.legend = F) +
  facet_wrap(item ~ variety, scales = "free") +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£"))

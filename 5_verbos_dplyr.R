library(readxl)
library(janitor)
library(dplyr)
library(ggplot2)

hapiness <- read_excel("data/world-happiness-report-2021.xlsx") %>%
  janitor::clean_names()

hapiness %>%
  select(country_name, regional_indicator, starts_with("explained_by")) 

hapiness %>%
  select(where(is.character))

ls_per <- hapiness %>% 
  select(country_name, ladder_score, logged_gdp_per_capita) %>%
  arrange(desc(ladder_score), logged_gdp_per_capita)

ggplot(ls_per) + 
  geom_point(aes(x = ladder_score, y = logged_gdp_per_capita)) +
  xlab("Hapiness Score") + 
  ylab("Log GDP") 

ggplot(hapiness) + 
  geom_his(aes(x = ladder_score, color = regional_indicator)) + 
  ggthemes::theme_base()

ggplot(hapiness) + 
  geom_boxplot(aes(x = ladder_score, y = regional_indicator)) + 
  ggthemes::theme_base()


hapiness %>%
  group_by(regional_indicator) %>%
  count()

hapiness %>%
  count(regional_indicator)

## Unicos y quitar repetidos
## trim

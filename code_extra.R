library(tidyverse)
#devtools::install_github("hadley/neiss")
library(neiss)

injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))

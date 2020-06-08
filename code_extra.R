library(tidyverse)
devtools::install_github("hadley/neiss")
library(neiss)

top_prod <- injuries %>%
  filter(trmt_date >= as.Date("2017-01-01"), trmt_date < as.Date("2018-01-01")) %>%
  count(prod1, sort = TRUE) %>%
  filter(n > 5 * 365)

injuries %>%
  filter(trmt_date >= as.Date("2017-01-01"), trmt_date < as.Date("2018-01-01")) %>%
  semi_join(top_prod, by = "prod1") %>%
  mutate(age = floor(age), sex = tolower(sex), race = tolower(race)) %>%
  filter(sex != "unknown") %>%
  select(trmt_date, age, sex, race, body_part, diag, location, prod_code = prod1, weight, narrative) %>%
  vroom::vroom_write("neiss/injuries.tsv.gz")

injuries <- vroom::vroom("neiss/injuries.tsv.gz")
injuries
#> # A tibble: 255,064 x 10
#>   trmt_date    age sex   race  body_part diag  location prod_code weight
#>   <date>     <dbl> <chr> <chr> <chr>     <chr> <chr>        <dbl>  <dbl>
#> 1 2017-01-01    71 male  white Upper Tr… Cont… Other P…      1807   77.7
#> 2 2017-01-01    16 male  white Lower Arm Burn… Home           676   77.7
#> 3 2017-01-01    58 male  white Upper Tr… Cont… Home           649   77.7
#> 4 2017-01-01    21 male  white Lower Tr… Stra… Home          4076   77.7
#> 5 2017-01-01    54 male  white Head      Inte… Other P…      1807   77.7
#> 6 2017-01-01    21 male  white Hand      Frac… Home          1884   77.7
#> # … with 255,058 more rows, and 1 more variable: narrative <chr>
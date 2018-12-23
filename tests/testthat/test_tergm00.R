context('testing tergm00 output type')
source('~/Package_development/TreatyDiffusion/R/tergm_2000.R')
library(TreatyDiffusion)
library(dplyr)
test_df_1.2 = IVs00 %>%
  filter(as.character(cname) %in% c("USA","CAN","RUS","PRK","ROK", "SWZ", "SPN"))
test_df_3.2 = distance00 %>%
  select("USA","CAN","RUS","PRK","ROK", "SWZ", "SPN")
edge00 = edgelist

countries = c("2", "20", "365", "731", "732", "225", "230")


small_trade00 = list()
for(i in 1:length(tradelist00)){
  l = tradelist00[i]
  m = l[[1]]
  new_m = m[countries, countries]
  small_trade00 = append(small_trade00, new_m)
}

tergm_output = tergm_2000(IVs00, edge00, distance00, tradelist00)
test_that('tergm00 output type correct', {
  expect_is(tergm_output, 'list')
})

context('testing tergm75 output type')
source('~/Package_development/TreatyDiffusion/R/tergm_1975.R')
library(TreatyDiffusion)
library(dplyr)
test_df_1 = IVs75 %>%
  filter(as.character(cname) %in% c("USA","CAN","RUS","PRK","ROK", "SWZ", "SPN"))
test_df_3 = distance75 %>%
  select("USA","CAN","RUS","PRK","ROK", "SWZ", "SPN")

edge75 = edgelist
countries = c("2", "20", "365", "731", "732", "225", "230")

small_trade75 = list()
for(i in 1:length(tradelist75)){
  l = tradelist75[i]
  m = l[[1]]
  new_m = m[countries, countries]
  small_trade75 = append(small_trade75, new_m)
}

tergm_output = tergm_1975(test_df_1, edge75, test_df_3, small_trade75)

test_that('tergm75 output type correct', {
  expect_is(tergm_output, 'list')
})



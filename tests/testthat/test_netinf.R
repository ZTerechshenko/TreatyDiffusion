context('testing netinf_dynamic output type')
source('~/Package_development/TreatyDiffusion/R/netinf_dynamic.R')
library(TreatyDiffusion)

df = read.csv("~/Dropbox/UN_Treaties_project/UNtreaty_data_sign.csv")

treaties = c("International Sugar Agreement",
             "International Opium Convention",
             "International Cocoa Agreement, 1986*",
             "Convention on the Elimination of All Forms of Discrimination against Women",
             "International Covenant on Civil and Political Rights")

newdf = df %>%
  filter(title %in% treaties)

test_that('netinf_dynamic output type correct', {
  expect_is(netinf_dynamic(newdf), 'data.frame')
})

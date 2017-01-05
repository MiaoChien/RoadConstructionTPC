library(XML)
library(httr)
library(rvest)
library(magrittr)
library(data.table)
setwd("~/Dropbox/practice/crawler/RoadConstructionTPC")

res = GET("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162")

df =  res %>% content() %>% .$result %>% .$results %>% 
  do.call(rbind,.) %>% data.frame

df


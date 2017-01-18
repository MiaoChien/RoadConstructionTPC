library(XML)
library(httr)
library(rvest)
library(magrittr)
library(data.table)
library(RPostgreSQL)
setwd("~/Dropbox/practice/crawler/RoadConstructionTPC")

res = GET("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162")


df = res %>% content(.,as="text", encoding="UTF-8") %>% jsonlite::fromJSON() %>% .$result %>% .$results %>% as.data.frame


write.csv(df, file = "output/RoadConstructionTPC.csv",row.names = F, fileEncoding = "UTF-8")


pg = dbDriver("PostgreSQL")
con = dbConnect(pg, user="postgres", password="******", 
                host='localhost', port=5432, dbname="****")


# dbGetQuery(con, "SELECT id, name FROM parking_twd97")

if (dbExistsTable(con, "RoadConstructionTPC")){
  dbWriteTable(con, 'RoadConstructionTPC', df, append=T)  
}else{
  dbWriteTable(con, 'RoadonstructionTPC', df)
}


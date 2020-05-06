## https://github.com/kjhealy/covdata/
## before that must run "covid19indiajson.R" script for updataed daily data

source('/cloud/project/covid19indiajson/script/covid19indiajson.R')


library("tidyverse")
library("highcharter")
library("lubridate")
library("timetk")
library("kableExtra")

tt2 <- paste0("/cloud/project/covid19indiajson/input/cases_time_series_", format(Sys.time(), "%Y%m%d"), ".csv")
### write.table(DF2,tt2 ,na = 'NA', sep = ',',row.names = F, col.names = T,quote = TRUE)
Cases_Time_Series <- read.csv(file=tt2, header=TRUE, sep=",",stringsAsFactors = FALSE)
Cases_Time_Series$dateyear <-  as.Date(as.POSIXct(Cases_Time_Series$dateyear ,"%y-%m-%d"))  ### character to date format

names(Cases_Time_Series)
str(Cases_Time_Series)

##### graph 

##### Cases_Time_Series <- read_csv("/cloud/project/covid19india/Raw_Data_Cases_Time_Series.csv") ###TABLE6
hc6 <- highchart(type="stock")
for (k in names(Cases_Time_Series)[2:7]) {
   hc6 <- hc_add_series_times_values(hc=hc6, dates=Cases_Time_Series$dateyear,
                                 values=pull(Cases_Time_Series, k),
                                  name = k,type = "line")

  
}
hc6 <- hc_subtitle(hc6, text = "COVID19-India : Patient Database",
                   align = "left", style = list(color = "#2b908f", fontWeight = "bold"))  
hc6




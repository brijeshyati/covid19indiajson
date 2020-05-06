## https://github.com/kjhealy/covdata/
## before that must run "covid19indiajson.R" script for updataed daily data

source('/cloud/project/covid19indiajson/script/covid19indiajson.R')


library("tidyverse")
library("ggplot2")
library("gridExtra")
library("grid")


tt2 <- paste0("/cloud/project/covid19indiajson/input/statewise_", format(Sys.time(), "%Y%m%d"), ".csv")
### write.table(DF2,tt2 ,na = 'NA', sep = ',',row.names = F, col.names = T,quote = TRUE)
covnat <- read.csv(file=tt2, header=TRUE, sep=",",stringsAsFactors = FALSE)
covnat$date <-  as.Date(as.POSIXct(covnat$date ,"%y-%m-%d"))  ### character to date format

names(covnat)
str(covnat)

pd1 <- covnat %>% filter(deltaconfirmed > 0) %>% 
ggplot(aes(x = reorder(state, deltaconfirmed), y = deltaconfirmed)) +
  geom_bar(stat = "identity",aes(fill=state),color="red")+
  coord_flip()+
  geom_text(aes(label=deltaconfirmed),hjust=1) + 
  theme(legend.position = "none")+
  labs(### title = "COVID-19 dailywise confirmed count in indian State",
    #### subtitle = paste("confirmed as of", format(max(covnat$date), "%A, %B %e, %Y")),
       x = "statewise", y = "today confirmed count") +
  #### ,caption = "With reference to COVID Tracking Project(covid19india.org)") + 
  theme_minimal()

library(ggplot2)
library(dplyr)
library(tibble)
library(tidyr)
###### tc <- c("deltaconfirmed","deltarecovered","deltadeaths")

covnat %>% filter(deltaconfirmed > 10) %>% ggplot(aes(state,group = 1)) + 
  
  geom_bar(aes(y = deltaconfirmed), stat = "identity", fill="green") +
  geom_text(aes(x = state, y = deltaconfirmed, label = deltaconfirmed, group = 1),
            position = position_stack(vjust = .5)) +
  
  geom_bar(aes(y = deltarecovered), stat = "identity", fill="red") +
  geom_text(aes(x = state, y = deltarecovered, label = deltarecovered, group = 1),
            position = position_stack(vjust = .5)) +
  
  geom_bar(aes(y = deltadeaths), stat = "identity", fill="yellow")+
  geom_text(aes(x = state, y = deltadeaths, label = deltadeaths, group = 1),
            position = position_stack(vjust = .5)) +

  coord_flip() +
  theme(legend.position = "none") +
  
  ### geom_text(aes(label=deltaconfirmed),hjust=1) + 
  ### theme(legend.position = "none") +
  ### labs(### title = "COVID-19 dailywise confirmed count in indian State",
    #### subtitle = paste("confirmed as of", format(max(covnat$date), "%A, %B %e, %Y")),
    #### x = "statewise", y = "today confirmed count") +
  #### ,caption = "With reference to COVID Tracking Project(covid19india.org)") + 
  theme_minimal()

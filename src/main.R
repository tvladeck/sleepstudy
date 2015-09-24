setwd("~/Git/sleep")
library('ProjectTemplate')
load.project()

mydata <- sasxport.get("data/LLCP2014.XPT ")

# sleep.time.plot <- mydata %>% filter(sleptim1 < 15) %>% select(sleptim1) %>% hist



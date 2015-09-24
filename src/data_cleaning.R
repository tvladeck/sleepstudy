
## clustering

bin.vars <-c(
  "hlthpln1" ## int - do you have a health care plan 1-yes, 2-no, omit 7, 9, blank
  #,"medcost" ## int - was there time in past 12 months couldn't see a doctor b/c of cost 1-yes, 2-no omit others
  #,"addepev2" ## int - have you ever had depression - 1-yes, 2-no, omit others
  #,"veteran3" ## int - have you ever been in the armed forces 1-yes, 2-no omit others
  ,"internet" ## used internet in past 30d 1-yes, 2-no, omit others
  ,"sex" ## 1-male 2-female
)

nom.vars <- c(
  "genhlth" ## int - general health 1-excellent 5-poor omit 7,9,blank
  #,"persdoc2" ## int - do you have 1 person you think of as primary care 1-yes-1, 2-yes>1, 3-no, omit others
  ,"marital" ## int 
  # 1-married, 2-divorced, 3-widowed, 4-separated, 5-never married, 6-unmarried couple
  # omit > 6
  ,"educa" ## int 
  # 1-never school, 2-g1-8, 3-9-11, 4-high school, 5-c1-3, 6-college, omit > 6
  ,"employ1" ## int
  # 1-employed 2-self-employed 3-out of work >= 1 year
  # 4-out of work < 1year 5-homemaker 6-student 7-retired 8-unable omit others
  ,"income2" ## household 1 <10k, 2 10-15, 3 15-20, 4-20-25, 5-25-35, 6-35-50, 7-50-75, 8-75+ omit others
  #,"renthom1" ## own/rent home 1-own 2-rent 3-other omit others
  ,"hlthcvr1" ## primary source of health care coverage
  # 1-plan thru employer 2-family member's plan 3-medicare 4-medicaid/state 5-tricare 
  # 6-alaska/native american 7-other 8-none omit > 8
  ,"x.state"
)

num.vars <- c(
   "sleptim1" ## int - number of hours in a night - omit > 24, blank
  ,"physhlth" ## int - number days/30 physical health good - omit >30, blank
  ,"menthlth" ## int - same as above
  ,"children" ## int - # of children in the household omit > 87
#  ,"qlmentl2" ## int - number days/30 felt sad, blue, depressed - code 88 to 0, omit > 30
#  ,"qlstres2" ## int - number days/30 felt worried, tense, anxious - code 88 to 0, omit > 30
#  ,"qlhlth2"  ## int - number days/30 felt healthy, full of energy  code 88 to 0, omit > 30
#  ,"drvisits" ## int - number days/year visited doctor code 88 to 0, omit > 76
)

# order matters for clustMD function
cat.vars <- c(bin.vars, nom.vars)
all.vars <- c(num.vars, bin.vars, nom.vars)

## helper function
Code88ToZero <- function(vec)
  unlist(lapply(vec, function(x){if(x!=88 | is.na(x)) x else 0}))

## processing data

tmp <- mydata %>%
  select(one_of(all.vars)) 

processed.data <- tmp %>%
  as.data.frame %>%
#   mutate(
#      qlmentl2 = Code88ToZero(qlmentl2)
#     ,qlstres2 = Code88ToZero(qlstres2)
#     ,qlhlth2  = Code88ToZero(qlhlth2)
#     ,drvisits = Code88ToZero(drvisits)
#   ) %>% 
  filter(
     genhlth %in% 1:5
    ,hlthpln1 %in% 1:2
    #,persdoc2 %in% 1:3
    #,medcost %in% 1:3
    #,addepev2 %in% 1:2
    #,veteran3 %in% 1:2
    ,marital %in% 1:6
    ,educa %in% 1:6
    ,employ1 %in% 1:8
    ,income2 %in% 1:8
    ,internet %in% 1:2
    #,renthom1 %in% 1:3
    ,sex %in% 1:2
    ,hlthcvr1 %in% 1:8
    ,sleptim1 <= 24
    ,physhlth <= 30
    ,menthlth <= 30
    ,children <= 87
#    ,qlmentl2 <= 30
#    ,qlstres2 <= 30
#    ,qlhlth2  <= 30
#    ,drvisits <= 76
  )
# 
# for(col in cat.vars)
#    processed.data[, col] <- as.factor(processed.data[, col])




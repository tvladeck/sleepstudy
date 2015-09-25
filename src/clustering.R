# rf.dist <- randomForest(processed.data,
#                         proximity = T)
# 
# # estimate optimal # of clusters
# cluster.pam <- pamk(rf.dist$proximity, 1:10)
# 
# 
# cat.vars <- c(bin.vars, nom.vars)
# # ppdim <- processed.data %>% select(one_of(cat.vars)) %>% apply(2, max)
  
# cluster.lcmixed <- flexmixedruns(processed.data,
#                                  diagonal = F,
#                                  xvarsorted = T,
#                                  continuous = length(num.vars), 
#                                  discrete = length(c(nom.vars, bin.vars)))
# 
# 
# processed.data$cluster <- cluster.lcmixed$flexout[[cluster.lcmixed$optimalk]]@cluster

# within.low.sleep.data <- processed.data %>% select(-cluster) %>% filter(sleptim1 <= 6)
# 
# for(col in cat.vars)
#   within.low.sleep.data[, col] <- as.integer(as.character(within.low.sleep.data[, col]))
# 
# within.low.sleep.lcmixed <- flexmixedruns(x = select(within.low.sleep.data, -sleptim1),
#                                  diagonal = F,
#                                  xvarsorted = T,
#                                  continuous = length(num.vars)-1, 
#                                  discrete = length(c(nom.vars, bin.vars)))

# save(within.low.sleep.lcmixed, file = "images/within.low.sleep.lcmixed")




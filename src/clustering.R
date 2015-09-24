rf.dist <- randomForest(processed.data,
                        proximity = T)

# estimate optimal # of clusters
cluster.pam <- pamk(rf.dist$proximity, 1:10)


cat.vars <- c(bin.vars, nom.vars)
# ppdim <- processed.data %>% select(one_of(cat.vars)) %>% apply(2, max)
  
cluster.lcmixed <- flexmixedruns(processed.data,
                                 diagonal = F,
                                 xvarsorted = T,
                                 continuous = length(num.vars), 
                                 discrete = length(c(nom.vars, bin.vars)))
                                 
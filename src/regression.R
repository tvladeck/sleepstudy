# rf.reg <- train(
#   formula = sleptim1 ~ ., 
#   data = processed.data,
#   importance = T,
#   ntree = 100,
#   verbose = T
# )

for(col in cat.vars)
  processed.data[, col] <- as.factor(processed.data[, col])

# rf.reg <- randomForest(sleptim1 ~ ., 
#                        data = select(processed.data, -cluster),
#                        importance = T, 
#                        ntree = 100, 
#                        proximity = T)

variable.importance <- varImpPlot(rf.reg)

# save(rf.reg, file = "images/rf.reg")

# viz.data <- rf.reg$proximity %>% cmdscale
# viz.data <- as.data.frame(viz.data)
# save(viz.data, file = "images/viz.data")

regression <- lm(formula = sleptim1 ~ ., data = na.omit(select(processed.data, -cluster, -hlthpln1)))
coeffs <- summary(regression)$coefficients %>% as.data.frame

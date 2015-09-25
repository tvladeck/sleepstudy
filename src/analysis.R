## analysis
clusters <- within.low.sleep.lcmixed$flexout[[within.low.sleep.lcmixed$optimalk]]


## relative sizes
sizes <- 1:6 %>% sapply(function(x) sum(clusters@cluster == x)) %>% as.data.frame
sizes$cluster <- 1:6
colnames(sizes) <- c("size", "cluster")
size.plot <- ggplot(sizes, aes(x=cluster, y=size)) + geom_bar(stat="identity") + 
  graph_theme + scale_x_continuous(breaks = 1:6, labels=1:6) + labs(x="", y="") + 
  ggtitle("Relative Cluster Sizes")


## centers for numerical vars
centers <- data.frame()
for(i in names(clusters@components)) 
  centers <- rbind(centers, clusters@components[[i]][[1]]@parameters$center)

colnames(centers) <- c("physhlth", "menthlth", "children")
centers$cluster <- 1:6
centers <- gather(centers, key=cluster)
colnames(centers)[2] <- "variable"

centers.plot <- ggplot(centers, aes(x=cluster, y=value, group=variable)) + 
  geom_bar(stat="identity") + facet_grid(variable ~ .) + theme_bw() + labs(x="", y="") +
  ggtitle("Numerical Variables")

## Internet
internet <- data.frame()
for(i in names(clusters@components)) 
  internet <- rbind(internet, clusters@components[[i]][[1]]@parameters$pp[[2]])
colnames(internet) <- c("yes", "no")
internet$cluster <- 1:6
internet <- gather(internet, key=cluster)
colnames(internet)[2] <- "response"
internet.plot <- ggplot(internet, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + theme_bw() + labs(x="", y="") +
  ggtitle("Internet use by cluster")


## General Health
general.health <- data.frame()
for(i in names(clusters@components)) 
  general.health <- rbind(general.health, clusters@components[[i]][[1]]@parameters$pp[[4]])
colnames(general.health) <- c("excellent", "good", "average", "fair", "poor")
general.health$cluster <- 1:6
general.health <- gather(general.health, key=cluster)
colnames(general.health)[2] <- "response"
general.health.plot <- ggplot(general.health, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + theme_bw() + labs(x="", y="") +
  ggtitle("General health by cluster")

## Marital
marital <- data.frame()
for(i in names(clusters@components)) 
  marital <- rbind(marital, clusters@components[[i]][[1]]@parameters$pp[[5]])
colnames(marital) <- c("married", "divorced", "widowed", "separated", "never married", "unmarried couple")
marital$cluster <- 1:6
marital <- gather(marital, key=cluster)
colnames(marital)[2] <- "response"
marital.plot <- ggplot(marital, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Marital status by cluster")

## Education
education <- data.frame()
for(i in names(clusters@components)) 
  education <- rbind(education, clusters@components[[i]][[1]]@parameters$pp[[6]])
colnames(education) <- c("no school", "some jhs", "some hs", "hs", "some college", "college +")
education$cluster <- 1:6
education <- gather(education, key=cluster)
colnames(education)[2] <- "response"
education.plot <- ggplot(education, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Education level by cluster")

## Employment
employment <- data.frame()
for(i in names(clusters@components)) 
  employment <- rbind(employment, clusters@components[[i]][[1]]@parameters$pp[[7]])
colnames(employment) <- c("employed", "self-employed", "unemployed >= 1year", 
                          "unemployed < 1 year", "homemaker", "student", 
                          "retired", "disabled")
employment$cluster <- 1:6
employment <- gather(employment, key=cluster)
colnames(employment)[2] <- "response"
employment.plot <- ggplot(employment, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Employment status by cluster")

## Income
income <- data.frame()
for(i in names(clusters@components)) 
  income <- rbind(income, clusters@components[[i]][[1]]@parameters$pp[[8]])
colnames(income) <- c("<10k", "10-15k", "15-20k", "20-25k", "25-35k", 
                      "35-50k", "50-75k", "75k+")
income$cluster <- 1:6
income <- gather(income, key=cluster)
colnames(income)[2] <- "response"
income.plot <- ggplot(income, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Income level by cluster")


## Health Coverage
health.coverage <- data.frame()
for(i in names(clusters@components)) 
  health.coverage <- rbind(health.coverage, clusters@components[[i]][[1]]@parameters$pp[[9]])
colnames(health.coverage) <- c("plan thru employer", "family member's plan",
                               "medicare", "medicaid/state", "tricare", "alaska/tribe",
                               "other", "none")
health.coverage$cluster <- 1:6
health.coverage <- gather(health.coverage, key=cluster)
colnames(health.coverage)[2] <- "response"
health.coverage.plot <- ggplot(health.coverage, aes(x=response, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Health coverage by cluster")

## Geography
geography.tmp <- data.frame()
for(i in names(clusters@components)) 
  geography.tmp <- rbind(geography.tmp, clusters@components[[i]][[1]]@parameters$pp[[10]])
colnames(geography.tmp) <- processed.data$x.state %>% unique

geography <- data.frame(cluster=1:6)
geography$northeast <- rowSums(geography.tmp[, c("9", "25", "33", "44", "50")])
geography$mid.atlantic <- rowSums(geography.tmp[, c("34", "36", "42")])
geography$midwest <- rowSums(geography.tmp[, c("17", "26", "39", "55")])
geography$plains <- rowSums(geography.tmp[, c("19", "27", "31", "38")])
geography$south.atlantic <- rowSums(geography.tmp[, c("10", "13", "24", "37", "45", "51", "11", "54")])
geography$east.south.central <- rowSums(geography.tmp[, c("1", "21", "28", "47")])
geography$west.south.central <- geography.tmp[, "22"]
geography$mountain <- rowSums(geography.tmp[, c("4", "16", "30", "32", "35", "49")])
geography$pacific <- rowSums(geography.tmp[, c("1", "41", "53")])

geography <- gather(geography, key=cluster)
colnames(geography)[2] <- "region"
geography.plot <- ggplot(geography, aes(x=region, y=value, group=cluster)) + 
  geom_bar(stat="identity") + facet_grid(cluster ~ .) + graph_theme + labs(x="", y="") +
  ggtitle("Geography by cluster")


## Plots

cat.plots <- c(internet.plot, marital.plot, general.health.plot, 
               education.plot, employment.plot, income.plot, 
               health.coverage.plot, geography.plot)



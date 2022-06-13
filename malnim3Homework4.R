#Task 1: Hypothesis Test One Mean
#1 Ho: p = 78 H1: p < 78 
foulballs <- read.csv("C:/Users/haytr/Documents/STATS382/foulballs.csv")

#2 Since sigma is not known we use t.test
t.test(foulballs$exit_velocity, mu = 78, alternative = "less", conf.level = 0.9)
#One Sample t-test

#data:  foulballs$exit_velocity
#t = -0.75708, df = 45, p-value = 0.2265
#alternative hypothesis: true mean is less than 78
#90 percent confidence interval:
#  -Inf 79.0442
#sample estimates:
#  mean of x 
#76.54565 

#3 
#p-value = 0.2265 !< 10 = alpha so we do Not reject Ho

#4 
#There is not enough evidence that the mean exit velocity is less than 78MPH

#5
# CI: (-inf, 79.0442)

#6
#We can not make a conclusion since 78mph is in our CI.

#Task 2: Hypothesis Test Two Means
#7 Ho: d = 0 H1: d != 0  d = VV - NV
stereograms <- read.csv("C:/Users/haytr/Documents/STATS382/stereograms.csv")

#8 Since p-value is < 0.03 we can not say that the var are equal.
vv <- subset(stereograms, group == 'VV')
nv <- subset(stereograms, group == 'NV')
var.test(vv$fusion.time, nv$fusion.time,
         conf.levle = 0.94,  alternative = "two.sided")
#F test to compare two variances

#data:  vv$fusion.time and nv$fusion.time
#F = 0.35269, num df = 34, denom df = 42, p-value = 0.002345
#alternative hypothesis: true ratio of variances is not equal to 1
#95 percent confidence interval:
#  0.1863177 0.6827387
#sample estimates:
#  ratio of variances 
#0.3526897 

#9
t.test(vv$fusion.time, nv$fusion.time, conf.level = 0.94, 
       mu = 0, alternative = "two.sided")
#Welch Two Sample t-test

#data:  vv$fusion.time and nv$fusion.time
#t = -2.0384, df = 70.039, p-value = 0.04529
#alternative hypothesis: true difference in means is not equal to 0
#94 percent confidence interval:
#  -5.8311068 -0.1869648
#sample estimates:
#  mean of x mean of y 
#5.551429  8.560465 

#10
#p-value = 0.04529 < 0.06 = alpha so we reject H0

#11
#Conclusion: There is enough evidence in support of a difference in the time the 
#two population proportions took to fuse the images to a 3D image

#Task 3: Hypothesis Test Two Proportions
#12
# H0: d = 0 H1: d != 0  OR H0: p1 = p2 H1: p1 != p2
#d = gen_z - millennial OR p1 = gen_z p2 = millennial

#13
gen_z <- 655/ 850
millennials <- 588/900
prop.test(x = c(655,588), n = c(850,900), alternative = "two.sided",
          correct = FALSE, conf.level = 0.94)
#2-sample test for equality of proportions without continuity correction

#data:  c(655, 588) out of c(850, 900)
#X-squared = 29.207, df = 1, p-value = 6.505e-08
#alternative hypothesis: two.sided
#94 percent confidence interval:
#0.07693246 0.15757734
#sample estimates:
#  prop 1    prop 2 
#0.7705882 0.6533333 

#14
#p-value = 6.505e-08 < 0.06 = alpha so we reject H0

#15
#Conclusion: There is enough evidence in support of a difference in the 
#two population proportions that plan to celebrate Halloween this year

#Task 4: Independence
sales <- read.csv("C:/Users/haytr/Documents/STATS382/sales.csv")
#16
#H0: Segment and Category are independent 
#H1: Segment and Category are not independent 

#17
data <- table(sales$Segment, sales$Category)
chisq.test(data, correct = FALSE)
#Pearson's Chi-squared test
#data:  data
#X-squared = 9.562, df = 4, p-value = 0.04849

#18
# p-value = 0.04849 < 0.09 = alpha so we reject H0

#19
#Conclusion: There is a difference in support of Segment and Category not being
#independent 

#Task 5: Fisher's Exact (Bonus)
data2 <- matrix(data = c(16,2,11,8), nrow = 2, ncol = 2, byrow = TRUE) 
rownames(data2) <- c("Drug A", "Drug B")
colnames(data2) <- c("Survive", "Not Survive")
#20
fisher.test(data2, alternative = "two.sided", conf.level = 0.92)
#Fisher's Exact Test for Count Data

#data:  data2
#p-value = 0.0625
#alternative hypothesis: true odds ratio is not equal to 1
#92 percent confidence interval:
#1.015185 48.522151
#sample estimates:
#  odds ratio 
#5.545191 

#21
#p-value = 0.0625 <  0.08 = alpha so we reject H0

#22
# There is enough evidence to in support of the alternate hypothesis

#Task 6: Equal Proportions
data3 <- esoph
#23
#H0: the proportion of people with cancer in each group is the same  
#H1: at least one proportion is different from the others

#24
ncases_total <- aggregate(data3$ncases, by=list(data3$alcgp), FUN=sum)
ncontrols_total <- aggregate(data3$ncontrols, by=list(data3$alcgp), FUN=sum)
total <- ncases_total$x + ncontrols_total$x
success <- c(29,75,51,45)
prop.test(success, total, correct = FALSE)

#4-sample test for equality of proportions without continuity correction

#data:  success out of total
#X-squared = 90.45, df = 3, p-value < 2.2e-16
#alternative hypothesis: two.sided
#sample estimates:
#  prop 1     prop 2     prop 3     prop 4 
#0.06531532 0.17441860 0.26984127 0.40178571 

#25
#p-value 2.2e-16 < 0.05 = alpha so we reject H0

#26
#There is enough evidence to in support that at least one proportion is 
#different from the others

#Task 7: Trend in Proportions
#27
#H0: there is no linear trend in the proportion of people with cancer in each group 
#H1: there is a linear trend in the proportion of people with cancer in each group 

#28
prop.trend.test(success, total)
#Chi-squared Test for Trend in Proportions

#data:  success out of total ,
#using scores: 1 2 3 4
#X-squared = 90.15, df = 1, p-value < 2.2e-16
#29
# p-value 2.2e-16 < 0.05 = alpha so we reject H0

#30
#There is enough evidence to in support that there is a linear trend in the  
#proportion of people with cancer in each group 
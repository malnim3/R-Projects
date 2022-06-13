#Task 1
#Question 1
  #Binomial Distribution
  #Mean: 76.28667, Var:1821.991
  set.seed(16)
  mean(sample(1:150,150,TRUE))
  var(sample(1:150,150,TRUE))
  #Mean: 27.8, Var: 16.95499
  set.seed(16)
  mean(rbinom(0:150,80,0.35))
  var(rbinom(0:150,80,0.35))
  #The mean and variance of the sample is very different from the binomial mean
  #and variance. The mean is much larger for the sample and so is the variance.
  
  #Geometric Distribution
  #Mean: 76.28667,Var:1821.991
  set.seed(16)
  sampGeo <- sample(1:150,150,TRUE)
  mean(sampGeo)
  var(sampGeo)
  #Mean: 3,Var: 8.603639
  set.seed(16)
  rgeom(80,0.25)
  (1-0.25)/0.25
  var(rgeom(80,0.25))
  #The mean and variance of the sample is very different from the geometric 
  #distribution. The mean is much larger for the sample and so is the variance.
  
  #Chi-squared Distribution
  set.seed(16)
  mean(sample(1:150,150,TRUE))
  var(sample(1:150,150,TRUE))
  #Mean: 15.08963,Var: 38.36214
  set.seed(16)
  mean(rchisq(80,15,0))
  var(rchisq(80,15,0))
  #The mean and variance of the sample is very different from the chi-squared
  #distribution. The mean is much larger for the sample and so is the variance.

#Question 2
  #a
  set.seed(16)
  sample_pois1 <- rpois(400, 1.2)
  set.seed(16)
  sample_pois2 <- rpois(400, 50)
  #b
  classes_1 <- seq(min(sample_pois1)-0.5, max(sample_pois1)+0.5,1)
  classes_2 <- seq(min(sample_pois2)-0.5, max(sample_pois2)+0.5,1)
  #c
  hist(sample_pois1, breaks = classes_1, right = FALSE, main="Sample Poisson 1",
       xlab = "Data randomly generated")
  hist(sample_pois2, breaks = classes_2, right = FALSE, main="Sample Poisson 2",
       xlab = "Data randomly generated")
  #d
  # Sample 2 has a larger range than sample 1. Sample 2 looks more normal than 
  #sample one which looks skewed to the right. The frequency of sample 1 is
  #much larger than the frequency of sample 2
  
#Question 3
  #a
  n1 <- 10
  n2 <- 300
  p <- 0.25
  #b
  #n1 -> np: 2.5, n(1-p): 7.5
  #n2 -> np: 75, n(1-p): 225
  n1*p
  n1*(1-p)
  n2*p
  n2*(1-p)
  #c
  success_1 <- c(0:n1)
  success_2 <- c(0:n2)
  #d
  probability_1 <- dbinom(success_1 ,n1 ,prob = p)
  probability_2 <- dbinom(success_2 ,n2 ,prob = p)
  #e
  plot(probability_1, main = "Probablity 1", ylab ="Probability", 
       xlab ="Integer")
  plot(probability_2, main = "Probablity 2", ylab ="Probability", 
       xlab ="Integer")
  #f
  # Probability 2 has a bell shaped curve and probability 1 has a skewed plot.
  #The maximum value of probability 1 is higher than probability 2. The range
  #of n is larger for probability 2 than probability 1.
  
#Task 2
  skew <- function ( x ) {
    m3 <- sum (( x - mean ( x ) ) ^3) / length ( x )
    m3 /( sd ( x ) ^3)
  }
#Question 4
  #a) When describing what is shown by the qqplots, when I state that something 
  #is above or below the normal line, I mean underneath the diagonal line 
  #going from the bottom left corner of the plot to the top right corner. This 
  #plot shows the data curving upward underneath the normal lime. Based on this
  #observation, I believe this data is skewed to the right.
  qqplot(c(0.0:max(sample_pois1)),sample_pois1)
  #b) Since the test indicated that the p-value of sample_pois1 was lass than
  # 0.05, this is not normal.
  shapiro.test(sample_pois1)
  #c) Since our function skew(sample_pois1) gave us 0.7203768 which is close to
  #positive 1, the data is skewed to the right  
  skew(sample_pois1)
  
#Question 5
  #a) The plot does not seem to have a perfect diagonal line from the 
  #bottom left corner to the top right corner, it also does not seem too above
  #or below the normal line. This leads me to believe the plot is approximately 
  #normal
  qqplot(c(0.0:max(sample_pois2)),sample_pois2)
  #b) The shapiro test showed that the p-value is 0.04629 which is less than 
  #0.05 but if rounded would be 0.05. This leads me to believe the data is 
  #approximately normal
  shapiro.test(sample_pois2)
  #c) The function skew(sample_pois2) gave us a value of 0.06206187. This value
  #is very close to 0 which leads me to believe the data is approximately normal.
  skew(sample_pois2)
  
#Question 6
  sample_binom6 <- rbinom(n1, 400, 0.25)
  #a) The plot does not seem to have a perfect diagonal line from the 
  #bottom left corner to the top right corner, it also does not seem too above
  #or below the normal line. This leads me to believe the plot is approximately 
  #normal
  qqplot(c(0.0:max(sample_binom6)),sample_binom6)
  #b) The shapiro test showed that the p-value is 0.8992 which is greater than
  #0.05. This leads me to believe the approximately normal.
  shapiro.test(sample_binom6)
  #c) The function skew(sample_binom6) gave us the value 0.126765 which is 
  #closer to 0 than 1. Based on this, I believe the data is approximately normal.
  skew(sample_binom6)
  
#Question 7
  sample_binom7 <- rbinom(n2, 400, 0.25)
  #a) The plot does not seem to have a perfect diagonal line from the 
  #bottom left corner to the top right corner, it also does not seem too above
  #or below the normal line. This leads me to believe the plot is approximately 
  #normal
  qqplot(c(0.0:max(sample_binom7)),sample_binom7)
  #b) The shapiro test showed that the p-value is 0.2896 which is greater than
  #0.05. This leads me to believe the approximately normal.
  shapiro.test(sample_binom7)
  #c) The function skew(sample_binom6) gave us the value 0.1090001 which is 
  #closer to 0 than 1. Based on this, I believe the data is approximately normal.
  skew(sample_binom7)
  
#Task 3
  bpadage <- read.csv("C:/Users/haytr/Documents/STATS382/BPandAge.csv")
#Question 8
  bptable <- table(bpadage$blood_pressure, bpadage$age)

#Question 9
#          30 - 49 Over 50 Under30 Sum
#  High        51      73       23 147
#  Low         37      31       27  95
#  Normal      91      93       48 232
#  Sum        179     197       98 474
  addmargins(bptable)
#Question 10
#  High    Low Normal 
#  147     95    232 
#  30 - 49  Over 50 Under 30 
#  179      197       98 
  marginSums(bptable,1)
  marginSums(bptable,2)
  #When looking at age we can see that we have most data for people over 50 and
  #the least data for people under 30.
  #When looking at blood pressure, we see that most people had normal blood
  #pressure and the least amount of people had low blood pressure
  
#Question 11
  #         30 - 49   Over 50  Under 30
  #High   0.2849162 0.3705584 0.2346939
  #Low    0.2067039 0.1573604 0.2755102
  #Normal 0.5083799 0.4720812 0.4897959
  prop.table(bptable,2)
#Question 12
  #I do not believe there is an association since the probably of having 
  # high, low, or normal blood pressure is approximately the same regardless 
  # of the age we are looking at.
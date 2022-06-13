## Worksheet 4 Template
## Name: Mashel Al-Nimer

#### TASK 1 - HYPOTHESIS TEST FOR PAIRED DATA

## Question 1 - State Hypotheses
  # after - before
	# H0: d = 48
	# H1: d > 48

## Question 2 - Conduct the Test
## Make sure to also copy and paste results from your code
	# R Code
  data1 <- read.csv("C:/Users/haytr/Documents/STATS382/Exercise Heart Rate.csv")
  t.test(data1$Pulse2, data1$Pulse1, paired = TRUE, conf.level = 0.93, 
         mu= 48, alternative = "greater")

	# Results
  #data:  data1$Pulse2 and data1$Pulse1
  #t = 1.0906, df = 45, p-value = 0.1406
  #alternative hypothesis: true difference in means is greater than 48
  #93 percent confidence interval:
  #  46.71982      Inf
  #sample estimates:
  #  mean of the differences 
  #51.3913 

## Question 3 - State the p-value
		# p-value = 0.1406
	
## Question 4 - Decision at alpha = 0.07
    #We reject Ho
	
## Question 5 - Conclusion
    #We are 93% confident that the true mean of heart rate after running is more than 
    # 48 beats per minute.
	
	
## Question 6 - Confidence Interval
	# a) Is the confidence interval two-sided or one-sided?
  # One-sided
	
	# b) Provide your interval.
  # (51.3913, inf)
	
	# c) Can you conclude that running increases the mean heart rate by more than 48 beats per minute?  Why or why not?
  #We are 93% confident that the true mean of heart rate after running is more than 
  # 48 beats per minute.Our CI as stated in part b does not include 48 so we are 93% confident that 
  # running increases the mean heart rate by more than 48 beats per minute.
	
#### TASK 2 - HYPOTHESIS TEST FOR ONE PROPORTION

## Question 7 - State hypotheses
  # H0: d = 0.82
	# H1: d != 0.82
	
## Question 8 - Conduct the Test
## Make sure to also copy and paste results from your code
	# R Code
  data2 <- read.csv("C:/Users/haytr/Documents/STATS382/squirrelcolor.csv")
  x <- table(data2$color)
  n <- 25+760+105
  prop.test(x = 760, n = n, p = 0.82, alternative = "two.sided",
            conf.level = 0.97, correct = "FALSE")
  
	# Results
  #1-sample proportions test without continuity correction
  
  #data:  760 out of n, null probability 0.82
  #X-squared = 6.9428, df = 1, p-value = 0.008416
  #alternative hypothesis: true p is not equal to 0.82
  #97 percent confidence interval:
  #  0.8263793 0.8777600
  #sample estimates:
  #  p 
  #0.8539326 
	
## Question 9 - State the p-value
	# p-value = 0.008416
	
## Question 10 - Decision at alpha = 0.03
  #Reject Ho
	
## Question 11 - Conclusion
  #We are 97% confident that the true difference in mean of squirrels that are gray 
  # is somewhere in between (0.8263793, 0.8777600).
	
## Question 12 - Compute a Confidence Interval
	# a) Is the confidence interval two-sided or one-sided?
  #two-sided
	
	# b) Provide your interval.
  # (0.8263793, 0.8777600)
	
	# c) Can you conclude that the proportions of squirrels that are gray is different than 0.82?  Why or why not?
  #We are 97% confident that the true difference in mean of squirrels that are gray 
  # is somewhere in between (0.8263793, 0.8777600). Since 0.82 is not in this interval,
  # we are 93% confident that the proportions of squirrels that are gray is different than 0.82.


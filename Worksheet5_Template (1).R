## Worksheet 5
## Name: Mashel Al-Nimer

########################################
## Task 1: Simple Linear Regression  ###
########################################

# Import Data
calories <- read.csv("C:/Users/haytr/Documents/STATS342/calories.csv")
pengDives <- read.csv("C:/Users/haytr/Documents/STATS342/penguindives.csv")

# Question 1 - Create a scatterplot with Heart_Rate on the horizontal axis and Duration on the vertical axis.
# Make sure to export the graph and submit it to Gradescope
  plot(pengDives$Heart_Rate, pengDives$Duration, ylab = "Duration", xlab = "Heart_Rate")
	
# Question 2 - Compute Person's correlation coefficient, r.
		# Code:
    cor.test(pengDives$Heart_Rate, pengDives$Duration, method = "pearson")

		# Value:
#Pearson's product-moment correlation

#data:  pengDives$Heart_Rate and pengDives$Duration
#t = -8.9076, df = 32, p-value = 3.55e-10
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# -0.9197641 -0.7081451
#sample estimates:
#       cor 
#-0.8441596 

# Question 3 - Based on your scatterplot and the value for r, describe the linear association between the two variables.
	#Based on the scatterpot and the r avlue of -0.8441596, the linear association
  #between the two variables is a strong negative linear relationship
		
# Question 4 - Create the simple linear regression model for Duration with Heart_Rate as the predictor.
  plot(pengDives$Heart_Rate, pengDives$Duration, ylab = "Duration", xlab = "Heart_Rate")
  abline(lm(pengDives$Duration ~ pengDives$Heart_Rate ))
  
# Question 5a - Test Linearity
# Make sure to export any graphs and submit them to Gradescope
	# Code
  r <- lm(pengDives$Duration ~ pengDives$Heart_Rate )
  res <- resid(r)
  plot(pengDives$Heart_Rate, res, ylab = "Residuals", xlab = "Heart_Rate")
  abline(0,0)

	# Is the linearity condition met?
	#	Yes
		
# Question 5b - Test Normality
# Make sure to export any graphs and submit them to Gradescope
# If you run code that produces results, make sure to copy and paste the result in your R Script.

	# Code
  qqplot(pengDives$Heart_Rate, res, ylab = "Residuals", xlab = "Heart_Rate")
  
	# Is the normality assumption met?
	#Yes
		
# Question 5c - Test Equal Variance
# Make sure to export any graphs and submit them to Gradescope

	# Code
  plot(fitted(r), res)
  abline(0, 0)

	# Is the equal variance assumption met?
  #Yes

# Question 6 - Test whether Heart_Rate is important in explaining variation in Duration at a 7% significance level.
	
	# a) State hypotheses
		# H0: b = 0
		# H1: b != 0
	
	# b) Conduct the Test and report the results as a comment.
		# Code
    summary(r,sig)

		# Copy and paste results here
   # Call:
    #  lm(formula = pengDives$Duration ~ pengDives$Heart_Rate)
    
  #  Residuals:
   #   Min      1Q  Median      3Q     Max 
    #-4.0384 -1.4531 -0.2779  1.5982  4.4167 
    
    #Coefficients:
     # Estimate Std. Error t value Pr(>|t|)    
    #(Intercept)          16.19805    1.07143  15.118 3.99e-16 ***
      #pengDives$Heart_Rate -0.16264    0.01826  -8.908 3.55e-10 ***
    #  ---
    #  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    #Residual standard error: 2.176 on 32 degrees of freedom
    #Multiple R-squared:  0.7126,	Adjusted R-squared:  0.7036 
    #F-statistic: 79.35 on 1 and 32 DF,  p-value: 3.55e-10


		# Test Statistic Value = 79.35

		# P-Value = 3.55e-10

	# c) State your decision.
    #reject ho since p-value is < 0.07
			
			
	# d) State your conclusion.
  #There is evidence of a significant linear relationship between Heart rate and 
  #Duration 
			
# Question 7 - Give the value for multiple R^2 and explain what it tells you about the model.

		# Multiple R^2 = 0.7126 = 71.26%

		# Interpretation: 
			#71.26% of the variability in  Heart rate is explained by Duration
			
########################################
## Task 2: 1-way ANOVA  ################
########################################
			
# Import Data 
#Done earlier
		
# Question 8 - Create side-by-side boxplots by Restaurant and note if there appear to be any differences by restaurant.
# Make sure to export any graphs and submit them to Gradescope

	# Code
	boxplot(calories$Calories~calories$Restaurant, xlab = "Resturant", ylab = "Calories")

	# Potential Differences:
	#Red Robins < TGIFridays < Chilis mean calories
  #Red Robins and TGIFridays have outliers   
	
# Question 9 - Create a linear model for Calories with Restaurant as the predictor
  linear_model <- lm(calories$Calories~calories$Restaurant)
  
# Question 10a - Test Normality
# Make sure to export any graphs and submit them to Gradescope
# If you run code that produces results, make sure to copy and paste the result in your R Script.

	# Code
  res2 <- resid(linear_model)
  qqplot(calories$Calories, res2)
  
	# Is the normality assumption met?
	#yes
	
# Question 10b - Test Equal Variance

	# Code
  bartlett.test(calories$Calories~calories$Restaurant)

	# Copy and paste results here
#  Bartlett test of homogeneity of variances
  
#  data:  calories$Calories by calories$Restaurant
#  Bartlett's K-squared = 4.4875, df = 2, p-value = 0.1061

	# Is the equal variance assumption met?
  #yes
	
	
# Question 11 - Test whether the effect of restaurant is significant.
	# a) State Hypotheses
		# H0: all restaurants have the same mean
		# H1: at least one of the means is different 
	
	# b) Conduct the Test and report the results as a comment.

		# Code
    summary(lm(calories$Calories~calories$Restaurant))

		# Copy and paste results here
#    Call:
#      lm(formula = calories$Calories ~ calories$Restaurant)
    
#    Residuals:
#      Min      1Q  Median      3Q     Max 
#    -773.02 -226.97  -23.02  270.00 1055.11 
    
 #   Coefficients:
#      Estimate Std. Error t value Pr(>|t|)    
#    (Intercept)                    1113.02      54.03  20.600   <2e-16 ***
#      calories$RestaurantRed Robin   -176.05      69.65  -2.528   0.0125 *  
#      calories$RestaurantTGIFridays  -128.13      74.77  -1.714   0.0886 .  
 #   ---
#      Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
#    Residual standard error: 354.3 on 152 degrees of freedom
#    Multiple R-squared:  0.04112,	Adjusted R-squared:  0.0285 
#    F-statistic: 3.259 on 2 and 152 DF,  p-value: 0.04113

		# Test Statistic Value = 3.259

		# P-Value = 0.04113
	
	# c) State your decision.
  #Since p-value < 0.05 we reject ho

	# d) State your conclusion.
  #There is enough evidence that the restaurant is explaning some of the 
    #variability in calories
	
# Question 12 - If the effect is significant, compute either Bonferroni P-values or Tukey SCIs.
	
	# Code
  TukeyHSD(aov(linear_model), conf.level = 0.95)
	# Copy and paste results here
#  Tukey multiple comparisons of means
#  95% family-wise confidence level
  
#  Fit: aov(formula = linear_model)
  
#  $`calories$Restaurant`
#                           diff       lwr       upr     p adj
#  Red Robin-Chilis     -176.05403 -340.9010 -11.20708 0.0332677
#  TGIFridays-Chilis    -128.12964 -305.0990  48.83971 0.2033771
#  TGIFridays-Red Robin   47.92439 -112.6452 208.49399 0.7600625

	# Which pairs show evidence of a significant difference?
  #  Red Robin-Chilis 




#Task 1: Confidence Intervals
#Question 1:
pokemon_sample <- read.csv("C:/Users/haytr/Documents/STATS382/pokemon_sample1.csv")
#mean: 71.95294 size: 85
mean(pokemon_sample$hp)
length(pokemon_sample$hp)

#Question 2:
#Critical values are +/- 1.880794
qnorm(0.06/2)
z_0.03 <- 1.880794  

#Question 3:
#Upper interval is 77.37936 HP
#Lower interval is 66.52652 HP
upper_interval <- 71.95294 + z_0.03 * (26.6/ sqrt(85))
lower_interval <- 71.95294 - z_0.03 * (26.6/ sqrt(85))

#Question 4: 
#We are 94% confident that the true mean of HP a pokemon character has is 
#between 66.52652 HP HP and 77.37936 HP.

#Question 5:
#77.2 HP could possibly be the population mean but we are not certain since
#we are only 94% confident that the population mean is in the above interval
#There is still a 6% chance it is not in this interval

#Question 6:
#We would need to compute a confidence interval lower than 94% such as 90%

#Question 7:
#Critical values are +/- 1.644854
qnorm(0.1/2)
z_0.05 <- 1.644854

#Question 8:
#Upper interval is 76.69863 hp
#Lower interval is 67.20725 hp
upper_interval <- 71.95294 + z_0.05 * (26.6/ sqrt(85))
lower_interval <- 71.95294 - z_0.05 * (26.6/ sqrt(85))

#Question 9:
#77.2 is most likely not the population mean since it is not in the above interval
#but we are only 90% confident with that interval so there is a 10% chance that
#it could be the the population mean.


#Task 2: Hypothesis Testing
#Question 10:
# H0: p = 75
# H1: p > 75

#Question 11:
#p-value is 0.9513413
pnorm(1.658)

#Question 12:
#Since 1.658 is not greater than 2.053749, we do not reject H0
qnorm(0.98, FALSE) #2.053749

#Question 13:
#Significance levels less than 0.04865873
pnorm(1.658)

#Question 14:
#Significance level 0.04865873

#Question 15:
#Significance levels more than 0.04865873

#Task 3: Types of Errors and Power
#Question 16:
  #a) We are trying to test to see if less than 0.25 of people who take the
  #new medicine will experience symptoms. H0: p = 0.25, H1: p < 0.25

  #b) A type 1 error would be if we state that the amount of people who experience
  #symptoms is greater than or equal to 0.25 when it actually is less than 0.25

  #c) A type 2 error would be if we state that the amount of people who experience 
  #symptoms is less than 0.25 when it actually is greater than  or equal to 0.25

#Question 17:
  #a) We are trying to figure out if the mean number of calories in a casual restaurant
  #dinner salad is less than 1200 calories. H0: p = 1200, H1: p < 1200

  #b) the power is 0.5722671
  power.t.test(n = 32, sd = 250, sig.level = 0.08, delta = 100, alternative = "one.sided")  

  #c
    #i) the power is 0.3502184
    power.t.test(n = 32, sd = 250, sig.level = 0.025, delta = 100, alternative = "one.sided")  
  
    #ii) The power of sig.level of 0.08 is higher than the power of sig.level of
    #0.025
  
  #d
    #i) The significance level would be 0.3753447
    power.t.test(n = 32, sd = 250, sig.level = NULL, power = 0.9, delta = 100, alternative = "one.sided") 

    #ii) The significance level has to be much higher than the last two tests. 
    #Since the significance level was higher, so was the power. The power based on
    #significance level is 0.025 < 0.08 < 0.3753447
    
  #e
    #i) The would need 108 people to sample
    power.t.test(n = NULL, sd = 250, sig.level = 0.05, power = 0.9, delta = 100, alternative = "one.sided") 
    
    #ii) The sample size increased.

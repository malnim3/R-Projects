#Task 1: Data Frames Created
#Question 1:
#a: creating vector of different sizes
sizes <- c("Short", "Tall", "Grande", "Venti")

#b: creating vector of cost
cost <- c(3.75, 4.5, 6.25, 7.5)

#c: creating vector of calories
calories <- c(200, 280, 420, 700)

#d: combining vectors to create data frame
drinks<- data.frame(sizes, cost, calories)

#e: creating vector with new trenta values
trenta <- c("Trenta", 9.25, 950)

#f: adding trenta to data frame
drinks <- rbind(drinks, trenta)

#g: The only issue I find is that the calories should be a whole 
# number since none of the calories have decimal values.
# sizes = character
# cost = double
# calories = double
typeof(sizes)
typeof(cost)
typeof(calories)

#h: I am going to keep the data type of sizes and cost. I am keeping the 
# data type of sizes since sizes was of type characters and it holds the names
# drink sizes. I am keeping the data type of cost because it is of type double 
# and there are decimal values in the set. I am changing calories to integer 
# since none of the calories have decimal values.
calories <- as.integer(calories)

#Question 2:
#a: importing 2 files into r
nasdaq <- read.csv("C:/Users/haytr/Documents/STATS382/stocks_nasdaq.csv")
nyse <- read.csv("C:/Users/haytr/Documents/STATS382/stocks_nyse.csv") 

#b: NASDAQ rows = 72 columns = 14
# NYSE rows = 359 columns = 14
nrow(nasdaq)
ncol(nasdaq)
nrow(nyse)
ncol(nyse)

#c: verified both frames have same number of columns
# Since the output is true, they have the same number of columns
ncol(nasdaq) == ncol(nyse)

#d: combining data frame into one 
stocks <- rbind(nasdaq, nyse)

#Task 2: Cleaning and Formatting
#3 I decided to order Sector since there are common sectors in both NASDAQ and NYSE
# so it would be easier to compare the price, price earning, etc regardless of what
# exchange they are part of. 
stocks$Sector <- as.factor(stocks$Sector)
stocks$Exchange <-as.factor(stocks$Exchange)
stocks <- stocks[order(stocks$Sector),]

#4 Price.Earnings, Dividend.Yield, and Price.Book had NA's.
summary(stocks)

#5 Since the dividend yield represents the percent of a company's share price 
# they pay out in dividends each year, it would have to be some positive number
stocks$Dividend.Yield[stocks$Dividend.Yield == "NA"] <- "0.00"
stocks_divfix <- stocks

#6 Price book and Price earnings can be negative numbers so we can not assume 
# NA to be 0 because it could be lower than 0. 
stocks_clean <- subset(stocks_divfix, !Price.Earnings == "NA" & 
                         !Price.Book == "NA")
summary(stocks_clean)

#Task 3: Variable Creation and Subsetting
#7 Adding spread calculation
stocks_clean$spread<-stocks_clean$X52.Week.High - stocks_clean$X52.Week.Low

#8 
stocks_clean$Earnings_category[stocks_clean$Earnings.Share < "0"]<- "Loss"
stocks_clean$Earnings_category[stocks_clean$Earnings.Share >= "0" &
                                stocks_clean$Earnings.Share < "3"]<- "Small"
stocks_clean$Earnings_category[stocks_clean$Earnings.Share <= "3"
                              & stocks_clean$Earnings.Share < "10"]<- "Good"
stocks_clean$Earnings_category[stocks_clean$Earnings.Share <= "10"]<- "Strong"

#9
dividends <- stocks_clean[!stocks_clean$Dividend.Yield =="0", ]
dividends <-cbind(Symbol = stocks_clean$Symbol, Name = stocks_clean$Name, 
                  Exchange = stocks_clean$Exchange,Sector = stocks_clean$Sector, 
                  Dividend.Yield = stocks_clean$Dividend.Yield)

#10 MarketCap_000 75th percentile is 49940483 
# EBITDA 75th percentile is 3930500000 
quantile(stocks_clean$MarketCap_000, 0.75)
quantile(stocks_clean$EBITDA, 0.75)

#11
big <- stocks_clean[stocks_clean$MarketCap_000 > "49940483" & 
                      stocks_clean$EBITDA > "3930500000", ]

#Task 4: Summaries
#12 Price Price.Earnings Dividend.Yield Earnings.Share   X52.Week.Low  X52.Week.High MarketCap_000s         EBITDA 
# 1.176616e+02   4.065634e+01             NA   5.387398e+00   1.364886e+02   8.600010e+01   9.681264e+07   7.361611e+09 
# Price.Sales     Price.Book         spread 
#3.555491e+00   9.698114e+01   5.412980e+01 
sapply(stocks_clean[,5:15 ], sd)

#13                       Group.1         x
#      Consumer Discretionary  46348621
#            Consumer Staples  58353428
#                      Energy  44331388
#                  Financials  59499341
#                 Health Care  60167870
#                 Industrials  38106064
#      Information Technology 114656106
#                   Materials  22202765
#                 Real Estate  18464833
# Telecommunication Services 151014248
#                  Utilities  21985371

aggregate(stocks_clean$MarketCap_000s, list(stocks_clean$Sector), FUN=mean)

#Task 5: Function creation and application
#14
quicksum <- function(x){
  print(c(min(x), max(x), mean(x)))
}

#15 I think I did something wrong with so an error is coming up for dividends 
# but that is how I would code it if I didn't mess it up
# For stocks_clean I got NA NA NA 
quicksum(stocks_clean$Dividend.Yield)
quicksum(dividends$Dividend.Yield)

#16 big data: Price.Earnings = -59.4600 520.1500  25.7727
#  dividend.yield = "0"    "7.71" NA 
#  Earnings.Share = -6.500000 30.300000  3.694286
# stocks_clean: Price.Earnings =  -251.53000  520.15000   23.84882
#  dividend.yield = NA NA NA
#  Earnings.Share =  -19.940000  44.090000   3.981371
tmp <- c(big$Price.Earnings)
sapply(tmp, quicksum)
tmp <- c(big$Dividend.Yield)
sapply(tmp, quicksum)
tmp <- c(big$Earnings.Share)
sapply(tmp, quicksum)

tmp <- c(stocks_clean$Price.Earnings)
sapply(tmp, quicksum)
tmp <- c(stocks_clean$Dividend.Yield)
sapply(tmp, quicksum)
tmp <- c(stocks_clean$Earnings.Share)
sapply(tmp, quicksum)

#Task 6: Bonus Loop
#1
n <- 21

#2
Fibonacci <- c(0,1)

#3
#4
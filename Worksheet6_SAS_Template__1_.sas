/* STAT 382 WORKSHEET 6 */
/* IMPORT DATASET */
TITLE 'IMPORT DATASET';

FILENAME REFFILE FILESRVC FOLDERPATH='/Users/malnim3@uic.edu/My Folder/worksheet6'  FILENAME='stocks_nyse2 (1).csv';
PROC IMPORT DATAFILE = REFFILE
	DBMS = CSV
	OUT = nyse2_;
	GETNAMES = YES;
RUN;
PROC CONTENTS DATA = nyse2_; RUN;

/* Task 1: Create a frequency table for the variable Sector */
TITLE 'TASK 1: Frequency Table for Sector';
PROC FREQ DATA = nyse2_;
	TABLES Sector;
RUN;

/* Task 2: Create a bar chart for the Sector showing how many companies
	are in each sector with labels. */
TITLE 'TASK 2: Bar Chart for Sector';
PROC SGPLOT DATA = nyse2_;
	VBAR Sector;
RUN;

/* Task 3: Compute the mean and median DividendYield by sector
	using one procedure statement. */
PROC SORT DATA= nyse2_ out = nyse2_;
	key Sector;
RUN;
TITLE 'TASK 3: Mean and Median DividendYield by Sector';
PROC MEANS DATA= nyse2_ median mean;
	VAR DividendYield;
	BY Sector;
RUN;
	
/* Task 4: Create a histogram for Price with labels. */
TITLE 'TASK 4: Histogram for Price';
PROC UNIVARIATE DATA= nyse2_;
	HISTOGRAM Price;
RUN;

/* Task 5: Create a boxplot for Price with labels. */
TITLE 'TASK 5: Boxplot for Price';
PROC SGPLOT DATA = nyse2_;
	VBOX Price;
RUN;
	
/* Task 6: Compute a 92% Confidence Interval for EarningsperShare */
TITLE 'TASK 6: 92% CI for Earnings Per Share';
	/* The 92% CI is:                */
PROC TTEST DATA = nyse2_ alpha=0.08;
	VAR EarningsperShare;
RUN;	

/* Task 7: Test the claim that the mean DividendYield is
	greater than 2 at a 3.5% significance level. */
TITLE 'TASK 7: DividendYield HT';

/* Hypotheses:
	H0: mu = 2
	H1: mu > 2
*/
* Code;	
PROC TTEST DATA = nyse2_ h0 = 2 sides=u plots;
	VAR DividendYield;
RUN;

/* 
P-value = 0.0125
Decision: reject h0
Conclusion: Since our p-value = 0.0125 < 0.035, this means there is enough evidence to suggest that 
the mean DividendYield  is greater than 2.
*/
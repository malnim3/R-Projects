/*  STAT 382 HOMEWORK 5 
	By: Mashel Al-Nimer*/

/* Task 1: Data Frame Creation */
TITLE1 "Task 1";
TITLE2 "Q1 Part a) Import Datasets";
FILENAME REFFILE FILESRVC FOLDERPATH='/Users/malnim3@uic.edu/My Folder/Homework5'  FILENAME='stocks_nasdaq2.csv';
PROC IMPORT DATAFILE = REFFILE
	DBMS = CSV
	OUT = nasdaq2;
	GETNAMES = YES;
RUN;
PROC CONTENTS DATA = nasdaq2; RUN;

FILENAME REFFILE2 FILESRVC FOLDERPATH='/Users/malnim3@uic.edu/My Folder/Homework5'  FILENAME='stocks_nyse2.csv';
PROC IMPORT DATAFILE = REFFILE2
	DBMS = CSV
	OUT = nyse2;
	GETNAMES = YES;
RUN;
PROC CONTENTS DATA = nyse2; RUN;

TITLE2 "Q1 Part b) Modify column formats";
DATA nyse2; *change the name to whatever you named your NYSE dataset;
	LENGTH Exchange $30 SYMBOL $30;
	FORMAT Exchange $30. SYMBOL $30.;
	SET nyse2; *change the name to whatever you named your NYSE dataset;
RUN;

DATA nasdaq2; *change the name to whatever you named your NASDAQ dataset;
	LENGTH Exchange $30 Symbol $30 Name $35;
	FORMAT Exchange $30. Symbol $30. Name $35.;
	SET nasdaq2; *change the name to whatever you named your NASDAQ dataset;
RUN;

TITLE2 "Q1 Part c) Combine NASDAQ and NYSE Datasets";
DATA stocks;
	SET nyse2 nasdaq2; 
RUN;
PROC CONTENTS DATA = stocks; RUN;

TITLE2 "Q1 Part d) Sort stocks by ascending Sector";
PROC SORT DATA = stocks OUT = stocksSorted;
	BY Sector;
RUN;
PROC CONTENTS DATA = stocksSorted; RUN;

TITLE2 "Q1 Part e) Create the dataset SectorVolatility";
DATA SectorVolatility;
	LENGTH Sector $ 22;
	LENGTH Sector_Volatility $ 30;
	INPUT Sector $ Sector_Volatility;
	DATALINES;
Materials Low
Information_Technology High
Consumer_Discretionary High
Health_Care Moderate
Consumer_Staples Moderate
Telecomm_Services High
Financials High
Industrials Low
Energy High
Utilities Moderate
Real_Estate Low
;
RUN;
PROC PRINT DATA = SectorVolatility; RUN;

TITLE2 "Q1 Part f) Sort SectorVolatility by ascending Sector";
PROC SORT DATA = SectorVolatility OUT = SectorVolatilitySorted;
	BY Sector;
RUN;
PROC CONTENTS DATA = SectorVolatilitySorted; RUN;

TITLE2 "Q1 Part g) Merge the stocks dataset and the SectorVolatility dataset to create stocks2";
DATA stocks2;
	MERGE stocks SectorVolatilitySorted; 
RUN;
PROC CONTENTS DATA = stocks2; RUN;

/* Task 2: Cleaning and Formatting */
TITLE1 "Task 2";
TITLE2 "Q2) Replace NA values for DividendYield with 0s in new dataset stocks_divfix";
PROC STDIZE DATA = stocks2 OUT = stocks_divfix
	reponly missing = 0;
	VAR DividendYield;
RUN;

TITLE2 "Q3) Remove rows for PricetoEarnings and PricetoBook that are NA. Do this in a new dataset called stocks_clean";
DATA stocks_clean;
	SET stocks_divfix;
	IF PricetoEarnings = . then DELETE;
	IF PricetoBook = . then DELETE;
RUN;

/* Task 3: Variable Creation and Subsetting */
TITLE1 "Task 3";
TITLE2 "Q4) Create a new variable called spread = FiftytwoWeekHigh - FiftytwoWeekLow";
DATA stocks_clean;
	SET stocks_clean;
	spread = FiftytwoWeekHigh - FiftytwoWeekLow;
RUN;

TITLE2 "Q5) Create a new variable called Earnings_category";
DATA stocks_clean;
	SET stocks_clean;
	LENGTH Earnings_category $ 6;
	IF EarningsperShare < 0 then Earnings_category = "Loss";
	IF EarningsperShare >= 0 AND EarningsperShare < 3 then Earnings_category = "Small";
	IF EarningsperShare >= 3 then Earnings_category = "Strong";
RUN;
PROC PRINT DATA = stocks_clean; RUN;

TITLE2 "Q6) Create dividends dataset";
DATA dividends;
	SET stocks_clean;
	KEEP Symbol Name Exchange Sector DividendYield;
	IF DividendYield = 0 then DELETE;
RUN;
*******************************
	Exam 2
	Name: Mashel Al-Nimer
	Version: 2
*******************************;
*******************************
******** Task 1: DATA *********
*******************************;

/* Question 1: Import Data */
TITLE "Q1: Import Data";
FILENAME REFFILE FILESRVC FOLDERPATH='/Users/malnim3@uic.edu/My Folder/Exam2'  FILENAME='bodyfatpredictors2.csv';
PROC IMPORT DATAFILE = REFFILE
	DBMS = CSV
	OUT = bodyfat;
	GETNAMES = YES;
RUN;
PROC CONTENTS DATA = bodyfat; RUN;

/* Question 2: Remove the rows that contain missing data (see PDF for column) */
TITLE 'Q2: Remove Missing Data';
DATA bodyfat_clean; 
	SET bodyfat;
	IF Waist = . THEN DELETE;
RUN;

/* Question 3: Create a new character variable WeightGroup */
TITLE 'Q3: Create WeightGroup';
DATA bodyfat_clean;
	SET bodyfat_clean;
	LENGTH WeightGroup $ 6;
	IF Weight < 160 THEN WeightGroup = "Lower";
	IF Weight >= 160 AND Weight < 198 THEN WeightGroup = "Middle";
	IF Weight >= 198 THEN WeightGroup = "Upper";
RUN;

/* Question 4: Create a new variable called Ratio */
TITLE 'Q4: Create Ratio';
DATA bodyfat_clean;
	SET bodyfat_clean;
	Ratio = Waist/ Wrist;
RUN;

/* Question 5: Create a New Dataset called High_Ratio and Print it */
TITLE 'Q5: Create Dataset High_Ratio';
DATA High_Ratio;
	SET bodyfat_clean;
	KEEP PctBF Weight Waist Wrist;
	IF Ratio <= 2 THEN DELETE;
PROC PRINT DATA = High_Ratio; RUN;

************************************************
******** Task 2: INTRODUCTORY ANALYSIS *********
************************************************;

/* Question 6: Compute values of sample mean / median / std dev / IQR */
TITLE 'Q6: Summary Statistics';
PROC UNIVARIATE DATA = bodyfat ;
	VAR Wrist;
RUN;

/* Question 7: Histogram with density kernel */
TITLE 'Q7: Histogram with Density Kernel';
PROC UNIVARIATE DATA = bodyfat;
	HISTOGRAM PctBF;
RUN;
	
/* Question 8: Bar Chart */
TITLE 'Q8: Bar Chart';
PROC SGPLOT DATA = bodyfat;
	VBAR AgeGroup;
RUN;

/* Question 9: Boxplot from High_Ratio Dataset */
TITLE 'Q9: Boxplot';
PROC SGPLOT DATA = High_Ratio;
	VBOX Weight;
RUN;

	* Are there outliers? Yes there are outliers.

************************************************
******** Task 3: INFERENCE *********************
************************************************;
TITLE 'TASK 3 (Q10, Q11): Inference';
PROC TTEST DATA=bodyfat alpha=0.01 H0=0 SIDES=2;
	CLASS AgeGroup;
	VAR PctBF;
RUN;
	/* Question 10: Variance Testing */
	/* 	Hypotheses
			H0: variance is equal
			H1: variance is not equal
		Test Statistic: 1.16
		P-Value: 0.4225
		Decision: We do not reject h0
		Conclusion: We have enough evidence that the variances are equal
	*/	
	
	/* Question 11: Mean Testing */
	/*	Hypotheses
			H0: d = 0
			H1: d != 0
		Test Statistic: 2.55
		P-Value: 0.0112
		Decision: 0.0112 not less than 0.01 so we do not reject h0
		Conclusion: There is not enough evidence that the means between PctBF values of young people
		and older people are different. 
	*/
			
************************************************
******** Task 4: REGRESSION ********************
************************************************;
TITLE 'Q12: Multiple Linear Regression';
PROC REG DATA=bodyfat ALPHA= 0.04;
	MODEL PctBf = Wrist Waist ;
RUN;
QUIT;

/*
Part a - Check model assumptions
	Linearity
		Plot / Result used:
		Is it met or not? Yes it is met
		
	Normality
		Plot / Result used:
		Is it met or not? Yes it is met

	Equal Variance
		Plot / Result used:
		Is it met or not? Yes it is met

Part b - Give the equation of the MLR line
-11.10016 + -2.33628 * Wrist - 11.10016	+ 2.00097 * Waist
		
Part c - Does the model in total explain variability in PctBF?
	Hypotheses
		H0: none of the varibles are useful when predicting PctBf
		H1: at least 1 of the varibles is useful when predicting PctBf
	Test Statistic: 306.18
	P-Value: 0.0001
	Decision: reject h0
	Conclusion: There is enough evidence that suggests that at least 1 of the 
	varibles is useful when predicting PctBf

Part d (if needed. if not needed, state why)
	Testing Individual Variables (Variable 1)
		Hypotheses
			H0: beta_Wrist = 0
			H1: beta_Wrist != 0
		Test Statistic: -6.03	
		P-Value: <.0001
		Decision: reject h0
		Conclusion: There is enough evidence that suggests Wrist explains some
		variability in PctBf  	
		
	Testing Individual Variables (Variable 2)
		Hypotheses
			H0: beta_Waist = 0
			H1: beta_Waist != 0
		Test Statistic: 22.78
		P-Value: <.0001
		Decision: reject ho
		Conclusion: There is enough evidence that suggests Waist explains some
		variability in PctBf  
			
Part e - Value of R^2 and interpretation
	R^2: 0.7167
	Interpretation: 71.67% of PctBf can be predicted from Wrist and Waist values.

*/
		
************************************************
******** Task 5: 1-way ANOVA *******************
************************************************;
TITLE 'Q13: 1-Way ANOVA';
TITLE2 'Part a: Mean Percent Body Fat for each Category';
PROC MEANS DATA=bodyfat mean;
	VAR PctBF;
	By ForearmCategory;
RUN;
	/* 	Detail any difference by category.	
	Lower has the smallest mean, Upper has the highest mean, and Middle has a mean larger 
	than Lower but a lower mean than Upper.
	*/
	
TITLE2 'Part b: Side by Side Boxpots';
PROC SGPLOT DATA = bodyfat;
	VBOX PctBF/category=ForearmCategory;
RUN;
	/* 	Detail any difference by category.
	The mean PctBF Lower < Middle < Upper.
	Middle has an outlier.
	Lower and Upper have a larger range than Middle.
	*/

TITLE2 'Part c: Run a 1-way ANOVA model';
PROC GLM data= bodyfat alpha=0.035;
	class ForearmCategory;
	model PctBF = ForearmCategory;
	means ForearmCategory / BON TUKEY CLDIFF HOVTEST = LEVENE ;
	OUTPUT OUT = result13 r = residual;
RUN;

TITLE2 'Part d: Normality Test';
PROC UNIVARIATE data=result13 NORMAL Plot;
	Var residual;
RUN;
/* Conclusions for Normality:
	0.1032 > 0.05 so its normal.
	Yes it is met.
*/

	
TITLE2 'Part e: Equal Variance Assumption Check';
/* Conclusions for Equal Variance:
	Yes it is met.
*/

TITLE2 'Part f: Is there a significant evidence of an effect?';
/*	Hypotheses
		H0: all of the PctBF are the same 
		H1: at least one of the PctBF is different 
	Test Statistic: 21.67	
	P-Value: <.0001
	Decision: reject h0
	Conclusion: There is enough evidence that suggests on of the ForearmCategory
	PctBf values is different.  
*/


TITLE2 'Part g: Bonerroni or Tukey Intervals';
/*
	INTERVALS USED: Bonferroni
	
	Confidence Intervals for each pair of differences:
		Lower / Mid: (0.1520, 7.3401)
		Lower / Upper:(-9.7252, -4.2958)
		Mid / Upper: (-0.4597, 6.9886)

	State whether there is a significant difference or not
	for each pair of differences:
		Lower / Mid: Yes
		Lower / Upper: Yes
		Mid / Upper: No
	
*/

TITLE;
TITLE2;
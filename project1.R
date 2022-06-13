#Task 1
cps_pp <- read.csv("C:/Users/haytr/Documents/STATS382/CPS_ProgressReport_2011-2012.csv")
cps_pp$Family_Involvement_Score[cps_pp$Family_Involvement_Score == "NA"] <- 0.00
hist(cps_pp$Family_Involvement_Score, xlab = "Family_Involvment_Score", 
     main = "Family Involvment Score")
boxplot(cps_pp$Family_Involvement_Score)

cps_pp$Rate_of_Misconducts[cps_pp$Rate_of_Misconducts  == "NA"] <- 0.00
hist(cps_pp$Rate_of_Misconducts, xlab = "Rate_Of_Misconducts",
     main = "Rate Of Misconducts")
boxplot(cps_pp$Rate_of_Misconducts)
median(cps_pp$Rate_of_Misconducts)

#Task 2
school_type<-subset(cps_pp, Elementary_Middle_High_School !="NA" )
barplot(table(school_type$Elementary_Middle_High_School))

 schoopolicy_status <- subset(cps_pp, CPS_Performance_Policy_Status != "Not Applicable" &
                                CPS_Performance_Policy_Status != "")
barplot(table(policy_status$CPS_Performance_Policy_Status))

policy_level <- subset(cps_pp, CPS_Performance_Policy_Level != "Not Enough Data" &
                               CPS_Performance_Policy_Level != "")
barplot(table(policy_level$CPS_Performance_Policy_Level))

#Task 3
att_es <- subset(cps_pp, Elementary_Middle_High_School == "ES")
att_ms <- subset(cps_pp, Elementary_Middle_High_School == "MS")
att_hs <- subset(cps_pp, Elementary_Middle_High_School == "HS")

studentES <- summary(att_es$Average_Student_Attence)
studentMS <- summary(att_ms$Average_Student_Attence)
studentHS <- summary(att_hs$Average_Student_Attence)
teacherES <- summary(att_es$Average_Teacher_Attence)
teacherMS <- summary(att_ms$Average_Teacher_Attence)
teacherHS <- summary(att_hs$Average_Teacher_Attence)

                 
boxplot(studentES, teacherES,
        studentHS, teacherHS,
        studentMS, teacherMS,
        names = c("Student ES","Teacher ES",
                  "Student MS","Teacher MS",
                  "Student HS","Teacher HS"))

#Task 4
high_school_data <- subset(att_hs, Graduation_Rate != "NA" &
                             Parent_Engagement_Score != "NA")
hist(high_school_data$Graduation_Rate, main="Graduation Rate of High Schoolers"
     ,xlab = "Graduation Rate")
boxplot(high_school_data$Graduation_Rate)
median(high_school_data$Graduation_Rate)
sd(high_school_data$Graduation_Rate)

hist(high_school_data$Parent_Engagement_Score, main="Parent Engagement of High
     Schoolers", xlab = "Parent Engagement")
boxplot(high_school_data$Parent_Engagement_Score)
mean(high_school_data$Parent_Engagement_Score)
sd(high_school_data$Parent_Engagement_Score)      

#Task 5
high_school_data$Graduation_Rate_Tier[high_school_data$Graduation_Rate < 50]<-"Low"
high_school_data$Graduation_Rate_Tier[high_school_data$Graduation_Rate >= 50
                                      & high_school_data$Graduation_Rate < 75]<-"Middle"
high_school_data$Graduation_Rate_Tier[high_school_data$Graduation_Rate >= 75]<-"High"        
Graduation_Rate_Tier <- data.frame(high_school_data$Graduation_Rate_Tier)
barplot(table(Graduation_Rate_Tier), main="Graduation Rate Tier Of High Schoolers",
        xlab="Likely to Graduate", ylab="Number of Students")

#Task 6
lvl1 <- subset(high_school_data, CPS_Performance_Policy_Level == "Level 1")
lvl2 <- subset(high_school_data, CPS_Performance_Policy_Level == "Level 2")
lvl3 <- subset(high_school_data, CPS_Performance_Policy_Level == "Level 3")
school_lvl1 <- (lvl1$Graduation_Rate_Tier)
school_lvl2 <- (lvl2$Graduation_Rate_Tier)
school_lvl3 <- (lvl3$Graduation_Rate_Tier)
barplot(table(school_lvl1), main = "Level 1 HS Graduation Rate Tier")
barplot(table(school_lvl2), main = "Level 2 HS Graduation Rate Tier")
barplot(table(school_lvl3), main = "Level 3 HS Graduation Rate Tier")

#Task 7
tmp <- subset(cps_pp, Students_Passing_Algebra != "NA")
hist(tmp$Students_Passing_Algebra)
qqplot(c(0:100), tmp$Students_Passing_Algebra)
shapiro.test(tmp$Students_Passing_Algebra) #p-value = 0.02852

tmp2 <- subset(cps_pp, Parent_Engagement_Score != "NA")
hist(tmp2$Parent_Engagement_Score)
qqplot(c(0:100), tmp2$Parent_Engagement_Score)
shapiro.test(tmp2$Parent_Engagement_Score) #p-value = 1.789e-08



clear all
cd "C:\Users\LENOVO\OneDrive\Desktop\econometrics assignment"
log using "Question 2 Anumoy Modak.smcl", replace
use "dataset.dta" , clear

des

reg nos_Child18 educ* Age fp noscm

estat hettest 
***Test of Heteroskadesticity: H0 is rejected***

***QUESTION 2: PART A [Explanetions in doc file]***


***QUESTION 2: PART B***

reg nos_Child18 educ_female educ_female_Old Age fp noscm [aweight=Combined_Multiplier]

***QUESTION 2: PART C***

destring Religion SCGRP State_code , replace 

*Now we can run regression
reg nos_Child18 educ_female educ_female_Old Age fp noscm i.Religion i.SCGRP i.State_code [aweight=Combined_Multiplier]

***QUESTION 2: PART D [poisson Regression]***


poisson nos_Child18 educ_female educ_female_Old Age fp noscm [pweight=Combined_Multiplier]

***QUESTION 2: PART E***

*Now repeating with robust standard errors
 *[A]*
reg nos_Child18 educ_female educ_female_Old Age fp noscm ,vce(robust)

 *[B]*
reg nos_Child18 educ_female educ_female_Old Age fp noscm [aweight=Combined_Multiplier], vce(robust)

 *[C]*
reg nos_Child18 educ_female educ_female_Old Age fp noscm i.Religion i.SCGRP i.State_code [aweight=Combined_Multiplier], vce(robust)

 *[D]*
poisson nos_Child18 educ_female educ_female_Old Age fp noscm [pweight=Combined_Multiplier], vce(robust)

log close
translate "Question 2 Anumoy Modak.smcl" "Question 2 Anumoy Modak.pdf", replace
view "Question 2 Anumoy Modak.smcl"

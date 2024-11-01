clear all
cd "C:\Users\LENOVO\OneDrive\Desktop\econometrics assignment"
use "dataset_endogenity_forstudents_2023", clear 
log using "Question 1 Anumoy Modak.smcl" , replace  
/*
Roll No: ME22002
name: Anumoy Modak
School : School of Economics , Xavier University , Bhubaneshwar.
*/

**QUESTION 1: PART A**

***** Haushman's test ******
reg y y2 x1 x2
estimates store efficient

****run IV 2SLS regression****
ivregress 2sls y x1 x2 (y2 = z1 z2)


estimates store consistent
hausman consistent efficient
/* H0: efficient = consistent (iv_coefficient and OLS_coefficient are 
       asymptotically equal)
   H1: efficient not equal to consistent 
   */
   
**QUESTION 1: PART B**

**** Run 1st stage SLS ****

reg y2 x1 x2 z1 z2
predict y2_hat 
predict v_hat , resid

***run 2sls***
reg y x1 x2 y2_hat

***OR***
gen y2_minus_vhat = (y2 - v_hat)
dis (y2 - v_hat)

***now 2sls***
reg y y2_minus_vhat x1 x2

**QUESTION 1: PART C**
reg y2 z1 z2 x1 x2
test z1=z2=0

**QUESTION 1: PART D (Test of Exogenety)** 
ivregress 2sls y x1 x2 (y2 = z1 z2)
estat overid
predict u_hat_2sls, resid
reg u_hat_2sls x1 x2 z1 z2
test z1=z2=0

log close 
translate "Question 1 Anumoy Modak.smcl" "Question 1 Anumoy Modak.pdf" , replace

view "Question 1 Anumoy Modak.smcl"

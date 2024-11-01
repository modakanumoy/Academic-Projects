cd "C:\Users\LENOVO\OneDrive\Desktop\Time_Series_Econometrics_Assignment"
use assignments_2, clear
log using "Time_Series_Econometrics_Assignment.smcl" , name(assignments_2) replace
tsset t


***Ploting variable xit.views regarding stationarity*****

foreach x of varlist x* {
tsline `x'
graph export `x'stationarity_Analysis.png, as(png) replace
}

/*****Checking whether xit is stationary or not using Dicky Fuller and
 Elliot Rothenberg and Stock(DFGLS) tests statistics.
*/

**Dicky-fuller test using x4t**

reg D.x4t L.x4t
reg x4t t
predict x4t_trendless, resid

reg D.x4t_trendless L.x4t_trendless 



foreach var of varlist x*{
*For x`var't*

varsoc `var', maxlag(10)
}

*PART 1:(Augmented Dicky Fuller test)*
dfuller x1t, regress trend lags(1)
dfuller x1t,  regress lags(1)
dfuller x2t, regress trend lags(1)
dfuller x2t,  regress lags(1)
dfuller x3t, regress trend lags(0)
dfuller x3t,  regress lags(0)
dfuller x4t, regress trend lags(6)
dfuller x4t,  regress lags(6)
dfuller x5t, regress trend lags(1)
dfuller x5t,  regress lags(1)
dfuller x6t, regress trend lags(10)
dfuller x6t,  regress lags(10)
dfuller x7t, regress trend lags(2)
dfuller x7t,  regress lags(2)
dfuller x8t, regress trend lags(1)
dfuller x8t,  regress lags(1)
dfuller x9t, regress trend lags(6)
dfuller x9t,  regress lags(6)
dfuller x10t, regress trend lags(9)
dfuller x10t,  regress lags(9)


 foreach var of varlist x*{
*PART 2: (GLS-Augmented Dicky Fuller test)*
dfgls `var'

/**PART 3: Exponential trends**
dis "Using log values, we can check if log of `var' is stationary "
gen ln`var' = ln(`var')
dfuller ln`var', trend*/
}

**Further study of x5t and x6t**

dis "Using log values, we can detrend these Series and turn them stationary"
gen ln_x5t = ln(x5t) 
gen ln_x6t = ln(x6t*(-1))
varsoc x5t, maxlag(10)
dfuller ln_x5t,  regress lags(1)
dfuller ln_x5t, trend regress lags(1)
dfgls ln_x5t

varsoc x6t, maxlag(10)
dfuller ln_x6t,  regress lags(10)
dfuller ln_x6t, trend regress lags(10)
dfgls ln_x6t
tsline ln_x5t
graph export Ln-x5tstationarity_Analysis.png, as(png) replace
tsline ln_x6t
graph export Ln-x6tstationarity_Analysis.png, as(png) replace
log close assignments_2
translate Time_Series_Econometrics_Assignment.smcl Time_Series_Econometrics_Assignment.pdf	

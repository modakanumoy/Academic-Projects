cd "C:\Users\LENOVO\OneDrive\Desktop\Crime_GDP_relationship\Analysis"
log using Crime_GDP_relation_analysis.smcl, replace

use CrimeGDPData.dta, clear
tsset Year

***Summary Statistics (Mean, Median, Standerd Deviation, Kurtosis, Skewness)***

su Violent Murder Robbery Theft us_gdp_percapita, detail

***checking Stationarity (Dicky-Fuller DFGLS)****

 foreach var of varlist Total_Crime Violent Property Murder Robbery Aggravated_assault Burglary Larceny_Theft Theft us_gdp_total us_gdp_percapita {
*For x`var't*
dis "_________________________"
dis "VARSOC FOR VARIABLE `var'"
dis "_________________________"  
varsoc `var', maxlag(8) sep(1)
}

foreach var of varlist  Total_Crime Violent Property Murder Robbery Aggravated_assault Burglary Larceny_Theft Theft us_gdp_total us_gdp_percapita {

dis "_________________________"
dis "VARSOC FOR VARIABLE `var'"
dis "_________________________"  
varsoc D.`var', maxlag(8) sep(1)

}
dis "__________END of VARSOC__________"

dis "Tests of Stationarity"
dis "Dickey Fuller test"
dfuller Total_Crime , regress trend lags(6)
dfuller Total_Crime ,  regress lags(6)
dfuller Violent , regress trend lags(5)
dfuller Violent ,  regress lags(5)
dfuller Property , regress trend lags(6)
dfuller Property ,  regress lags(6)
dfuller Murder , regress trend lags(2)
dfuller Murder ,  regress lags(2)
dfuller Robbery , regress trend lags(3)
dfuller Robbery ,  regress lags(3)
dfuller Aggravated_assault , regress trend lags(5)
dfuller Aggravated_assault ,  regress lags(5)
dfuller Burglary , regress trend lags(6)
dfuller Burglary ,  regress lags(6)
dfuller Larceny_Theft , regress trend lags(6)
dfuller Larceny_Theft ,  regress lags(6)
dfuller Theft , regress trend lags(2)
dfuller Theft ,  regress lags(2)
dfuller us_gdp_total , regress trend lags(3)
dfuller us_gdp_total ,  regress lags(3)
dfuller us_gdp_percapita,  regress trend lags(3)
dfuller us_gdp_percapita,  regress lags(3)



dfuller D.Total_Crime , regress trend lags(5)
dfuller D.Total_Crime ,  regress lags(5)
dfuller D.Violent , regress trend lags(1)
dfuller D.Violent ,  regress lags(1)
dfuller D.Property , regress trend lags(5)
dfuller D.Property ,  regress lags(5)
dfuller D.Murder , regress trend lags(1)
dfuller D.Murder ,  regress lags(1)
dfuller D.Robbery , regress trend lags(2)
dfuller D.Robbery ,  regress lags(2)
dfuller D.Aggravated_assault , regress trend lags(2)
dfuller D.Aggravated_assault ,  regress lags(2)
dfuller D.Burglary , regress trend lags(5)
dfuller D.Burglary ,  regress lags(5)
dfuller D.Larceny_Theft , regress trend lags(5)
dfuller D.Larceny_Theft ,  regress lags(5)
dfuller D.Theft , regress trend lags(2)
dfuller D.Theft ,  regress lags(2)
dfuller D.us_gdp_total , regress trend lags(7)
dfuller D.us_gdp_total ,  regress lags(7)
dfuller D.us_gdp_percapita, regress trend lags(1)
dfuller D.us_gdp_percapita,  regress lags(1)

****checking for stationarity using DFGLS test******

foreach var of varlist Total_Crime Violent Property Murder Robbery Aggravated_assault Burglary Larceny_Theft Theft us_gdp_total us_gdp_percapita {
*For x`var't*
dis "_________________________"
dis "DFGLS FOR VARIABLE `var'"
dis "_________________________"  
dfgls `var'
}

foreach var of varlist Total_Crime Violent Property Murder Robbery Aggravated_assault Burglary Larceny_Theft Theft us_gdp_total us_gdp_percapita {
*For x`var't*
dis "_________________________"
dis "DFGLS FOR DIFFERENCE OF VARIABLE `var'"
dis "_________________________"  
dfgls D.`var'
}

/*Stationary Variables according to Tests.
Dickey Fuller and DFGLS: 

1)D.Violent 		: at lag 1 with and without trend at 5%
2)D.Murder   		: at lag 1 with and without trend at 1%
3)D.Robbery         : at lag 2 with             trend at 1%
4)D.Theft           : at lag 2 with and without trend at 5%
5)D.us_gdp_percapita: at lag 1 with             trend at 1%

*/ 

****Detrending the above variables and testing for ARCH (Auto-Regressive Conditional Heteroskadesticity)*****

foreach var of varlist  Violent Murder Robbery Theft us_gdp_percapita {
*For x`var't*
dis "_________________________"
dis "DETRENDING OF CHOSEN VARIABLE `var'"
dis "_________________________" 
quietly regress D.`var' Year
predict DETRENDED_D`var', resid  
dfgls DETRENDED_D`var'
quietly regress DETRENDED_D`var'
estat archlm,lags(1,2)

}



***Plotting the grapgh Trended and DTRENDED data***


foreach var of varlist  Violent Murder Robbery Theft us_gdp_percapita {


dis "_________________________"
dis "TS-Graph FOR VARIABLE `var'"
dis "_________________________"  
tsline `var'
graph export `var'.png, as(png) replace

dis "_________________________"
dis "TS-Graph FOR VARIABLE D.`var'"
dis "_________________________"  
tsline D.`var'
graph export D`var'.png, as(png) replace

dis "_________________________"
dis "TS-Graph FOR VARIABLE Detrended`var'"
dis "_________________________"  
tsline DETRENDED_D`var'
graph export DETRENDED_D`var'.png, as(png) replace
}


/*There is no ARCH effect so we will use AR Specification in VAR model
*/
var  DETRENDED_Dus_gdp_percapita DETRENDED_DViolent , lags(1) noconstant
irf create Practice, set(Irf_Practice) replace
irf graph irf, impulse(DETRENDED_Dus_gdp_percapita) response(DETRENDED_DViolent)
graph export DETRENDED_DViolent.png, as(png) replace


var  DETRENDED_Dus_gdp_percapita DETRENDED_DMurder, lags(1)
irf create Practice, set(Irf_Practice2) replace
irf graph irf, impulse(DETRENDED_Dus_gdp_percapita) response(DETRENDED_DMurder)
graph export DETRENDEDDMurder.png, as(png) replace 


var  DETRENDED_Dus_gdp_percapita DETRENDED_DRobbery, lags(2) 
irf create Practice, set(Irf_Practice3) replace
irf graph irf, impulse(DETRENDED_Dus_gdp_percapita) response(DETRENDED_DRobbery)
graph export DETRENDEDDRobbery.png, as(png) replace 


var  DETRENDED_Dus_gdp_percapita DETRENDED_DTheft, lags(2)
irf create Practice, set(Irf_Practice4) replace
irf graph irf, impulse(DETRENDED_Dus_gdp_percapita) response(DETRENDED_DTheft)
graph export DETRENDEDDTheft.png, as(png) replace 




log close 

translate Crime_GDP_relation_analysis.smcl Crime_GDP_relation_analysis.pdf, replace


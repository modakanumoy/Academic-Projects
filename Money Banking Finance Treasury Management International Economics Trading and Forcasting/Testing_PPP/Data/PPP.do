clear all
cd "C:\Users\\`c(username)'\Desktop\IETF\PPP Project\Data"
*use "PPPandCPI.dta", replace
log using PPPandCPI.smcl, replace 
import excel "C:\Users\Spandan\Desktop\IETF\PPP Project\Data\Data.xlsx", sheet("Sheet2") firstrow clear
tsset Year
 
foreach var in GermanyCPI UnitedKingdomCPI IndiaCPI JapanCPI ThailandCPI SwitzerlandCPI{
*dis "DFullerTEST for `var'", 
*dfuller `var'
gen rel_USD`var' = (D.UnitedStatesCPI - D.`var')/(1 + D.`var') 
}

/*foreach var in GermanyEX UnitedKingdomEX IndiaEX JapanEX UnitedStatesEX{
gen chgUSD`var' = (1/`var') 
gen USD`var' = D.chgUSD`var'
}*/

/*reg GermanyEX  rel_USDGermanyCPI 
reg UnitedKingdomEX  rel_USDUnitedKingdomCPI 
reg IndiaEX  rel_USDIndiaCPI 
reg JapanEX rel_USDJapanCPI
reg SwitzerlandEX rel_USDSwitzerlandCPI 
reg ThailandEX  rel_USDThailandCPI*/

tabstat rel_* *EX, s(me sd sk ku)

foreach var in Germany UnitedKingdom India Japan Switzerland Thailand{
reg `var'EX  rel_USD`var'CPI
tsline `var'EX  rel_USD`var'CPI
graph export `var'.png , as(png) replace
}

/*tsline GermanyEX  rel_USDGermanyCPI 

graph export GermanyEX , as(png) replace

tsline UnitedKingdomEX  rel_USDUnitedKingdomCPI
graph export UnitedKingdomEX , as(png) replace
tsline IndiaEX  rel_USDIndiaCPI 
graph export IndiaEX , as(png) replace
tsline JapanEX rel_USDJapanCPI
graph export JapanEX , as(png) replace

tsline SwitzerlandEX rel_USDThailandCPI
graph export SwitzerlandEX , as(png) replace
tsline ThailandEX  rel_USDSwitzerlandCPI
graph export ThailandEX , as(png) replace*/
log close
translate PPPandCPI.smcl PPPandCPI.pdf

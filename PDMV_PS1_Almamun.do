
********************************************************************************
*** Title:Problem set 1  
*** Kawsar Almamun
*** Matriculation no: K11947755 , date: 29.10.2023
********************************************************************************

// Exercise I : 

** Folder_name_PDMV_(Programming, Data Management and Visualization)(https://www.dropbox.com/home/kawsar%20almamun/PDMV%20(%20Programming%2C%20Data%20Management%20and%20Visualization)?di=left_nav_browse) 
** Sub_folder_Data_set(https://www.dropbox.com/home/kawsar%20almamun/PDMV%20(%20Programming%2C%20Data%20Management%20and%20Visualization)/Data%20sets?di=left_nav_browse)
** Sub_folder_Log_files(https://www.dropbox.com/home/kawsar%20almamun/PDMV%20(%20Programming%2C%20Data%20Management%20and%20Visualization)/Log%20Files?di=left_nav_browse)

pwd
cd "C:/Users/kawsa/Documents/Economic and Business Analytics/Programming, data management and visualization" 
clear all
set more off, perm 

capture log close
log using "PDMV_PS1_Almamun.log", replace text 
disp "DateTime: $S_DATE $S_TIME"

use "C:/Users/kawsa/Documents/Economic and Business Analytics/Programming, data management and visualization/Problem_set_1/pdmv_sl.dta", clear

*** Folder structure
********************************************************************************
cap mkdir data_set
cap mkdir Log_files
set seed 1234

*******************************OR***************************************************

*** Data files
*******************************************************************************

// Directories
global stata_files "C:/Users/kawsa/Documents/Economic and Business Analytics/Programming, data management and visualization"

// Open the data-set
use "$stata_files/Problem_set_1/pdmv_sl.dta", clear


// Exercise II: 
describe
** Different types of variables are stored like String, Int, Float ect. But we use the following command then we will get the specific variables  
ds, has(type string)
** id_GP   gp_sex are string variables. 
ds, has (type int) 
** These are ordinal numeric variables : sl_start  sl_end    e_start   e_end     e_tenure 
ds, has (type float) 
** p_age    e_exper are float variables. 

//Generate a new variable e_highwage that is equal to 1 if e_wage is above its median, and 0 else.
// First I would like to show the summarize then I will create a new variable.  
summarize e_wage, detail
gen e_highwage = (e_wage > r(p50))
// The median (50th percentile) which is stored in r(p50)
// to see the result, we will use this command 
fre e_highwage,nolabel

// This command creates a new binary or dummy variable (e_highwage). This variable gives us a value of 1 for observations 
// where e_wage is greater than the median wage, and 0 otherwise. (0)Indicates that wage(e_wage)is below the median wage.
// (1) indicates that the wage (e_wage) is above the median wage. 
// The total observations is 322375. Half of the observations (50.00% or 161,187 observations) have wages that are equal to or below the median wage.
// The other half (50.00% or 161,188 observations) have wages that are above the median wage.


// Exercise III (a): 

// Convert f_industry to a string variable using decode
decode f_industry, generate(f_industry_str)
// Extract the First Letter:
gen f_industry_letter = substr(f_industry_str, 1, 1)
// Convert the First Letter to Numeric:
encode f_industry_letter, generate(f_sector)
fre f_sector, missing
// List the First 5 Observations:
list f_industry f_industry_letter f_sector in 1/5

// Exercise III(b) : 
// Generate two variables sl_summer and sl_winter
gen month_sl_start = month(sl_start)
gen sl_summer = (month_sl_start >= 6 & month_sl_start <= 8)
gen sl_winter = (month_sl_start == 12 | month_sl_start <= 2)
tab sl_summer,nolabel
tab sl_winter, nolabel
list sl_start month_sl_start sl_summer sl_winter in 1/10
** we can see from the result that we got dummy variable (0 and 1). 0 indicates did not happen and 1 indicate happen. 
** 17.78% sick leaves occur in summer time. As well as 31.26% sick leaves happen in winter.  


// Exercise III(C): 

* Calculate the approximate birth year
gen birth_year = year(sl_start) - p_age

* Deduct age in days from the sick leave start date to get an accurate birth date
gen birth_date_temp = sl_start - (p_age * 365.25)
// I used 365.25 days per year as an average, considering the leap year.

* Convert this date to a month-year format
gen birth_date = ym(year(birth_date_temp), month(birth_date_temp))

* Format the birth_date variable
format birth_date %tm

* Display the frequency table for the birth_date
tab birth_date, nolabel

// Exercise IV : 
// I shared my codes with Michal Jeznach. I got the same results but the codes are different and in some cases, it seems similar but not exact. 
// I just compared to result and to be honest, I did not find any mistakes.    

****************************************************************************************************
disp "DateTime: $S_DATE $S_TIME"
log close

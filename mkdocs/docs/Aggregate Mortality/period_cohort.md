# Period and Cohort Rates

All of the analysis performed after mortality rate completion, such as survival function 
creation and transformation, output of summary statistics can be performed on both period
and cohort mortality rates. In fact, mortality rates are often presented in a period format but
cohort rates are more suitable for the pricing of insurance products. Thus, this module introduces
2 helper functions to convert between period and cohort mortality rates. 

---

### Period to Cohort Rates

**period2cohort <- function(period_rates, ages, init_age = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; period_rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *period mortality rates with age rows, calendar year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `period_rates`*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age of cohort (default smallest age)*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of cohort mortality rates with age rows,
cohort columns 

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'

period_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110

# convert to rates for cohort aged 55

cohort_rates_55 <- period2cohort(period_rates, ages, init_age = 55)
```

---

### Cohort to Period Rates

**cohort2period <- function(cohort_rates)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; cohort_rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cohort mortality rates with age rows, cohort columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of period mortality rates with age rows,
year columns 

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the Kannisto completion method on male mortality rates
# from the data file 'mortality_AUS_data'

AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130
fitted_ages <- 76:90

completed_rates <- complete_old_age(AUS_male_rates, ages, old_ages,
                                    method = "kannisto", type = "central",
                                    fitted_ages = fitted_ages)

# suppose these are rates for cohort starting at age 60

cohort_rates_60 <- completed_rates[as.character(60:130), ]

period_rates <- cohort2period(cohort_rates)
```








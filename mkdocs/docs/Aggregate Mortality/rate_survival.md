# Mortality Rate and Survival Function

The age completion functions usually return mortality rates. However, part of the functionality
of this module is converting the real world probability based survival function to a risk free probability
measure survival function. This requires the mortality rates to be converted to survival 
probabilities. 

This functionality is covered by 2 helper functions.

---

### Mortality Rate to Survival Function

**rate2survival(rates, ages, from = 'prob', init_age = NULL, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, cohort/year columns

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; from : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *type of rate to be converted from: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age for survival function to be calculated at (default smallest age)*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of associated survival function with survival time rows,
cohort/year columns

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


# compute survival function of an individual aged 55
all_ages <- 0:130
surv_func <- rate2survival(completed_rates, ages = all_ages,
                           from = 'central', init_age = 55)
```

---

### Survival Function to Mortality Rate

**survival2rate(surv, ages, to = 'prob', years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *survival function with survival time rows,
cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of desired ages for the resulting mortality rates*

&nbsp;&nbsp;&nbsp;&nbsp; to : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *type of rate to be converted to: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `surv`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of associated mortality rates with age rows, cohort/year columns

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# create survival function for an individual aged 55
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130
fitted_ages <- 76:90

completed_rates <- complete_old_age(AUS_male_rates, ages, old_ages,
                                    method = "kannisto", type = "central",
                                    fitted_ages = fitted_ages)

all_ages <- 0:130
surv_func <- rate2survival(completed_rates, ages = all_ages,
                           from = 'central', init_age = 55)

# convert from P to Q measure survival function
# see the section on risk neutral probability
surv_func_Q <- survivalP2Q(surv_func, method = "wang", lambda = 1.5)

# convert from survival function to mortality rates
central_rates_Q <- survival2rate(surv_func_Q, 55:130, to = 'central')
```

Note that transferring from survival function to rate is mainly used after converting
a survival function from real world measure to risk free measure. 










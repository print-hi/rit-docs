# Rate Changing

The age completion functions usually return mortality rates. However, part of the functionality
of this module is converting the real world probability based survival function to a risk free probability
measure survival function. However, this requires the mortality rates to be converted to survival 
probabilities. 

This functionality is covered by 2 helper functions.

---

### Mortality Rate to Survival Function

**rate2survival(rates, ages, from = 'prob', init_age = NULL, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix, or 3D array of mortality rates with age*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; from : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *string for type of rate to be converted: 'central', 'prob', or 
'force'*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age for survival function to be calculated at (default smallest age)*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional vector of years for `rates`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix of associated survival function 

&nbsp;&nbsp; **Usage:**

```r
# suppose we have mortality rate matrix generated from StoMoMo saved
# under the variable 'mortality_rates'

ages <- 30:90
old_ages <- 91:130

# use coal-kisker method to complete the rates
completed_rates <- CK(mortality_rates, ages, old_ages)

# note that CK returns central mortality rates 
new_ages <- 30:130
surv_func <- rate2survival(completed_rates, new_ages, from = 'central')
```

---

### Survival Function to Mortality Rate

**survival2rate(surv, ages, to = 'prob', years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing survival function*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of desired ages for the resulting mortality rates*

&nbsp;&nbsp;&nbsp;&nbsp; to : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *string representing type of mortality rate to conver to: 'central', 'prob', or 'force'*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional vector of years for `surv`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix of associated mortality rates

&nbsp;&nbsp; **Usage:**

```r
# suppose we have a survival function from ages 50:130 saved 
# under the variable 'surv_func'

ages <- 50:130
mortality_rates <- survival2rate(surv_func, ages, to = 'prob')
```

Note that transferring from survival function to rate is mainly used after converting
a survival function from real world measure to risk free measure. 










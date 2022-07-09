# Mortality Rate Completion 

The StMoMo package has good accuracy with mortality calculations for younger ages. However, 
for older ages (>90), other methods can be applied to improve mortality estimates. 

This module includes functions that apply different completion methods to 'extrapolate' more accurate 
mortality rates at the older ages.

---

### Coale and Kisker Method

The Coale and Kisker method is used to close life tables that builds upon the 
classical Gompertz model. As in the Gompertz Model, we use an exponential rate of
mortality, but instead of it being constant, we say it declines linearly. 

**coale_kisker(rates, ages, old_ages, type = 'central', closure_age = 130, m_end = 1, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`* 

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; m_end : numeric/vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *central death rate at maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of completed mortality rates with age rows, year columns

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130

completed_rates <- coale_kisker(AUS_male_rates, ages, old_ages, type = "central")
```

**References:**

Coale, Ansley J. and Kisker, Ellen E. 1990 'Defects in data on old-age mortality in the United States: New
procedures for calculating schedules and life tables at the higher ages,' *Asian and 
Pacific Population Forum*, 4: 1-31


---

### Denuit & Goderniaux Method

The Denuit and Goderniaux Method is a life table closing procedure based on
constrained log-quadratic regression. This is fitted with a closure constraint (max age), 
generally set at 130, and an inflexion constraint that makes the rate of mortality increase 
at older ages slow down. 

Smoothing can also be applied to the results using a simple geometric average on the
estimates.

**denuit_goderniaux(rates, ages, old_ages, type = 'prob', closure_age = 130, start_fit_age = 75, smoothing = FALSE, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for*

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; start_fit_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *model is fitted to ages starting from this age*

&nbsp;&nbsp;&nbsp;&nbsp; smoothing : logical

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE to apply smoothing to the completed rates*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of completed mortality rates with age rows, year columns

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130

# first convert mortality rates to death probabilties
AUS_male_qx <- rate2rate(AUS_male_rates, from = "central", to = "prob")

completed_qx <- denuit_goderniaux(AUS_male_qx, ages, old_ages, type = "prob")

# fit on ages 80:110 instead
completed_qx_from_80 <- denuit_goderniaux(AUS_male_qx, ages, old_ages, type = "prob", start_fit_age = 80)
```

**References:**

Denuit, M. and Goderniaux A., 2005 'Closing and Projecting lifetables using log-linear models', 
*Bulletin of the Swiss Association of Actuaries* p. 29-49

--- 

### Kannisto Method

The Kannisto model is based on the logistic model, and the constrained nature of having only 
2 free parameters makes mortality projections very consistent. Hence, it is advantangeous 
for the purpose of making extrapolations. 

It fits a model on the tail end of ages where the mortality rates are more accurate. It then 
extrapolates this to older ages. 

**kannisto(rates, ages, old_ages, fitted_ages, type = 'force', closure_age = 130, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for*

&nbsp;&nbsp;&nbsp;&nbsp; fitted_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages to fit initial model* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of completed mortality rates with age rows, year columns

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130

# fit model on tail end of ages where mortality is still accurate 
fitted_ages <- 76:90

completed_rates <- kannisto(AUS_male_rates, ages, old_ages,
                            fitted_ages, type = "central")
```

**References:**

Thatcher, A.R., Kannisto, V. and Vaupel, J.W. 1998 'The force of Mortality at Ages 80 to 120', 
*Monographs on Population Aging*, Volume 5: Odense University Press

--- 

### Wrapper Function

The completion methods above can be incorporated into a wrapper function. 

**complete_old_age(rates, ages, old_ages, method = "kannisto", type = 'prob',
closure_age = 130, years = NULL, ...)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for*

&nbsp;&nbsp;&nbsp;&nbsp; method : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'CK' for Coale-Kisker, 'DG' for Denuit and Goderniaux, 'Kannisto' for Kannisto* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; ...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *additional arguments required for the chosen completion method*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of completed mortality rates with age rows, year columns

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'

AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130

# first convert mortality rates to death probabilties
AUS_male_qx <- rate2rate(AUS_male_rates, from = "central", to = "prob")

# completing mortality rates for old ages
DG_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "DG",
                         type = "prob")
CK_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "CK",
                         type = "prob")
kannisto_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "kannisto",
                               type = "prob", fitted_ages = 80:90)
```




















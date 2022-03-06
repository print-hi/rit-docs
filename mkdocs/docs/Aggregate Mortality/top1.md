# Mortality Rate Completion 

The 'StoMoMo' package has good accuracy with mortality calculations for younger ages. However, 
for older ages (>90), other methods can be applied to improve mortality estimates. 

'mmrpp' includes functions that apply different methods to 'extrapolate' more accurate 
mortality rates at the older ages. 

---

### Coale and Kisker Method

The Coale and Kisker method is used to close life tables that builds upon the 
classical Gompertz model. As in the Gompertz Model, we use an exponential rate of
mortality, but instead of it being constant, we say it declines linearly. 

**CK(rates, ages, old_ages, type = 'central', closure_age = 130, m_end = 1, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing mortality rate with age rows and calendar year columns*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages in rates* 

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector containing ages to be completed* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'central' for central death rates, 'prob' for 1 year death probabilities, 
'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; m_end : numeric/vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *central death rate at maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional vector for year names assigned to rates*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix of central death rates for all ages and calendar years

&nbsp;&nbsp; **Usage:**

```r
# consider a rate matrix generated from StoMoMo saved
# under the variable 'mortality_rates'

ages <- 30:90
old_ages <- 91:130

completed_rates <- CK(mortality_rates, ages, old_ages)
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

!!! note
    This function returns death probabilities, not mortality rates. 

**DG(rates, ages, old_ages, type = 'prob', closure_age = 130, start_fit_age = 75, smoothing = FALSE, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing mortality rates with age rows and calendar year columns*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages in rates*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector containing ages to be completed*

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'central' for central death rates, 'prob' for 1 year death probabilities, 
'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age attainable*

&nbsp;&nbsp;&nbsp;&nbsp; start_fit_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *starting age*

&nbsp;&nbsp;&nbsp;&nbsp; smoothing : logical

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE to apply smoothing to rates*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional vector for year names assigned to rates*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix of 1 year death probabilities for all ages across the calendar years

&nbsp;&nbsp; **Usage:**

```r
# consider a rate matrix generated from StoMoMo saved
# under the variable 'mortality_rates'

ages <- 30:90
old_ages <- 91:130

completed_qx <- DG(mortality_rates, ages, old_ages)
```

**References:**

Denuit, M. and Goderniaux A., 2005 'Closing and Projecting lifetables using log-linear models', 
*Bulletin of the Swiss Association of Actuaries* p. 29-49

--- 

### Kannisto Method

The Kannisto model is based on the logistic model, and the constrained nature of having only 
2 free parameters makes mortality projections very consistent. Hence, it is advantangeous 
for the purpose of making extrapolations. 

**kannisto(rates, ages, old_ages, fitted_ages, type = 'force', closure_age = 130, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing mortality rates with age rows and calendar year columns*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages in rates*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector containing ages to be completed*

&nbsp;&nbsp;&nbsp;&nbsp; fitted_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *YET TO COMPLETE* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'central' for central death rates, 'prob' for 1 year death probabilities, 
'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional vector for year names assigned to rates*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix containing force of mortality for all ages across the calendar years

&nbsp;&nbsp; **Usage:**

```r
# consider a rate matrix generated from StoMoMo saved
# under the variable 'mortality_rates'

* YET TO COMPLETE
```

**References:**

Thatcher, A.R., Kannisto, V. and Vaupel, J.W. 1998 'The force of Mortality at Ages 80 to 120', 
*Monographs on Population Aging*, Volume 5: Odense University Press






















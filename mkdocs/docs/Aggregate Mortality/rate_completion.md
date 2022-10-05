# Mortality Rate Completion 

Mortality rates observed at old ages are affected by random fluctuations and hence, unreliable.
To accommodate for this, different completion methods have been proposed to 'extrapolate' 
more accurate mortality rates at older ages, and are implemented in this module.

---

### Wrapper Function

The different completion methods can be incorporated into a wrapper function which 
implements the chosen completion method.

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

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *the completion method to be used. 'CK' for Coale-Kisker, 'DG' for Denuit and Goderniaux*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'Kannisto' for Kannisto*

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

# first convert mortality rates to death probabilities
AUS_male_qx <- rate2rate(AUS_male_rates, from = "central", to = "prob")

# completing mortality rates for old ages
DG_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "DG",
                         type = "prob")
CK_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "CK",
                         type = "prob")
kannisto_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "kannisto",
                               type = "prob", fitted_ages = 80:90)
```

---

### Coale and Kisker Method

The model proposed by Coale and Kisker (1990) is one of techniques used to complete mortality rates
for old ages. The implementation follows Pitacco et al. (2009) and is based on the exponential age-specific rate of
change of central death rates
$$ 
k_{x, y}^{(i)} = \log \left( \frac{m_{x, y}^{(i)}}{m_{x - 1, y}^{(i)}} \right) .
$$

The model assumes that $k_{x, y}^{(i)}$ is linear over some age $x = \beta$, so
$$
   k_{x, y}^{(i)} =  k_{\beta, y}^{(i)} - (x - \beta) s_y^{(i)}
$$
where $s_y^{(i)}$ can be calculated assuming that $k_{\beta, y}^{(i)}$ is calculated from empirical data.
The central death rate can then be calculated for ages over $\beta$ by using
$$
  m_{x, y}^{(i)} = m_{\beta, y}^{(i)} \exp \left( \sum^x_{l = \beta + 1} k_{l, y}^{(i)} \right).
$$
In the implementation, $\beta + 1$ is taken to be the smallest value in `old_ages`.

**coale_kisker(rates, ages, old_ages, type = 'central', closure_age = 130, m_end = 1, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`* 

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for. Must connect with `ages`, see details* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; m_end : numeric/vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *central death rate at maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Details:**

&nbsp;&nbsp;&nbsp;&nbsp; 0:110 and 91:130 connect, 0:110 and 111:130 connect, 0:110 and 120:130 do not connect

&nbsp;&nbsp;&nbsp;&nbsp; `closure_age` must be equal to the last age in `old_ages`

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

Pitacco, Ermanno & Denuit, Michel & Haberman, Steven & Olivieri, Annamaria. (2009). Modelling Longevity Dynamics for Pensions and Annuity Business. 


---

### Denuit & Goderniaux Method

The Denuit and Goderniaux method (Denuit & Goderniaux, 2005) is a life table closing procedure
based on a constrained log-quadratic regression of the form
$$
  \log(q_{x, y}^{(i)}) = a_y^{(i)} + b_y^{(i)} x + 
  c_y^{(i)} x^2 + \epsilon_{x,y}^{(i)}
$$
where $\epsilon_{x,y}^{(i)}$ i.i.d  $N(0, \sigma^2)$. This is fitted on ages `start_fit_age` 
and over for each year. A closure constraint (max age), generally set at 130 is imposed as well as an 
inflexion constraint that makes the rate of mortality increase at older ages slow down. 

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

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for. Must connect with `ages`, see details*

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

&nbsp;&nbsp; **Details:**

&nbsp;&nbsp;&nbsp;&nbsp; 0:110 and 91:130 connect, 0:110 and 111:130 connect, 0:110 and 120:130 do not connect

&nbsp;&nbsp;&nbsp;&nbsp; `closure_age` must be equal to the last age in `old_ages`

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

The Kannisto model proposed by Kannisto (1994) is based on the logistic model to close mortality
rates for old ages. A model of the form
$$
\text{logit}(\mu_{x, y}^{(i)}) = \log(a_{y}^{(i)}) + b_{y}^{(i)} x
$$

is fitted on a set of fitted ages to obtain $a_{y}^{(i)}$ and $b_{y}^{(i)}$. 
The force of mortality for older ages can then be extrapolated via
$$
\mu_{x, y}^{(i)} = \frac{a_{y}^{(i)} \exp \left({b_{y}^{(i)}} \right)} 
{1 + a_{y}^{(i)} \exp \left({b_{y}^{(i)}} \right)}
$$

The set of fitted ages tends to be near the tail end of ages where the mortality rates are more accurate.


**kannisto(rates, ages, old_ages, fitted_ages, type = 'force', closure_age = 130, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, calendar year columns,
(simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `rates`*

&nbsp;&nbsp;&nbsp;&nbsp; old_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of old ages to be completed for. Must connect with `ages`, see details.*

&nbsp;&nbsp;&nbsp;&nbsp; fitted_ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages to fit initial model. Must connect with `old_ages`, see details.* 

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input and output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `rates`*

&nbsp;&nbsp; **Details:**

&nbsp;&nbsp;&nbsp;&nbsp; 0:110 and 91:130 connect, 0:110 and 111:130 connect, 0:110 and 120:130 do not connect

&nbsp;&nbsp;&nbsp;&nbsp; `closure_age` must be equal to the last age in `old_ages`

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

Kannisto, V. (1994). Development of oldest-old mortality, 1950-1990: Evidence from 28 devel-
oped countries. Odense University Press.

Antonio, Katrien, et al. The IA|BE 2020 Mortality Projection for the Belgian Population. 2020.






















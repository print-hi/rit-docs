# Mortality Rate and Survival Function

So far, this module has looked at the force of mortality, central death rate
and one-year death probability. These are all relevant over a one-year period to
determine the probability an individual currently aged $x$ will survive to age $x+1$.

Sometimes it might be of interest to look at the probability an individual survives
for more than one year. Hence, this module uses $S_{x, y}^{(i)} (t)$ to denote 
the probability an individual aged $x$ in calendar/cohort year $y$ will survive 
to age $x + t$ for simulation $i$, where $t \geq 0$. This survival probability
can be calculated for a range of values of $t$, giving rise to the idea of a 
survival function.

Mortality rates can be converted to survival probabilities by using the formula

$$
S_{x, y}^{(i)} (t) = 
\begin{cases}
    1 & t = 0 \\
    \prod_{l=0}^{t-1} p_{x+l, y}^{(i)} & t > 0
\end{cases}
$$

where $p_{x, y}^{(i)} = 1 - q_{x, y}^{(i)}$ is the one-year survival probability.

The conversions between mortality rates and survival probabilities are covered by two helper
functions, one for each direction.

---

### Mortality Rate to Survival Function

**rate2survival(rates, ages, from = 'prob', init_age = NULL, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

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










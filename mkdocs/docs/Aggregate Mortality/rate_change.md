# Mortality Rate Changing

Mortality rates can be expressed in different types, such as central death rates,
1-year death probabilities and force of mortality. Different mortality rate completion methods
require different types of mortality rates so this module includes a helper function to change
between the types of mortality rates.

This module uses the following notation for an individual aged $x$ in year $y$ for each simulation $i$:

* $m_{x, y}^{(i)}$: central death rate
* $q_{x, y}^{(i)}$: 1-year death probability
* $\mu_{x, y}^{(i)}$: force of mortality

Implementation assumes a constant force of mortality for fractional ages, 
resulting in the following conversions:

* $q_{x, y}^{(i)} = 1 - e^{-\mu_{x, y}^{(i)}}$
* $\mu_{x, y}^{(i)} = m_{x, y}^{(i)}$
* $m_{x, y}^{(i)}  = -\log(1 - q_{x, y}^{(i)})$
---

### Mortality Rate Changing

**rate2rate(rates, from, to)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mortality rates with age rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; from : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *input type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp;&nbsp;&nbsp; to : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *desired output type of mortality rates: 'central' for central death rates,*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'prob' for 1 year death probabilities, 'force' for force of mortality*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of converted mortality rates with age rows,
cohort/year columns 

&nbsp;&nbsp;&nbsp;&nbsp; (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# consider the male mortality rates from the data file 'mortality_AUS_data'

central_rates <- mortality_AUS_data$rate$male

# convert to 1-yr death probabilities

death_prob <- rate2rate(central_rates, from = "central", to = "prob")
```


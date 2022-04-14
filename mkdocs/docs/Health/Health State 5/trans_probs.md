# Transition Probability Matrix 

The Cox Hazard model produces continuous hazard rates that will be discretised to produces
piecewise constant rates. 

The process is repeated for each of the 6 transition rates. The rates at each age are combined
into transition rate matrices for that age. Taking the matrix exponential changes that to 
transition probability matrices. 

!!! note
    The transition probability matrices are deterministic for each individual 
    with the Static and Trend models, but stochastic with the Frailty model.

---

### Get Transition Probability

**get_full_trans_prob_matrix(params, init_age, gender, i, model)**

&nbsp;&nbsp; **Parameters**

&nbsp;&nbsp;&nbsp;&nbsp; params : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dataframe of parameters read from excel file*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; gender : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; i : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer for the wave index wave index = (interview year - 1998)/2 + 1*

&nbsp;&nbsp;&nbsp;&nbsp; model : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *1 for static, 2 for trend, 3 for frailty*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; List of 5x5 transition probability matrices

&nbsp;&nbsp; **Usage:**

```r
# for male aged 65 at wave index i, using the trend model with some parameters 'param'
trans_probs <- get_full_trans_prob_matrixfunction(params, init_age=65, gender=0, i, model=2)
```



















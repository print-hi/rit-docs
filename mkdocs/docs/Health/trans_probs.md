# Transition Probability Matrix

The Cox Hazard model produces continuous hazard rates that will be discretized to produce
piecewise constant rates. 

The process is repeated for each of the transition rates (4 transitions for 3-state model, and 12 transitions for 5-state model). The rates at each age are combined
into transition rate matrices for that age. Taking the matrix exponential changes that to 
transition probability matrices. 

!!! note
    The transition probability matrices are deterministic for each individual 
    with the Static and Trend models, but stochastic with the Frailty model.
---
### Get a List of Transition Probability Matrices from Initial Age to Age 110

**get_trans_probs(n_states, model_type, param_file, init_age, female, year = 2012, wave_index = 8, latent = 0)**

&nbsp;&nbsp; **Parameters**

&nbsp;&nbsp;&nbsp;&nbsp; n_states : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *take values 3 or 5, use 3 for 3-state model, and 5 for 5-state model*

&nbsp;&nbsp;&nbsp;&nbsp; model_type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'S' for static model, 'T' for trend model, 'F' for frailty model*

&nbsp;&nbsp;&nbsp;&nbsp; param_file : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS for the 3-state model, and use US_HRS_5 for the 5-state-model)*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the initial age*

&nbsp;&nbsp;&nbsp;&nbsp; female : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; year : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting current year, required in 3-state model and ignored in 5-state model*

&nbsp;&nbsp;&nbsp;&nbsp; wave_index : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer for the wave index = (interview year - 1998)/2 + 1, required in 5-state model and ignored in 3-state model*

&nbsp;&nbsp;&nbsp;&nbsp; latent : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial value of latent factor, normally take the value 0*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; List of 3x3 or 5x5 transition probability matrices, from the initial age to age 110.

&nbsp;&nbsp; **Usage:**

```r
# for male aged 65 at wave index i, using the 5-state frailty model with US_HRS_5 parameters
trans_probs=get_trans_probs(n_states=5, model_type='F', param_file=US_HRS_5, init_age=65, female=0, year = 2012, wave_index = 8, latent = 0)
```



















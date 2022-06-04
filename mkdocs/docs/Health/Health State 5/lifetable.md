# Life Table Generation

An individual's characteristics can also be used to generate a life table with a cohort of identical
traits. This can be used for the following applications:

* calculating probability of survival to different states

* calculating remaining life expectancy 

Life tables generated from the static and trend models are always deterministic, so the output will be one lifetable.

Meanwhile, the frailty model will produce stochastic ouputs. The lifetables outputted will be 
a full list of the simulated lifetables. 

The lifetable shows the number of people in each state at each age, and one can also the choose
the initial state and the initial age that the starting cohort is in.

--- 

### Generating a Life Table

**simulate_life_table_5=function(params,init_age,gender,i,latent,initial_state,n_sim=100, model)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; params : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Matrix of estimated parameters to construct the five  state model. The rows are beta, gamma_age, gamma_f, phi (if trend or frailty model), alpha (if frailty model). The columns are 1-12 transition types.*

&nbsp;&nbsp;&nbsp;&nbsp; gender : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; i : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *interview is taken every two years* 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave index = (interview year - 1998)/2 + 1* 

&nbsp;&nbsp;&nbsp;&nbsp; latent : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial value of the latent factor, normally take the value 0*

&nbsp;&nbsp;&nbsp;&nbsp; n_sim : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of life table simulations*

&nbsp;&nbsp;&nbsp;&nbsp; model : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *1 for static model, 2 for trend model, and 3 for frailty model*

&nbsp;&nbsp;&nbsp;&nbsp; init_state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the current state of individual, 0 for H state, 1 for M state, 2 for D state, 3 for MD state*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the initial age of life table*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; a list of life table matrices

&nbsp;&nbsp; **Usage:**

```r
# for male aged 65 at wave index i, initially in the health state, using the frailty model with parameters 'params'
life_table <- simulate_life_table_5(params,init_age=65,gender=0,i,latent,initial_state=0,n_sim=100, model=3)
```

When using static and trend model, 'n_sim' should be set to 1 to avoid generating the same life table repeatedly. 
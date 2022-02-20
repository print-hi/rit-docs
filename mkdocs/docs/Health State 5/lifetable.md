# Life Table Generation

An individual's characteristics can also be used to generate a life table with a cohort of identical
traits. As in the 3 state module, this can be used for the following applications:

* calculating probability of survival to different states

* calculating remaining life expectancy 

Life tables generated from the static and trend models are always deterministic,
whereas frailty model will produce stochastic ouputs. The lifetables outputted will be 
average of multiple simulations. 

The lifetable shows the number of people in each state at each age, and one can also the choose
the initial state that the starting cohort is in.

--- 

### Generating a Life Table

**simulate_life_table(params, age, gender, i, n_sim = 100, model)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; params : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dataframe of parameters read from excel file*

&nbsp;&nbsp;&nbsp;&nbsp; age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the current age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; gender : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; i : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave index (= current year - 1998 + 1)*

&nbsp;&nbsp;&nbsp;&nbsp; n_sim : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of life table simulations*

&nbsp;&nbsp;&nbsp;&nbsp; model : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *1 for static, 2 for trend and 3 for frailty*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; a list of life table matrices

&nbsp;&nbsp; **Usage:**

```r
# for male aged 65 at wave index i, using the trend model with some parameters 'param'
life_table <- simulate_life_table(params, 65, 0, n_sim = 1, model = 2)
```

!!! warning
    When using static and trend model, 'n_sim' should be set to 1 to avoid pointlessly 
    generating the same life table repeatedly. 
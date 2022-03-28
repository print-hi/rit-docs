# Discrete Economic Scenario Generator

The discrete time economic scenario generator simulates the trajectories of 10 Australian 
economic and financial variables, which as mentioned in the overview are: 

1. 3-month zero coupon yields (in %)

2. 10-year zero coupon spread (in %)

3. NSW home value index

4. NSW home rental yields

5. Australia GDP

6. Australia CPI 

7. S&P/ASX200 closing price

8. Australian dollar trade-weighted index

9. Australia mortgage rate

10. NSW unemployment rate (in %)

We fit these factors using an autoregressive model. This is a regression of a time series where
the ouput variable depends linearly on its previous values, up to some specfied order. The 
coefficients of the fitted model are used in the following simulation funtions.

---

### Simulate discrete economic and financial variables

**get_var_simulations(num_years = 5, num_paths = 10000, frequency = 'quarter', per_change = FALSE, return_noise = FALSE)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; num_years : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of years to forecast from 2021-01-01*

&nbsp;&nbsp;&nbsp;&nbsp; num_paths : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of simulations to make for each variable*

&nbsp;&nbsp;&nbsp;&nbsp; frequency : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'year', 'quarter' or 'month' denoting the simulation frequency*

&nbsp;&nbsp;&nbsp;&nbsp; perc_change : logical

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE for outputs to be expressed as percent change*

&nbsp;&nbsp;&nbsp;&nbsp; return_noise : logical 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE to return the white noise of the model*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; A list of 10 dataframes containing simulated trajectories of the 10 variables

&nbsp;&nbsp; **Usage:**

```r
# simulate 10 years of data
sim <- get_discrete_simulations(num_years = 10, num_paths = 10000, frequency = 'year')

# suppose we wish to look at the 3 months zero coupon bonds
sim$zcp3m_yield

# if we wanted a specific trajectory, say 103
sim$zcp3m_yield$trajectory_103
```

---

### Return stochastic discount factors using variables above

**get_sdf_simulation(num_years = 5, num_paths = 10000, frequency = 'quarter')**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; num_years : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of years to forecast from 2021-01-01*

&nbsp;&nbsp;&nbsp;&nbsp; num_paths : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of simulation paths*

&nbsp;&nbsp;&nbsp;&nbsp; frequency : character 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'year', 'quarter' or 'month' denoting the simulation frequency*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; dataframe containing stochastic discount factor trajectories

&nbsp;&nbsp; **Usage:**

```r
# get stochastic discount factors for next 10 years with 10000 simulations 
sdfs <- get_sdf(num_years = 10, frequency = 'year')
```
























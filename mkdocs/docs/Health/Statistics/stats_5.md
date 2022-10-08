# 5-State Model

With the use of simulated paths, a lot of mortality statistics can be generated 
to analyse or simply gain insight into the survival characteristics of certain individuals. 

For the 5 state model, we use the simulated paths as inputs to calculate:

* the average time of entering a certain state (such as the D state: Healthy and functionally disabled)

* the total time spent in each state 

As results are stochastic (statistics are derived from random simulated lifetimes), we can 
also study the variance of these statistics. This will be beneficial in quantifying the risk, 
allowing for more robust pricing methods. 

---

### Average First Time Entering State

**health5_first_time_stats(simulated_path, state)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; simulated_path : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life time simulations, obtained from function "simulate_health_state_paths"*

&nbsp;&nbsp;&nbsp;&nbsp; state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting which state we are entering or leaving*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 for first time leaving H state, only used when initial state is 0

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 for first time entering M state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 for first time entering D state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 for first time entering MD state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1 for first time entering the dead state

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; column vector of first time entering the specified state

&nbsp;&nbsp; **Usage:**

```r
# simulation of 10000 males aged 65 initially healthy under the trend model
trans_probs <- get_trans_probs(n_states=5, model_type='T', param_file=US_HRS_5, init_age=65, female=0, year = 2012, wave_index = 8, latent = 0)
simulated_path <- simulate_health_state_paths(trans_probs, init_age=65, init_state = 0, cohort = 10000)

# time until entering M state, ill health but not functionally disabled
time_to_M <- health5_first_time_stats(simulated_path, 1)

# average initial time of entering state 1
print(mean(time_to_M, na.rm = TRUE))
```

---

### Total Time Spent in State

**health5_total_time_stats(simulated_path, state)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; simulated_path : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life time simulations, obtained from function "simulate_health_state_paths"*

&nbsp;&nbsp;&nbsp;&nbsp; state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting which state we are counting*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 for total time in H state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 for total time in M state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 for total time in D state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 for total time in MD state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1 for total time in dead state

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 for total time alive or not in dead state

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; column vector of total times spent in specified state

&nbsp;&nbsp; **Usage:**

```r
# simulation of 10000 males aged 65 initially healthy under the trend model
trans_probs <- get_trans_probs(n_states=5, model_type='T', param_file=US_HRS_5, init_age=65, female=0, year = 2012, wave_index = 8, latent = 0)
simulated_path <- simulate_health_state_paths(trans_probs, init_age=65, init_state = 0, cohort = 10000)

# total time spent in MD state, ill health and functionally disabled 
total_state_MD <- health5_total_time_stats(simulated_path, 3)

# average time spent in state MD
print(mean(total_state_MD))
```

---

### Produce Mean and Variance from Output

This function is a 'helper' function, used in conjunction with the ouput of the 
previous functions to create the mean and variance of those statistics. 

**health5_stats_produce(input)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; input : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n$\times$1 matrix of statistics*

&nbsp;&nbsp; **Returns**

&nbsp;&nbsp;&nbsp;&nbsp; mean and variance of the statistics inputted

&nbsp;&nbsp; **Usage:**

```r
# simulation of 10000 males aged 65 initially healthy under the trend model
trans_probs <- get_trans_probs(n_states=5, model_type='T', param_file=US_HRS_5, init_age=65, female=0, year = 2012, wave_index = 8, latent = 0)
simulated_path <- simulate_health_state_paths(trans_probs, init_age=65, init_state = 0, cohort = 10000)

# time until entering M state, ill health but not functionally disabled
time_to_M <- health5_first_time_stats(simulated_path, 1)

# total time spent in MD state, ill health and functionally disabled 
total_time_state_MD <- health5_total_time_stats(simulated_path, 3)

# produce mean and variance of first time into M state
first_time_M_stats <- health5_stats_produce(time_to_M)

# produce mean and variance of time spent in MD state
total_time_in_MD_stats <- health5_stats_produce(total_time_state_MD)
```



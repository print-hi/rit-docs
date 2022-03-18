# Statistics 

With the use of simulated paths, a lot of mortality statistics can be generated 
to analyse or simply gain insight into the survival characteristics of certain individuals. 

For the 5 state model, we use the simulated paths as inputs to calculate:

* the average time of entering a certain state (such as disabled but not terminally ill)

* the total time spent in each state 

As results are stochastic (statistics are derived from random simulated lifetimes), we can 
also study the variance of these statistics. This will be beneficial in quantifying the risk, 
allowing for more robust pricing methods. 

---

### Average first time entering state

**first_time_stats(simulated_path, state)**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; simulated_path : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life time simulations, obtained from function 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"simulate_individual_path"*

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
# simulation of males aged 65 initially healthy under the trend model
simulated_path <- simulate_individual_path(65, 0, params, 0, 19, model = 2)

# time until entering ill health but not functionally disabled
time_to_1 <- first_time_stats(simulated_path, 1)

# average initial time of entering state 1
print(mean(time_to_1, na.rm = TRUE))
```

---

### Total time spent in state

**total_time_stats(simulated_path, state)**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; simulated_path : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life time simulations*

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
# simulation of males aged 65 initially healthy under the trend model
simulated_path <- simulate_individual_path(65, 0, params, 0, 19, model = 2)

# total time spent in MD state, ill health and functionally disabled 
total_state3 <- total_time_stats(simulated_path, 3)

# average time spent in state 3
print(mean(total_state3))
```

---

### Produce mean and variance from output

This function is a 'helper' function, used in conjunction with the ouput of the 
previous functions to create the mean and variance of those statistics. 

**stats_produce(input)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; input : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *n$\times$1 matrix of statistics*

&nbsp;&nbsp; **Returns**

&nbsp;&nbsp;&nbsp;&nbsp; mean and variance of the statistics inputted

&nbsp;&nbsp; **Usage:**

```r
# simulation of males aged 65 initially healthy under the trend model 
simulated_path <- simulate_individual_path(65, 0, params, 0, 19, model = 2)

# time until entering M state, ill health but not functionally disabled
time_to_1 <- first_time_stats(simulated_path, 1)

# total time spent in MD state, ill health and functionally disabled 
total_state3 <- total_time_stats(simulated_path, 3)

# produce mean and variance of first time into M state
time1_stats <- stats_produce(time_to_1)

# produce mean and variance of time spent in MD state
timein3_stats <- stats_produce(total_state3)
```



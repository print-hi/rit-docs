# Summary Statistics

The module includes a set of functions that output summary statistics for the survival functions 
generated. These include: 

* distribution functions

* quantile function

* simulation plots (with confidence ranges)

---

### Distribution and quantile functions

**psurv(surv_fun, surv_time)**

**qsurv(surv_fun, surv_prob)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv_func : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing survival function*

&nbsp;&nbsp;&nbsp;&nbsp; surv_time : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of survival times*

&nbsp;&nbsp;&nbsp;&nbsp; surv_prob : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of survival probabilities*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; list of probabilites (distribution) or survival times (quantile)

&nbsp;&nbsp; **Usage:**

```r
# suppose we have a survivial function saved 
# under variable name : surv_func

# calcuting probability of surviving 10 years
psurv(surv_func, 10)

# calculating the 95% quantile survival time
qsurv(surv_func, 0.95)
```

---

### Survival Function Simulation

**plot_surv_sim(surv_sim, init_age, target_year, level = 95)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv_sim : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing survival function*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of `surv_sim`*

&nbsp;&nbsp;&nbsp;&nbsp; target_year : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *year for which the plot is made for*

&nbsp;&nbsp;&nbsp;&nbsp; level : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *desired confidence level*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp;  plot of the survival function

&nbsp;&nbsp; **Usage:**

```r
# suppose we have a survival function startin from age 50 saved under 
# variable name: surv_func

plot_surv_sim(surv_func, 50, 2022)
```

---

### Expected Curtate Future Lifetime

**plot_exp_cfl(exp_cfl_hist, years_hist, exp_cfl_sim, years_sim, level = 95)**


&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; exp_cfl_hist : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of expected curtate future lifetime for historical years*

&nbsp;&nbsp;&nbsp;&nbsp; years_hist : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of historical years*

&nbsp;&nbsp;&nbsp;&nbsp; exp_cfl_sim : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix of simulated expected curtate future lifetimes*

&nbsp;&nbsp;&nbsp;&nbsp; years_sim : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of years for simulation*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; plot of expected curtate future lifetime 

&nbsp;&nbsp; **Usage:**

```r
# need to use `exp_cfl` function to create expected curtate future lifetimes on historical 
# years and simulated years (which are derived from previous workflow)

ecfl_historical <- exp_cfl(q_hist, ages)
ecfl_sim <- exp_cfl(q_sim, ages)
plot_exp_cfl(ecfl_historical, years_hist, ecfl_sim, years_sim)
```






















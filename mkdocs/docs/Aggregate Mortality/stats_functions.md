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

&nbsp;&nbsp;&nbsp;&nbsp; surv_fun : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *survival function for a specific cohort/year with survival time rows*

&nbsp;&nbsp;&nbsp;&nbsp; surv_time : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of survival times*

&nbsp;&nbsp;&nbsp;&nbsp; surv_prob : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of survival probabilities*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; vector of probabilites (distribution) or survival times (quantile)

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

# take vector of survival function (consider year 2017)
surv_func_2017 <- surv_func[, "2017"]

# calculate probability of surviving 10 and 20 years
psurv(surv_func_2017, c(10, 20))

# calculating the 80% and 95% quantile survival time
qsurv(surv_func_2017, c(0.8, 0.95))
```

---

### Survival Function Simulation

**plot_surv_sim(surv_sim, init_age, target_year, level = 95, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv_sim : array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *survival function with survival time rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *and simulation number 3rd dimension*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of surv_sim*

&nbsp;&nbsp;&nbsp;&nbsp; target_year : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *year for which the plot is made for*

&nbsp;&nbsp;&nbsp;&nbsp; level : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *desired confidence level (default 95%)*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for surv_sim*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; plot of the survival function for the chosen year with confidence intervals

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






















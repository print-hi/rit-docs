# Summary Statistics

This module includes a set of functions that output summary statistics for the survival functions 
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

Given multiple simulation paths of a survival function, the survival function for a chosen year
with confidence intervals can be generated.

**plot_surv_sim(surv_sim, init_age, target_year, level = 95, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; surv_sim : array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *survival function with survival time rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *and simulation number 3rd dimension*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of `surv_sim`*

&nbsp;&nbsp;&nbsp;&nbsp; target_year : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *year for which the plot is made for*

&nbsp;&nbsp;&nbsp;&nbsp; level : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *desired confidence level (default 95%)*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `surv_sim`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; plot of the survival function for the chosen year with confidence intervals

&nbsp;&nbsp; **Usage:**

```r
# generate simulated rates with 'StMoMo'
# install and load 'StMoMo' if the package is not loaded

# fitting lee carter model on ages 55:89
AUS_StMoMo <- StMoMoData(mortality_AUS_data, series = "male")
LC <- lc(link = "logit") # lee carter model
AUS_Male_Ini_Data <- central2initial(AUS_StMoMo)
ages_fit <- 55:89
wxy <- genWeightMat(ages = ages_fit, years = AUS_Male_Ini_Data$years, clip = 3)
LC_fit <- fit(LC, data = AUS_Male_Ini_Data, ages.fit = ages_fit, wxt = wxy)

# simulating rates for next 100 years
set.seed(1234)
n_sim <- 10
LC_sim <- simulate(LC_fit, nsim = n_sim, h = 100)

# using kannisto method to complete rates
young_ages <- LC_sim$ages # 55:89
old_ages <- 90:130
ages <- c(young_ages, old_ages)

kannisto_sim <- complete_old_age(rates = LC_sim$rates, ages = young_ages,
                                 old_ages = old_ages, fitted_ages = 80:89,
                                 method = "kannisto", type = "central")

# create period survival function for individual aged 55
surv_sim <- rate2survival(kannisto_sim, ages, from = "central")  

plot_surv_sim(surv_sim, 55, 2050)
```

---

### Expected Curtate Future Lifetime
It may also be worthwhile to look at the expected curtate future lifetime of individuals. 
Historical and simulated future mortality rates will need to be merged together via the helper
function `combine_hist_sim`, and `exp_cfl` calculates the expected curtate future lifetime.
As there is uncertainty involved with simulating future mortality rates, the function `plot_exp_cfl`
can generate a plot of expected curtate future lifetime with confidence intervals across years/cohorts.

#### Combine Historical and Simulated Rates

**combine_hist_sim(rates_hist, rates_sim)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; rates_hist : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *historical mortality rates with age rows and cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp; rates_sim : array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *simulated mortality rates with age rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *and simulation number 3rd dimension*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; array of combined historical and simulated rates with age rows, cohort/year columns

&nbsp;&nbsp;&nbsp;&nbsp; and simulation number 3rd dimension

---

#### Calculate Expected Curtate Future Lifetime

**exp_cfl(qx, ages, init_age = NULL, years = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; qx : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *1-year death probabilities with age rows, cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension*

&nbsp;&nbsp;&nbsp;&nbsp; ages : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of ages for `qx`*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age to calculate expected curtate future lifetime*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optional numeric vector of years for `qx`*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix of expected curtate future lifetime with simulation number rows

&nbsp;&nbsp;&nbsp;&nbsp; and cohort/year columns

---

#### Plot Expected Curtate Future Lifetime

**plot_exp_cfl(exp_cfl_rates, years, level = 95)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; exp_cfl_rates : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *simulated expected curtate future lifetime with simulation number rows and*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp; years : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric vector of years for `exp_cfl_rates`*

&nbsp;&nbsp;&nbsp;&nbsp; level : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *desired confidence level (default 95%)*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; plot of expected curtate future lifetime with confidence intervals across years/cohorts

&nbsp;&nbsp; **Usage:**

```r
# generate simulated rates with 'StMoMo'
# install and load 'StMoMo' if the package is not loaded

# fitting lee carter model on ages 55:89
AUS_StMoMo <- StMoMoData(mortality_AUS_data, series = "male")
LC <- lc(link = "logit") # lee carter model
AUS_Male_Ini_Data <- central2initial(AUS_StMoMo)
ages_fit <- 55:89
wxy <- genWeightMat(ages = ages_fit, years = AUS_Male_Ini_Data$years, clip = 3)
LC_fit <- fit(LC, data = AUS_Male_Ini_Data, ages.fit = ages_fit, wxt = wxy)

# simulating rates for next 100 years
set.seed(1234)
n_sim <- 10
LC_sim <- simulate(LC_fit, nsim = n_sim, h = 100)

# using kannisto method to complete rates
young_ages <- LC_sim$ages # 55:89
old_ages <- 90:130
ages <- c(young_ages, old_ages)

rates_hist <- mortality_AUS_data$rate$male[as.character(young_ages), ]
years_hist <- as.numeric(colnames(rates_hist))
years_sim <- LC_sim$years
years <- c(years_hist, years_sim)

kannisto_sim <- complete_old_age(rates = LC_sim$rates, ages = young_ages,
                                 old_ages = old_ages, fitted_ages = 80:89,
                                 method = "kannisto", type = "central")
kannisto_hist <- complete_old_age(rates = rates_hist, ages = young_ages,
                                  old_ages = old_ages, fitted_ages = 80:89,
                                  method = "kannisto", type = "central")

################# USAGE BEGINS HERE ################

# combining
kannisto_55_period <- combine_hist_sim(rates_hist = kannisto_hist,
                                       rates_sim = kannisto_sim)

# working with cohort starting from age 55
kannisto_55 <- period2cohort(period_rates = kannisto_55_period, ages = ages)
kannisto_55_q <- rate2rate(kannisto_55, from = "central", to = "prob")

exp_cfl_kannisto <- exp_cfl(qx = kannisto_55_q, ages = ages)

# Expected curtate future lifetime can only be computed for
# the earlier (complete) cohorts
exp_cfl_kannisto_clean <- exp_cfl_kannisto[, as.character(1970:2043)]
plot_exp_cfl(exp_cfl_rates = exp_cfl_kannisto_clean, years = 1970:2043)
```

# Simulating Life Paths

One-year death probabilities derived from previous sections can also be used to simulate life paths
for a cohort of individuals. Each individual will be alive at a specified initial age, and we sample
movements according to the one-year death probabilities given at each age.

---

### Simulating Lives

**simulate_path_mortality(init_age, sex = "F", death_probs = NULL, closure_age = 130, cohort = 10000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of each life path*

&nbsp;&nbsp;&nbsp;&nbsp; sex : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character denoting gender of individuals, "F" for female and
"M" for male*

&nbsp;&nbsp;&nbsp;&nbsp; death_probs : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vector of 1-year death probabilities. If not supplied, an M7
age-period-cohort model will be* 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fitted on `mortality_AUS_data` to produce forecasted
death probabilities for a cohort starting* 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *at `init_age` in 2022*

&nbsp;&nbsp;&nbsp;&nbsp; closure_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *maximum age*

&nbsp;&nbsp;&nbsp;&nbsp; cohort : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of individual lives to simulate*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; a matrix where each row represents an individual's dead (-1) or alive (0) status
across the 

&nbsp;&nbsp;&nbsp;&nbsp; years

An example looks like: 

\begin{pmatrix}
0 & -1 & -1 & -1 & \ldots & -1 \\
0 & 0 & 0 & -1 & \ldots & -1 \\
 &  &  \vdots & & & \\
0 & 0 & 0 & 0 & \ldots & -1 \\
0 & 0 & -1 & -1 & \ldots & -1
\end{pmatrix}

Note that the first column of the matrix will always be 0 as everyone is alive at the initial age,
and the last column will always be -1, signifying everyone will be dead at age 131 (if we assume 130 is the
maximum age one can be). 

&nbsp;&nbsp; **Usage:**

```r
# Simulate life paths for females starting at age 60
simulate_path_mortality(init_age = 60, sex = "F")

# Suppose we want to use period 1-yr death probabilities instead
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130
AUS_male_qx <- rate2rate(AUS_male_rates, from = "central", to = "prob")
kannisto_q <- complete_old_age(AUS_male_qx, ages, old_ages, method = "kannisto",
                               type = "prob", fitted_ages = 80:90)

# Consider males aged 55 in the year 2018
qx_55_2018 <- kannisto_q[as.character(55:130), "2018"]
simulate_path_mortality(init_age = 55, sex = "M", death_probs = qx_55_2018)                         
```
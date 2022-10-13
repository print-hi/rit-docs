# 3-State Model

A lot of mortality statistics can be generated to analyse survival of a certain individual. The following
functions return the expected value and variance associated with the lifetime statistic.

The functions can use either of the different inputs below to produce the required statistic:

* list of transition probability matrices from `get_trans_probs`

* simulated path matrix from `simulate_health_state_paths`

If the first option is used, the functions use simulation to find expected value and variance. 
Hence, there is a stochastic component to these results. If both inputs are provided, then the
simulated path wil be used, and no simulation will occur within the function.

Each function comes with a frailty version, which has the same name with an 'F' attached to it (eg. 
`health3_afl` -> `health3_aflF`). The frailty version simulates 'n' unique latent paths, which adds another
level of randomness in the statistic. It also requires the same parameters needed to produce a new
set of transition probability matrices (see below examples). By default, frailty functions
simulate 1000 unique latent factors. 

For all code examples below, we will use a male individual aged 65 in year 2022.

---

### Average Future Lifetime: `health3_afl` (`health3_aflF`)

The function calculates the average future lifetime for a given individual, and its variance.

**health3_afl(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_probs** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; **simulated_path** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life path simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average future lifetime

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=65, female=0, year = 2022)

# calculate average future lifetime
health3_afl(65, init_state = 0, trans_probs)
```

**health3_aflF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average future lifetime

&nbsp;&nbsp; **Usage:**

```r
health3_aflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Healthy Future Lifetime `health3_hfl` (`health3_hflF`)

This function calculates the average future lifetime spent in the healthy state, and its variance.

**health3_hfl(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_probs** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; **simulated_path** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life path simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of healthy future lifetime

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=65, female=0, year = 2022)

# calculate healthy future lifetime
health3_hfl(65, init_state = 0, trans_probs)
```

**health3_hflF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of healthy future lifetime

&nbsp;&nbsp; **Usage:**

```r
health3_hflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Average Disabled Future Lifetime: `health3_dfl` (`health3_dflF`)

This function calculates the average future lifetime spent in the disabled state, and its variance.

Not that under the same simulated lifetime, average future lifetime is equal to the sum of healthy 
    lifetime and disabled lifetime. 

**health3_dfl(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_probs** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; **simulated_path** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life path simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average lifetime spent in disabled state

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=65, female=0, year = 2022)

# calculate average future lifetime in disabled state
health3_dfl(65, init_state = 0, trans_probs)
```

**health3_dflF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average future lifetime in disabled state

&nbsp;&nbsp; **Usage:**

```r
health3_dflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Time until onset of Disability: `health3_time_to_disabled` (`health3_time_to_disabledF`)

This function calculates average time for onset of disability, given that the 
individual becomes disabled. 

Note that an initial state is not required for this function, as disabled initial state is  trivial. 

**health3_time_to_disabled(init_age, trans_probs = NULL, simulated_path = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_probs** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; **simulated_path** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life path simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of onset of first diability

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=65, female=0, year = 2022)

# calculate time until onset of disability
health3_time_to_disabled(65, trans_probs)
```

**health3_time_to_disabledF(init_age, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of onset of first disability

&nbsp;&nbsp; **Usage:**

```r
health3_time_to_disabledF(65, female = 0, 2022, US_HRS)
```

---

### All Survival Stats: `health3_survival_stats` (`health3_survival_statsF`)

A combination of all the above functions. If transition probabilities are provided, then
one simulation is run and all the statistics are calculated from that simulation (this is 
to keep results consistent). A simulated pathway can also be provided.

Time until onset of disability is not returned if initial state is set to 1 as it is trivial. 

The function returns all the information (mean and variance of each statistic) as a dataframe.

**health3_survival_stats(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_probs** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; **simulated_path** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *matrix containing life path simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of all statistics

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=65, female=0, year = 2022)

# calculate all statistics
health3_survival_stats(65, init_state = 0, trans_probs)
```

**health3_survival_statsF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of individual: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of all statistics

&nbsp;&nbsp; **Usage:**

```r
health3_survival_statsF(65, init_state = 0, female = 0, 2022, US_HRS)
```












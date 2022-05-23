# Statistics

A lot of mortality statistics can be generated to analyse survival of a certain individual. The following
functions return the expected value and variance associated with the lifetime statistic.

The functions can use either of the different inputs below to produce the required statistic:

* list of transition probability matrices from `get_trans_probs`

* simulated path matrix from `simulate_path`

If the first option is used, the functions use simulation to find expected value and variance. 
Hence, there is a stochastic component to these results.

Each function comes with a frailty version, which has the same name with an 'F' attached to it (eg. 
`afl` -> `aflF`). The frailty version simulates 'n' unique latent paths, which adds another
level of randomness in the statistic. It also requires the same parameters needed to produce a new
set of transition probability matrices (see below examples). By default, frailty functions
simulate 1000 unique latent factors. 

For all code examples below, we will use an male individual aged 65 in year 2022.

---

### Average Future Lifetime: `afl` (`aflF`)

The function calculates the average future lifetime for a given individual, and its variance.

**afl(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

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
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate average future lifetime
afl(65, init_state = 0, trans_probs)
```

**aflF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of indiviudal: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character for file path or dataframe/tibble of parameters

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average future lifetime

&nbsp;&nbsp; **Usage:**

```r
aflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Healthy Future Lifetime `hfl` (`hflF`)

This function calculates the average future lifetime spent in the healthy state, and its variance.

**hfl(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

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
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate healthy future lifetime
hfl(65, init_state = 0, trans_probs)
```

**hflF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of indiviudal: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character for file path or dataframe/tibble of parameters

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of healthy future lifetime

&nbsp;&nbsp; **Usage:**

```r
hflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Average Future Lifetime in Disabled State: `afld` (`afldF`)

This function calculates the average future lifetime spent in the disabled state, and its variance.

!!! note
    Under the same simulated lifetime, average future lifetime is equal to the sum of healthy 
    lifetime and disabled lifetime. 

**afld(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

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

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average lifetime spent in disabled state

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate average future lifetime in disabled state
afld(65, init_state = 0, trans_probs)
```

**afldF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of indiviudal: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character for file path or dataframe/tibble of parameters

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of average future lifetime in disabled state

&nbsp;&nbsp; **Usage:**

```r
afldF(65, init_state = 0, female = 0, 2022, US_HRS)
```

---

### Time until onset of Disability: `time_to_disabled` (`time_to_disabledF`)

This function calculates average time for onset of disability, given that the 
individual becomes disabled. 

!!! note
    Initial state is not required for this function, as disabled initial state is 
    trivial. 

**time_to_disabled(init_age, trans_probs = NULL, simulated_path = NULL)**

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
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate time until onset of disability
time_to_disabled(65, trans_probs)
```

**time_to_disabledF(init_age, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character for file path or dataframe/tibble of parameters

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of onset of first disability

&nbsp;&nbsp; **Usage:**

```r
time_to_disabledF(65, female = 0, 2022, US_HRS)
```

---

### All Survival Stats: `survival_stats` (`survival_statsF`)

A combination of all the above functions. If transition probabilities are provided, then
one simulation is run and all the statistics are calculated from that simulation (this is 
to keep results consistent). A simulated pathway can also be provided.

Time until onset of disability is not returned if initial state is set to 1 as it is trivial. 

The function returns all the information (mean and variance of each statistic) as a dataframe.

**survival_stats(init_age, init_state, trans_probs = NULL, simulated_path = NULL)**

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

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of all statistics

&nbsp;&nbsp; **Usage:**

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate all statistics
survival_stats(65, init_state = 0, trans_probs)
```

**survival_statsF(init_age, init_state, female, year, param_file, n = 1000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of indiviudal*

&nbsp;&nbsp;&nbsp;&nbsp; **init_state** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of indiviudal: 0 for healthy, 1 for disabled*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting current year*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *character for file path or dataframe/tibble of parameters

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting number of unique latent factor simulations*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Mean and variance of all statistics

&nbsp;&nbsp; **Usage:**

```r
survival_statsF(65, init_state = 0, female = 0, 2022, US_HRS)
```












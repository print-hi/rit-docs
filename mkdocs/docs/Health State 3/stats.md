# Statistics

A lot of mortality statistics can be generated to analyse survival of a certain individual. The following
functions return the expected value and variance associated with the lifetime statistic.

The functions can use 1 of 2 different inputs to produce the required statistic:

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

#### Average Future Lifetime: `afl` (`aflF`)

The function calculates the average future lifetime for a given individual, and its variance.

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate average future lifetime
afl(65, init_state = 0, trans_probs)

# frailty model
aflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

#### Healthy Future Lifetime `hfl` (`hflF`)

This function calculates the average future lifetime spent in the healthy state, and its variance.

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate healthy future lifetime
hfl(65, init_state = 0, trans_probs)

# frailty model
hflF(65, init_state = 0, female = 0, 2022, US_HRS)
```

#### Average Future Lifetime in Disabled State: `afld` (`afldF`)

This function calculates the average future lifetime spent in the disabled state, and its variance.

!!! note
    Under the same simulated lifetime, average future lifetime is equal to the sum of healthy 
    lifetime and disabled lifetime. 

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate average future lifetime in disabled state
afld(65, init_state = 0, trans_probs)

# frailty model
afldF(65, init_state = 0, female = 0, 2022, US_HRS)
```

#### Time until onset of Disability: `time_to_disabled` (`time_to_disabledF`)

This function calculates average time for onset of disability, given that the 
individual becomes disabled. 

!!! note
    Initial state is not required for this function, as disabled initial state is 
    trivial. 

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate time until onset of disability
time_to_disabled(65, trans_probs)

# frailty model
time_to_disabledF(65, female = 0, 2022, US_HRS)
```

#### All Survival Stats: `survival_stats` (`survival_statsF`)

A combination of all the above functions. If transition probabilities are provided, then
one simulation is run and all the statistics are calculated from that simulation (this is 
to keep results consistent). A simulated pathway can also be provided.

Time until onset of disability is not returned if initial state is set to 1 as it is trivial. 

The function returns all the information (mean and variance of each statistic) as a dataframe.

```r
# trend model
trans_probs <- get_trans_probs('T', US_HRS, 65, female = 0, 2022)

# calculate all statistics
survival_stats(65, init_state = 0, trans_probs)

# frailty model
survival_statsF(65, init_state = 0, female = 0, 2022, US_HRS)
```















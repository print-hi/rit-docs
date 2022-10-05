# Summary statistics 

Period-by-period summary statistics such as quantiles, mean, and standard deviation are helpful in understanding the distribution of the simulated trajectories. We provide a R function which accepts a list or a dataframe of time series data, and returns various common choices of summary statistics. 

---

**esg_summary(paths, probs = seq(0, 1, 0.25), na.rm = TRUE)**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; paths : a list or a dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *List or dataframe containing time series data*

&nbsp;&nbsp;&nbsp;&nbsp; probs : numeric or vector 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Numeric vector of probabilities with values in [0,1]. Default is 0%, 25%, 50%, 75%, 100%-tiles*

&nbsp;&nbsp;&nbsp;&nbsp; rm.na : logical

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE if any NA and NaN's are removed from data before computing the statistics. Default TRUE*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; List of dataframe containing summary statistics for each period across trajectories. 

&nbsp;&nbsp; **Usage:**

```r
# simulate 10 years of data 
sim <- esg_var_simulator(num_years = 10, num_paths = 10, frequency = 'year')

# obtain summary statistics for GDP data with default statistics
gdp_summ <- esg_summary(sim$GDP) 

# obtain summary statistics for 0%,20%,40%,60%,80%,100%-tiles for the whole list 
all_summ <- esg_summary(sim, probs = seq(0,1,0.2))

# summary statistics for self-defined dataframes 
test_data = as.data.frame(matrix(1:100, nrow = 4, byrow = TRUE))
test_data2 = as.data.frame(matrix(1001:2000, nrow = 40, byrow = TRUE))
test_list = list(test_data, test_data2)
esg_summary(test_list)
```

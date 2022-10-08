# Workflow Example

The following is an example of the general workflow of the module. It demonstrates
the order of function executions, and the different endpoint outputs. We use the following
individual characteristics:

* male
* age 87
* initial year 2022
* trend model 
* healthy 
* use parameters estimated from the US study: `US_HRS` for 3-state model and `US_HRS_5` for 5-state model


```r
# first we create a list of transition probability matrices 
trans_probs_3 <- get_trans_probs(n_states=3, model_type='T', param_file=US_HRS, init_age=87, female=0, year = 2022, latent = 0)

# using the transition probabilities, we can generate life tables
lifetable <- create_life_table(trans_probs_3, init_age=87, init_state = 0, cohort = 100000)
head(lifetable)
```

<figure markdown>
  ![lifetable](../../img/3_state_workflow/lifetable_output.png)
</figure>

```r
# can also create a plot of mortality and disability curves
prob_plots(init_state = 0, 87, trans_probs_3)
```

<figure markdown>
  ![mortality plot](../../img/3_state_workflow/plot_output.png)
</figure>

Statistics for 3-state models:
```r
# from transition probabilities, we can simulate lifetime paths
sim_paths_3 <- simulate_health_state_paths(trans_probs_3, init_age=87, init_state = 0, cohort = 10000)

# statistics (mean and standard deviation): 

# average future lifetime
future_life <- health3_afl(87, init_state = 0, trans_probs_3)

# healthy future lifetime
healthy_life <- health3_hfl(87, init_state = 0, trans_probs_3)

# average future lifetime spent in disabled state
disabled_life <- health3_dfl(87, init_state = 0, trans_probs_3)

# time until onset of disability 
first_disabled <- health3_time_to_disabled(87, trans_probs_3)

# all survival statistics (essentially all of the above outputted in one dataframe)
health3_survival_stats(87, init_state = 0, trans_probs_3)
```

<figure markdown>
  ![statistics](../../img/3_state_workflow/stats_output.png)
</figure>

Statistics for 5-state models:
```r
# first we create a list of transition probability matrices for the 5-state model
trans_probs_5 <- get_trans_probs(n_states=5, model_type='T', param_file=US_HRS_5, init_age=87, female=0, wave_index=13, latent = 0)

# from transition probabilities, we can simulate lifetime paths
sim_paths_5 <- simulate_health_state_paths(trans_probs_5, init_age=87, init_state = 0, cohort = 10000)

# statistics (mean and standard deviation): 

# average future lifetime
total_time_alive <- health5_total_time_stats(sim_paths_5, 4)

# healthy future lifetime
total_time_healthy <- health5_total_time_stats(sim_paths_5, 0)

# average future lifetime spent in M state
total_time_M <- health5_total_time_stats(sim_paths_5, 1)

# time until leaving H state
first_time_H <- health5_first_time_stats(sim_paths_5, 0)

```



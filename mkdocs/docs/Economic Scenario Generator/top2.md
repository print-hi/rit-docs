# Continuous Economic Scenario Generator

placeholder

---

### Generate zero coupon bond interest rate structure

**get_zcp_simulation(num_years = 5, num_paths = 10000, frequency = 'month')**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; num_years : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of years to forecast from 2021-06-01*

&nbsp;&nbsp;&nbsp;&nbsp; num_paths : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the number of simulation paths*

&nbsp;&nbsp;&nbsp;&nbsp; frequency : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'year', 'quarter' or 'month' denoting the simulation frequency*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; a list of 40 dataframes containing simulated trajectories

&nbsp;&nbsp; **Usage:**

```r
# simulate zero-coupon interest structure for 10 years
sim <- get_zcp_simulation(num_years = 10, num_paths = 10000, frequency = 'year')
```


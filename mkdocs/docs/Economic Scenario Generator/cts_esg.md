# Continuous Economic Scenario Generator

The continuous economic scenario generator only simulates the future zero coupon 
bond rates for a more accurate forecast of interest rates. The results are still depicted with
the same simulation frequency options as the discrete case, but the calculations are based 
in continuous time. 

---

### Generate zero coupon bond interest rate structure

**get_afns_simulation(num_years = 5, num_paths = 10, frequency = 'month', type = 'independent', model = 'interest_rate')**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; num_years : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of years to forecast from 2021-06-01*

&nbsp;&nbsp;&nbsp;&nbsp; num_paths : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting the number of simulation paths*

&nbsp;&nbsp;&nbsp;&nbsp; frequency : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'year', 'quarter' or 'month' denoting the simulation frequency*

&nbsp;&nbsp;&nbsp;&nbsp; type : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'independent' or 'correlated' denoting whether the latent factors are independent of each other*

&nbsp;&nbsp;&nbsp;&nbsp; model : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'interest_rate' or 'interest_house_stock' denoting the output variables*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; A list of 40 dataframes containing simulated interest rates with maturities from 1 quarter up to 10 years, or 42 dataframes containing interest rate structure, NSW house value index, S&P/ASX200 closing prices if model is set to be interest_house_stock.  

&nbsp;&nbsp; **Usage:**

```r
# simulate zero-coupon interest structure for 10 years
sim <- get_zcp_simulation(num_years = 10, num_paths = 10000, frequency = 'year')
```


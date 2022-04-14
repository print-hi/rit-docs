# Simulating Cashflows

Simulate cash flows using Monte-Carlo methods for a given policy. Function 
will use generated mortality, health state and economic variables to generate
cashflows for *n* different pathways. This can be used either directly for calculations, 
or passed into the *value_policy* function for pricing statistics.

**simulate_cf(policy, age, sex, seed, n)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **policy** : Policy object 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Policy object generated from create_policy function* (see [ Creating Policy Object](top1.md))

&nbsp;&nbsp;&nbsp;&nbsp; **age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial age of policyholder in years*

&nbsp;&nbsp;&nbsp;&nbsp; **sex** : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sex = "F" (female), "M" (male)*

&nbsp;&nbsp;&nbsp;&nbsp; **seed** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Random seed used for RNG*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Number of paths to simulate (Monte-Carlo method)*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Matrix of cashflows 

&nbsp;&nbsp; **Usage:**
```r
ap <- create_policy_AP(400000, 60000)
cf <- cashflow(policy = ap, age = 65, sex = "M", n = 1000)
```
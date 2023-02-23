# Valuation

Conducts valuation of a given policy, providing summary statistic & plots on the **total discounted value of all cashflows received** by each pathway.

**value_policy(policy, cashflows, seed)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **policy** : Policy object 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Policy object generated from create_policy function* (see [Creating Policy Object](policy.md))

&nbsp;&nbsp;&nbsp;&nbsp; **cashflows** : Matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Matrix of cashflows generated from simulate_cf function* (see [Simulating Cashflows](cashflow.md))

&nbsp;&nbsp;&nbsp;&nbsp; **seed** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Random seed used for random sampling*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; [PolStats](#pol) object

&nbsp;&nbsp; **Usage:**
```r
> ap <- create_policy_AP(400000, 60000)
> cf <- simulate_cf(policy = ap, age = 65, sex = "M", n = 1000)
> v <- value_policy(ap, cf)
========= Policy Details =========
Type        : Account Based Policy
----------------------------------
Balance     : 4e+05
Expense     : 60000

======= Summary Statistics =======
Mean        : $343,583.95
Std Dev     : $39,612.09
----------------------------------
Minimum     : $55,283.93
Maximum     : $590,965.62
----------------------------------
P_0.25      : $316,733.50
P_0.50      : $339,143.08
P_0.75      : $365,797.98
P_0.95      : $413,909.46
P_0.99      : $455,971.51
----------------------------------
Skewness    : 0.44
Kurtosis    : 5.47
==================================
```

<a name ="pol"></a>
**PolStats**

&nbsp;&nbsp; **Attributes:**

&nbsp;&nbsp;&nbsp;&nbsp; **paths** : Vector 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Valuation of individual cashflows by path*

&nbsp;&nbsp;&nbsp;&nbsp; **stats** : List

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Summary statistics of discounted cashflow*

&nbsp;&nbsp;&nbsp;&nbsp; **conv** : Plot

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Convergence plot of simulation using random sampling*

&nbsp;&nbsp;&nbsp;&nbsp; **dist** : Plot

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Distribution plot of present value by path*

&nbsp;&nbsp;&nbsp;&nbsp; **scat** : Plot

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Scatter plot of present value by path*

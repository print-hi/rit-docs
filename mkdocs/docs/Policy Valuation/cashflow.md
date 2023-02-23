# Simulating Cashflows

Simulate cash flows using Monte-Carlo methods for a given policy. Function 
will use generated mortality, health state and economic variables to generate
cashflows for *n* different pathways. This can be used either directly for calculations, 
or passed into the *value_policy* function for pricing statistics.

!!! note
    For each policy, the benefit paid at each time period is defined as below:

    - **Account Based Pension**: If the policyholder is alive, pays the inflation-adjusted expense. If the benefit exceeds the remaining balance, the remaining balance is paid. Otherwise, no benefit is paid.
    - **Life Annuity**: If the deferment period has elapsed and policyholder is alive, pays benefit after flat-rate increase adjustment. Otherwise, no benefit is paid.
    - **Care Annuity**: If policyholder is alive or minimum guaranteed period is still active, pays sum of all benefits a policyholder is eligible for under LTC after flat-rate increase adjustment. Otherwise, no benefit is paid.
    - **Variable Annuity**: If policyholder is alive, pays benefit of the maximum withdrawal amount permissible under the contract. If the benefit exceeds the remaining balance, the remaining balance is paid. Otherwise, no benefit is paid.
    - **Pooled Annuity**: If the policyholder is alive, pays benefit after factoring mortality experience adjustment $(p_{x+t}/p_{x+t}^*)$ and interest rate adjustment $(1+r_{x+t}^*)/(1+r_{x+t})$. Otherwise, no benefit is paid.
    - **Reverse Mortgage**: If the policyholder dies during the time period, pays the surplus of the loan value deducted by house value after adjusting for cost-of-sale. If the surplus is negative or policyholder doesn't die during period, no benefit is paid.

**simulate_cf(policy, age, sex, seed, n)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **policy** : Policy object 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Policy object generated from create_policy function* (see [ Creating Policy Object](policy.md))

&nbsp;&nbsp;&nbsp;&nbsp; **age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial age of policyholder in years*

&nbsp;&nbsp;&nbsp;&nbsp; **sex** : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sex = "F" (female), "M" (male)*

&nbsp;&nbsp;&nbsp;&nbsp; **seed** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Random seed used for RNG*

&nbsp;&nbsp;&nbsp;&nbsp; **n** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Number of paths to simulate (Monte-Carlo method)*

&nbsp;&nbsp;&nbsp;&nbsp; **state** : matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Matrix of health states for $n$ pathways over $m$ periods* (see [Health State](../Health/Health State 3/simulation.md) / [Mortality](../Aggregate Mortality/simulation.md))

&nbsp;&nbsp;&nbsp;&nbsp; **econ_var** : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *List of matrices for each economic variables required by the chosen policy, these include:* 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *$sdf: stochastic discount factor* -> required by All Policies

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *$infla: inflation index* -> required by Account Based Pension

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *$stock: stock price* -> required by Account Based Pension, Pooled Annuity, Variable Annuity

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *$zcp3m: zero-coupon bond yield (3-month)* -> required by Reverse Mortgage

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *$house: house price* -> required by Reverse Mortgage

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (see [Economic Scenario Generator](../Economic Scenario Generator/discrete_esg.md) for example implementation)

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; [SimCashflow](#simcf) object 

&nbsp;&nbsp; **Usage:**
```r
ap <- create_policy_AP(400000, 60000)
cf <- simulate_cf(policy = ap, age = 65, sex = "M", n = 1000)
```

!!! note
    **state** & **econ_var** use $n × m$ matrices, where $n$ is the number of simulated paths
    and $m$ is the number of periods. Any periodicity can be used as long as all matrices are
    consistent, i.e. each time-step can represent a month, year, or other length (simulation defaults to annual period).

!!! note
    Economic variables needed by each policy:

    - **Account Based Pension**: requires stochastic discount factors (*\$sdf*), inflation rate (*\$infla*) & investment return (*\$stock*).
    - **Life Annuity**: requires stochastic discount factors (*\$sdf*).
    - **Care Annuity**: requires stochastic discount factors (*\$sdf*).
    - **Variable Annuity**: requires stochastic discount factors (*\$sdf*), investment return (*\$stock*).
    - **Pooled Annuity**: requires stochastic discount factors (*\$sdf*), investment return (*\$stock*).
    - **Reverse Mortgage**: requires stochastic discount factors (*\$sdf*), 3-month zero-coupon bond yield (*\$zcp3m*) & change in house price (*\$house*).

<a name ="simcf"></a>
**SimCashflow**

&nbsp;&nbsp; **Attributes:**

&nbsp;&nbsp;&nbsp;&nbsp; **cf** : Matrix 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Simulated cashflows* for each pathway at every time step

&nbsp;&nbsp;&nbsp;&nbsp; **sdf** : Matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Stochastic discount factors for each pathway at every time step*

!!! note
    **cf** & **sdf** are $n × m$ matrices, where $n$ is the number of simulated paths
    and $m$ is the number of periods.
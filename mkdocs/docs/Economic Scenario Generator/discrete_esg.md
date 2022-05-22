# Discrete-Time Generator

The discrete-time economic scenario generator simulates the trajectories of 11 Australian economic and financial variables: 

(1) 3-month zero-coupon bond yields,

(2) 10-year zero-coupon bond spread,

(3) NSW home value index,

(4) NSW home rental yields,

(5) Australia GDP,

(6) Australia CPI,

(7) S&P/ASX200 closing price,

(8) Australian dollar trade-weighted index,

(9) Australia mortgage rate,

(10) NSW unemployment rate,

(11) Stochastic discount factors (pricing kernels).

The factors (1)-(8) were fitted using a Vector Autoregressive model (VAR), factors (9)-(10) were respectively expressed as a fixed margin over factors (1)-(2) due to strong correlations, while factor (11) is derived from the VAR with arbitrage-free assumptions. 

Vector Autoregression (VAR) is a regression of a time series where the ouput depends linearly on the past values of itself, and the past values of other variables, up to some specfied order: ![](https://latex.codecogs.com/svg.image?\mathbf{z}_{t}&space;=&space;\mathbf{\mu}&space;&plus;&space;\Phi_{1}\mathbf{z}_{t-1}&plus;&space;\Phi_{2}\mathbf{z}_{t-2}&plus;\cdots&plus;&space;\Phi_{p}\mathbf{z}_{t-p}&space;&plus;&space;\mathbf{\epsilon})


$$
\mathbf{z}_{t} = \boldsymbol{\mu} + \Phi_{1}\mathbf{z}_{t-1}+ \Phi_{2}\mathbf{z}_{t-2}+\cdots+ \Phi_{p}\mathbf{z}_{t-p} + \boldsymbol{\epsilon},
$$

where  

* $\mathbf{z}_{t}$ is the vector of economic variables,

* $\boldsymbol{\mu}$ is the vector of intercepts,

* $\Phi_{i}$, for $i=1,\cdots, p$ are coefficient matrices of size $n \times n$ with $n$ being the number of economic variables and $p$ the lags. 

* $\boldsymbol{\epsilon}$ is a vector of white noises. 

The stochastic discount factor is defined as: $$
s_{t+1} = \exp \left(- \mathbf{e}_1 ^\top \mathbf{z}_t - \frac{1}{2} \mathbf{\lambda}_t^\top \mathbf{\lambda}_t - \mathbf{\lambda}_t^\top \mathbf{\epsilon}_{t+1} \right),
$$

where $\mathbf{e}_1^\top \mathbf{z}_t$ and $\mathbf{\epsilon}_t$ respectively denote the 3-month zero-coupon bond rates and  the white noises from the fitted VAR model, and $\mathbf{\lambda}_t$ is the market price of risk process.


---


**get_var_simulations(num_years = 5, num_paths = 10, frequency = 'quarter', per_change = FALSE, return_sdf = FALSE)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; num_years : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of years to forecast from 2021-01-01*

&nbsp;&nbsp;&nbsp;&nbsp; num_paths : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of simulations to make for each variable*

&nbsp;&nbsp;&nbsp;&nbsp; frequency : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'year', 'quarter' or 'month' denoting the simulation frequency*

&nbsp;&nbsp;&nbsp;&nbsp; perc_change : logical

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE for outputs to be expressed as percent change*

&nbsp;&nbsp;&nbsp;&nbsp; return_sdf : logical 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *set TRUE to return the stochastic discount factors*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; A list of 10 dataframes containing simulated trajectories of the 10 variables, or a list of 11 dataframes including the simulated stochastic discount factors if return_sdf is set TRUE.  

&nbsp;&nbsp; **Usage:**

```r
# simulate 10 years of data
sim <- get_var_simulations(num_years = 10, num_paths = 10000, frequency = 'year')

# suppose we wish to look at the 3 months zero coupon bonds
sim$zcp3m_yield

# if we wanted a specific trajectory, say 103
sim$zcp3m_yield$trajectory_103
```
























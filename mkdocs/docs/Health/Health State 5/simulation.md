# Simulating Life Paths

Expected values are easily derived from the transition probabilities, but some form of 
simulation is required to analyse variance of risks. Simulation can be performed by using the
transition probability matrices. 

Everyone starts in a certain health state, and we sample movements according to 
the probabilities given at each age. Death state, -1, is absorbing. The other states are:

* 0: healthy

* 1: ill health but not functionally disabled

* 2: good health but functionally disabled

* 3: ill health and functionally disabled

---

### Simulating State Paths for Individuals

**health5_simulate_individual_path(model, init_age, init_state, params, gender, i, cohort = 10000)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; model : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'S' for static model, 'T' for trend model, 'F' for frailty model*

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; init_state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial state (see above)*

&nbsp;&nbsp;&nbsp;&nbsp; params : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Matrix of estimated parameters to construct the five  state model. The rows are $\beta$, $\gamma^{\text{age}}$, $\gamma^{\text{f}}$, $\phi$ (if trend or frailty model), $\alpha$ (if frailty model). The columns are 1-12 transition types.*

&nbsp;&nbsp;&nbsp;&nbsp; gender : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; i : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave index = (interview year - 1998)/2 + 1*

&nbsp;&nbsp;&nbsp;&nbsp; cohort : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of lives to simulate*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix (see below for details)

&nbsp;&nbsp; **Usage:**

```r
# simulation for 10000 males aged 65, initially healthy under the frailty model
simulated_path <- health5_simulate_individual_path(model='F', init_age=65, init_state=0, params=params_5_frailty, gender=0, i=8, cohort = 10000)
```

The output is a matrix where each row represents one individual's transition into different 
states at each year of their life. 

An example looks like: 

\begin{bmatrix}
0 & 0 & 1 & 1 & \ldots & -1\\
0 & 0 & 2 & 2 & \ldots & 3 \\
 &  &  \vdots & & & \\
0 & -1 & -1 & -1 & \ldots & -1 \\
0 & 0 & 3 & 2 & \ldots & 2
\end{bmatrix}

!!! note
    The first column of the matrix will always be initial state provided in the parameters.


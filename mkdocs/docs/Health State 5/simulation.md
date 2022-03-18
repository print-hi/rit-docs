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

* 4: dead

---

### Simulating lives

**simulate_individual_path(init_age, init_state, params, gender, i, cohort = 10000, model)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; init_age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; init_state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting initial state (see above)*

&nbsp;&nbsp;&nbsp;&nbsp; params : dataframe

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dataframe of parameters read from excel file*

&nbsp;&nbsp;&nbsp;&nbsp; gender : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 for male, 1 for female*

&nbsp;&nbsp;&nbsp;&nbsp; i : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave index = (interview year - 1998)/2 + 1*

&nbsp;&nbsp;&nbsp;&nbsp; cohort : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting number of lives to simulate*

&nbsp;&nbsp;&nbsp;&nbsp; model : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *1 for static, 2 for trend, 3 for frailty*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix (see below for details)

&nbsp;&nbsp; **Usage:**

```r
# simulation for male aged 65, initially healthy uunder the frailty model
simulated_path <- function(init_age=65, init_state=0, params, gender=0, i, cohort = 10000, model=3)
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
$

!!! note
The first column of the matrix will always be initial state provided in the parameters.
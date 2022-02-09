# Simulating Life Paths

Expected values are easily derived from the transition probabilities, but some form of 
simulation is required to analyse variance of risks. Simulation can be performed by using the
transition probability matrices. 

Everyone starts in a certain health state (0 for healthy and 1 for disabled), and we sample
movements according to the probabilities given at each age. Death state, -1, is absorbing. 

### `simulate_path`

Usage of the function is:

```r
# list of transition probability matrices under the trend model, 
# using US_HRS parameters of 65 year old male in 2021

trans_probs <- get_trans_probs('T', US_HRS, 65, 0, 2021)

# create simulated paths for 10,000 (default cohort size) individuals
# given initial age 65 and initial state in healthy
SP <- simulate_paths(65, 0, trans_probs)
```

The output is a matrix where each row represents a single individual's state transitions
across the years. 

An example looks like: 

\begin{pmatrix}
0 & 0 & 1 & 0 & \ldots & -1 \\
0 & 0 & 0 & 0 & \ldots & -1 \\
 &  &  \vdots & & & \\
0 & 1 & 1 & 1 & \ldots & -1 \\
0 & 0 & -1 & -1 & \ldots & -1
\end{pmatrix}

!!! note
    The first column of the matrix will always be initial state provided in the parameters, 
    and the last column will always be -1, signifying everyone will be dead at age 111 (110 is
    the maximum age of the model). 
# Transition Probability Matrix

The Cox Hazard model produces continuous hazard rates, which we discretise by
integrating the rates over a year to produce piecewise constant transition rates. 

This process is repeated for each of the 4 transitions. The transition rates for each age are then
put into a transition rate matrix, which can be transformed a transition probabilty matrix by
taking the matrix exponential. 

!!! note
    The transition probability matrices are deterministic for each individual with the 
    Static and Trend models, but stochastic with the Frailty model. 

This process is executed by the function 'get_trans_probs'.

---

### `get_trans_probs`

The usage of the function for a certain individual could look like:

```r
# list of transition probability matrices under the trend model, 
# using US_HRS parameters of 65 year old male in 2021

trans_probs <- get_trans_probs('T', US_HRS, 65, 0, 2021)
```

This transition probability matrices up to and including 110-111, in which everyone dies: 

\begin{pmatrix}
0 & 0 & 1 \\
0 & 0 & 1 \\
0 & 0 & 1 
\end{pmatrix}

The transition probability matrices can then be used to conduct more in depth mortality 
study. 

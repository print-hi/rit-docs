# Transition Probability Matrix

The Cox Hazard model produces continuous hazard rates, which we discretise by
integrating the rates over a year to produce piecewise constant transition rates. 

This process is repeated for each of the four health state transitions. The transition rates for each age are then
put into a transition rate matrix, which can be transformed a transition probabilty matrix by
taking the matrix exponential. 

Note that
    the transition probability matrices are deterministic for each individual with the 
    Static and Trend models, but stochastic with the Frailty model. 


---

### Get Transition Probability

**get_trans_probs(model_type, param_file, init_age, female, year)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **model_type** : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *'S' for static model, 'T' for trend, 'F' for frailty*

&nbsp;&nbsp;&nbsp;&nbsp; **param_file** : character OR dataframe/tibble

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *File path, or dataframe/tibble of parameters (generally, use US_HRS or china_CLHLS)*

&nbsp;&nbsp;&nbsp;&nbsp; **init_age** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; **female** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *0 indicates male, 1 indicates female*

&nbsp;&nbsp;&nbsp;&nbsp; **year** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *integer denoting current year*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; List of transition probability matrices up to and including 110-111, in which everyone dies: 

\begin{pmatrix}
0 & 0 & 1 \\
0 & 0 & 1 \\
0 & 0 & 1 
\end{pmatrix}

The transition probability matrices can then be used to conduct more in depth mortality 
study. 

&nbsp;&nbsp; **Usage:**

```r
# list of transition probability matrices under the trend model, 
# using US_HRS parameters of 65 year old male in 2021

trans_probs <- get_trans_probs('T', US_HRS, 65, 0, 2021)
```


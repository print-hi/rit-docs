# Risk Neutral Probability

'StoMoMo' produces real world death/survival probabilities, which are useful for mortality 
studies, but not for derivative pricing. This module includes a function that transforms the 
real world (P world) survival function to a risk neutral (Q world) survival function. 

There are many transformation methods, with our function allowing for the following risk
neutral principles: 

* Wang transform : 'wang'

* Proportional Hazard transform : 'ph'

* Dual power transform : 'dp'

* Gini principle : 'gp'

* Denneberg's Absolute Deviation Principle : 'dadp'

* Exponential transform : 'exp'

* Logarithmic transform : 'log'

* Univariate Canonical Valuation : 'canon'

* Esscher transform : 'Esscher'

For each of the above transformation methods, our model allows the input of parameter $\lambda$. 

---

**survivalP2Q(StP, method, lambda)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; StP : vector/matrix

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *contains the survival function under the P measure* 

&nbsp;&nbsp;&nbsp;&nbsp; method : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *distortion risk measure to use*

&nbsp;&nbsp;&nbsp;&nbsp; lambda : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *parameter associated with the distortion risk measure*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; risk neutral survival function under specified Q-measure 

&nbsp;&nbsp; **Usage:**

```r
# Consider a variable with the P world survival function: surv_probs

# risk neutral survival func
rn_surv_prob <- survivalP2Q(surv_probs, 'wang', 0.34)
```


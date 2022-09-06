# Risk Neutral Probability

Real world survival probabilities are very useful for mortality studies. 
However, they do not account for longevity risk - the financial risk that people live longer 
than expected and are thus not suitable for the pricing of insurance products. Hence, 
this module includes a function that transforms the real world (P world) survival function 
to a risk neutral (Q world) survival function according to a risk-neutral principle
following Tang & Li (2021).

To introduce the transformation methods used by this function, the following simplified 
notation is used:

* $f^P(t)$ or $f^Q(t)$: probability density function (pdf)
* $F^P(t)$ or $F^Q(t)$: cumulative distribution function (cdf)
* $S^P(t)$ or $S^Q(t)$: survival function

where $S^P(t) = 1 - F^P(t)$ and $S^Q(t) = 1 - F^Q(t)$.
Note that these functions are applied on an individual aged $x$ in year $y$ for each 
simulation $i$.

The first set of transformations are survival function distortions and are as follows:

* Wang transform: $S^Q(t) = 1 - \Phi(\Phi^{-1}(1 - S^P(t)) - \lambda) \quad (\lambda \geq 0)$ 
<br> where $\Phi(x)$ represents the cdf of a standard Gaussian distribution.

* Proportional hazard transform: $S^Q(t) = (S^P(t))^{\frac{1}{\lambda}} \quad (\lambda \geq 1)$
* Dual-power transform: $S^Q(t) = 1 - \left(1 - S^P(t)\right)^\lambda \quad (\lambda \geq 1)$ 
* Gini principle: $S^Q(t) = (1 + \lambda)S^P(t) - \lambda(S^P(t))^2 \quad (0 \leq \lambda \leq 1)$ 
* Denneberg's absolute deviation principle: 
$S^Q(t) = \begin{cases}
            (1 + \lambda)S^P(t), & 0 \leq S^P(t) < 0.5 \\
            \lambda + (1 - \lambda)S^P(t), & 0.5 \leq S^P(t) \leq 1
         \end{cases}
         \quad (0 \leq \lambda \leq 1)$ 
* Exponential transform: $S^Q(t) = \frac{1 - e^{-\lambda S^P(t)}}{1 - e^{-\lambda}} \quad (\lambda > 0)$ 
* Logarithmic transform: $S^Q(t) = \frac{\log(1 + \lambda S^P(t))}{\log(1 + \lambda)} \quad (\lambda > 0)$

The remaining transformations are pdf distortions and are given by:

* Canonical valuation: $f^Q(t) = \frac{e^{\lambda t} f^P(t)}{\sum^\infty_{s=0} e^{\lambda s} f^P(s)} \quad (\lambda > 0)$
* Esscher transform: $f^Q(t) = \frac{e^{\lambda t} f^P(t)}{\mathbb{E}[e^{\lambda t}]} =
    \frac{e^{\lambda t} f^P(t)}{\sum^\infty_{s=0} e^{\lambda s} f^P(s)} \quad (\lambda > 0)$

We note that for the pdf distortions (univariate canonical valuation and esscher transforms),
the risk-adjusted pdfs are identical.

---

### Survival Function Risk-Neutral Transformation

**survivalP2Q(StP, method, lambda)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; StP : matrix/array

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *survival function under P-measure with survival time rows,
cohort/year columns*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(and simulation number 3rd dimension)*

&nbsp;&nbsp;&nbsp;&nbsp; method : character

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *the distortion risk measure to be used, see details for more information*

&nbsp;&nbsp;&nbsp;&nbsp; lambda : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *parameter associated with the distortion risk measure*

&nbsp;&nbsp; **Details:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"wang": Wang Transform $(\lambda \geq 0)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"ph": Proportional Hazard Transform $(\lambda \geq 1)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"dp": Dual-power Transform $(\lambda \geq 1)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"gp": Gini Principle $(0 \leq \lambda \leq 1)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"dadp": Denneberg's Absolute Deviation Principle $(0 \leq \lambda \leq 1)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"exp": Exponential Transform $(\lambda > 0)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"log": Logarithmic Transform $(\lambda > 0)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"canon": Univariate Canonical Valuation $(\lambda > 0)$*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"esscher": Esscher Transform $(\lambda > 0)$*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; matrix/array of risk neutral survival function under specified Q-measure
with survival time

&nbsp;&nbsp;&nbsp;&nbsp; rows, cohort/year columns (and simulation number 3rd dimension)

&nbsp;&nbsp; **Usage:**

```r
# create survival function for an individual aged 55
AUS_male_rates <- mortality_AUS_data$rate$male
ages <- mortality_AUS_data$age # 0:110
old_ages <- 91:130
fitted_ages <- 76:90

completed_rates <- complete_old_age(AUS_male_rates, ages, old_ages,
                                    method = "kannisto", type = "central",
                                    fitted_ages = fitted_ages)

all_ages <- 0:130
surv_func <- rate2survival(completed_rates, ages = all_ages,
                           from = 'central', init_age = 55)

# convert from P to Q measure survival function
surv_func_Q <- survivalP2Q(surv_func, method = "wang", lambda = 1.5)
```

&nbsp;&nbsp; **References:**

Sixian Tang & Jackie Li (2021) Market pricing of longevity-linked securities, Scandinavian Actuarial Journal, 2021:5, 408-436, DOI: 10.1080/03461238.2020.1852105

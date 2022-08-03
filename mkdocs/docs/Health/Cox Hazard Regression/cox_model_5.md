# 5-State Model

## General Principle

The Cox Proportional Hazards Model is used to estimate the hazard rate or transition
intensity for different transitions. The general form of the transition intensities for 
an individual $k$ and transition type $s$ is: 

$$\lambda_{k, s}(t)=\exp \left\{\beta_{s}+\gamma_{s}^{\prime} w_{k}(t)+\alpha_{s} \psi(t)\right\}$$

In the above forumlation, $\beta_{s}$ is the baseline log-intensity for transition type $s$, $w_{k}(t)$ contains the age and gender of the individuals, $\gamma_{s}^{\prime}$ measure the sensitivity to age and gender, $\psi(t)$ is a latent process that captures the uncertainty, and $\alpha_{s}$ measures the sensitivity to the latent process.
### Three Models

#### Static Model 

$$\ln \left\{\lambda_{k, s}(t)\right\}=\beta_{s}+\gamma_{s}^{\text{age}} x_{k}(t)+\gamma_{s}^{\text {female}} F_{k},$$

where $x_k(t)$ represents the age for the $k$th individual at time t and $F_k = 1$ if the $k$th
individual is female. The coefficients are parameters to be estimated.

#### Trend Model 

$$\ln \left\{\lambda_{k, s}(t)\right\}=\beta_{s}+\gamma_{s}^{\text{age}} x_{k}(t)+\gamma_{s}^{\text {female}} F_{k}+\phi_{s} i,$$

where $i$ is the index number of the interview indicating the time trend. Note that $i=1$ corresponds to the interview year 1998, and the interview is taken every two years. Therefore, i=(interview year - 1998)/2 + 1.

#### Frailty Model

$$\ln \left\{\lambda_{k, s}(t)\right\}=\beta_{s}+\gamma_{s}^{\text{age}} x_{k}(t)+\gamma_{s}^{\text {female}} F_{k}+\phi_{s} i+\alpha_{s} \psi_{i},$$

where $\psi_{i}$ captures the stochastic latent factor. In our model, we use a random walk:
$\psi_{i} = \psi_{i-1} + \epsilon_{i}$ with $\epsilon_{i} \sim \text{N}(0, 1)$.

### Parameters

The module uses cox hazard model parameters estimated from external research studies. The paper that this module refers to is available at: https://www.cepar.edu.au/publications/working-papers/multi-state-model-functional-disability-and-health-status-presence-systematic-trend-and-uncertainty

The estimated parameters of the static, trend, and frailty models from the above study with the US HRS data are embedded in the module:

* US Health and Retirement Study (parameter name: US_HRS_5)
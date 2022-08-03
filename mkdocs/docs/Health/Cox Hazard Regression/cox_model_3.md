# 3-State Model

## General Principle

The Cox Proportional Hazards Model is used to estimate the hazard rate or transition
intensity for different transitions. The general form of the transition intensities for 
an individual $k$ and transition type $s$ is: 

$$\lambda_{k, s}(t) = \text{exp}(\boldsymbol{\beta}_{s}'\mathbf{X}_k) \cdot H_{k, s}(t)$$

In the above forumlation, $\boldsymbol{\beta}$ contains coefficients of transition type $s$ to be
estimated, and $\mathbf{X}$ contains the covariates of individual $k$. Furthermore, we assume the 
Markovaian property where $H_{k, s}(t) = 1$. 

### Three Models

#### Static Model 

$$
\text{ln}\lambda_{k, s}(t) = \beta_s + \gamma^{\text{age}}_s x_k(t) 
+ \gamma^{\text{female}}_s F_k
$$

where $x_k(t)$ represents the age for the $k$th individual at time t and $F_k = 1$ if the $k$th
individual is female. The coefficients are parameters to be estimated.

#### Trend Model 

$$
\text{ln}\lambda_{k, s}(t) = \beta_s + \gamma^{\text{age}}_s x_k(t) 
+ \gamma^{\text{female}}_s F_k + \gamma^{\text{time}}_s t
$$

where $t$ is the time trend. Note that $t=1$ corresponds to the year 1998-1999. 

#### Frailty Model

$$
\text{ln}\lambda_{k, s}(t) = \beta_s + \gamma^{\text{age}}_s x_k(t) 
+ \gamma^{\text{female}}_s F_k + \gamma^{\text{time}}_s t + \alpha_s \psi(t)
$$

where $\psi(t)$ captures the stochastic latent factor. In our model, we use a random walk:
$\psi(t) = \psi(t-1) + \epsilon$ with $\epsilon \sim \text{N}(0, 1)$.

### Parameters

The module uses cox hazard model parameters estimated from external research studies. The parameters
of the two following studies are included in the package: 

* US Health and Retirement Study (parameter name: US_HRS)

* China Chinese Longitudinal Healthy Longevity Survey (parameter name: china_CLHLS)


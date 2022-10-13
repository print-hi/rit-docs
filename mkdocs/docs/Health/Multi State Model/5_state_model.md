# # 5-State Model

This module conducts mortality analysis using the 5 state model with the following transitions: 

<figure markdown>
  ![Image title](../../img/5_state_model.png){ width="400"}
</figure>

The five states are: 

* H: Healthy and not functionally disabled

* D: Healthy and functionally disabled

* M: Ill health and not functionally disabled

* MD: Ill health and functionally disabled

* Dead

Some studies have already been conducted on this model using fitted Cox Regression models. This module
applies the parameters estimated from these studies to analyse the survival statistics of a given
individual. The paper that this module refers to is available at: https://www.cepar.edu.au/publications/working-papers/multi-state-model-functional-disability-and-health-status-presence-systematic-trend-and-uncertainty

The transition types are numbered from 1 to 12 illustrated in the table below.
<figure markdown>
  ![Image title](../../img/5_state_model_transition.png){ width="800"}
</figure>

Functionalities of the module includes:

* Calculating transition probability matrices from parameters of Cox Regression model

* Creating life tables for a certain individual characteristic

* Simulating lifetime paths 

* Returning key survival statistics for a certain individual 

These functions can be helpful in conducting mortality studies, as well as applications in 
insurance pricing.
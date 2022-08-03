# 3-State Model

This module conducts mortality analysis using the 3 state model with the following transitions: 

<figure markdown>
  ![3_state_model](../../img/3_state_model.png){width="400"}
</figure>

The three states are: 

* H: Healthy

* F: Disabled 

* D: Dead

Some studies have already been conducted on this model using fitted Cox Regression models. This module
applies the parameters estimated from these studies to analyse the survival statistics of a given
individual. 

Functionalities of the module includes:

* Calculating transition probability matrices from parameters of Cox Regression model

* Creating life tables for a certain individual characteristic

* Simulating lifetime paths 

* Returning key survival statistics for a certain individual 

These functions can be helpful in conducting mortality studies, as well as applications in 
insurance pricing. 

The general overview and usage of the module can be seen in the following flowchart: 

<figure markdown>
  ![3_state_flowchart](../../img/3_state_flowchart.png){width="750"}
</figure>

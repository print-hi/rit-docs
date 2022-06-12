# Overview

There is a popular package in R, StMoMo, that is used for stochastic mortality modelling. It 
includes functions that fit a wide range of age-period-cohort models such as the Lee-Carter, 
Cairns-Blake-Dowd models and many others. These are typically used to forecast and simulate
future mortality rates.

The aggregate mortality module extends upon the StMoMo package by introducing the following
functionalities:

* Adding methods for more accurate mortality estimation at older ages (rate completion)
* Transforming survival functions from the real world to the risk-free probability measure
* Distribution and quantile functions of a survival function
* Simulation plots of the survival function and expected curtate future lifetime for a cohort

These functions will allow for more accurate mortality studies at older ages (90+)
and the pricing of a diverse range of insurance products.

This module should be used in tandem with the StMoMo package. Namely, the inputs of this module 
will usually be the mortality rates outputted by the StMoMo package. A general overview of the 
module and the sequence of function executions can be visualised by the flowchart below:

<figure markdown>
  ![agg_mor_flowchart](../img/agg_mor_flowchart.png){width="700"}
</figure>


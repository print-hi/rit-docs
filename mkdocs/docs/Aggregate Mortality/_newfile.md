# Overview

There is a popular package in R, StoMoMo, that is used for stochastic mortality modelling. It 
includes functions that fit a wide range of models from Lee-Carter, CBD model, APC mode, and many
others.

The aggregate mortality module extends upon the functionality of the StoMoMo package, adding 
methods for more accurate mortality estimation at older ages (age completion) and transformations
from real world probability measure survival functions to risk free probability survival functions.

These allow for applications in: 

* more accurate mortality studies at older ages (90+)

* pricing of a diverse range of insurance products 


This module should be used in tandem with the StoMoMo package. Namely, the inputs of this module 
will usually be the mortality rates outputted by the StoMoMo package. A general overview of the 
module and the sequence of function executions can be visualised by the flowchart below:

<figure markdown>
  ![agg_mor_flowchart](/img/agg_mor_flowchart.png){width="700"}
</figure>


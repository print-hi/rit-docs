# Transition Probability Matrix

The Cox Hazard model produces continuous hazard rates, which we discretise by
integrating the rates over a year to produce piecewise constant transition rates. 

This process is repeated for each of the 4 transitions. The transition rates for each age are then
put into a transition rate matrix, which can be transformed a transition probabilty matrix by
taking the matarix exponential. 

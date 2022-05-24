# Overview

To price a financial product/instrument that will have cashflows in the future, 
the present time valuation requires a set of assumptions on different economic factors. 
The purpose of this module is to simulate a set of 11 economic variables that will 
characterise the economic envrionment for a specified amount of time into the future. 

The 10 economic factors that will be simulated are:

1. 3-month zero-coupon yield,

2. 10-year zero-coupon spread,

3. NSW hedonic house value index,

4. NSW house rental yields,

5. Australia GDP,

6. Australia CPI,

7. S&P/ASX200 closing price,

8. Australian dollar trade-weighted index,

9. Australia mortgage rate,

10. NSW unemployment rate,

11. Stochastic discount factors (pricing kernels). 

These 11 factors can provide a comprehensive picture of the economic environment in the 
future, which is useful for projecting investments/financial products into the future, as well 
as discounting future cash flows to more accurately gauge present value. This allows for broad
appliations in insurance pricing, loan/debt pricing, and project valuations.

The module has a discrete-time economic scenario generator (ESG), and a continuous-time ESG. The discrete-time ESG
is fit on discrete time intervals, whereas continuous-time ESG's can in theory be fit for any time 
point. However, the module uses the same simulation frequencies for both ESG types. 


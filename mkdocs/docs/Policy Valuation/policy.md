# Creating Policy Object

To begin, we need to initialise a policy object which contains all 
relevant parameters describing the policy.

## Functions

* [`create_policy_AP`](#ABP) - Account Based Pension
* [`create_policy_RM`](#RM) - Reverse Mortgage
* [`create_policy_LA`](#LA) - Life Annuity
* [`create_policy_PA`](#PA) - Pooled Annuity
* [`create_policy_CA`](#CA) - Care Annuity (LTC)
* [`create_policy_VA`](#VA) - Variable Annuity (GMWB)

<a name="ABP"></a>

## Account Based Pension

**create_policy_AP(balance, expenses)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **balance** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial balance of Pension account*

&nbsp;&nbsp;&nbsp;&nbsp; **expenses** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial yearly expenses for policyholder*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
ap <- create_policy_AP(400000, 60000)
```

<a name="RM"></a>

## Reverse Mortgage (NNEG)

**create_policy_RM(value, LVR, trans_cost, margin)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **value** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial value of property*

&nbsp;&nbsp;&nbsp;&nbsp; **LVR** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Loan to Value ratio for PH*

&nbsp;&nbsp;&nbsp;&nbsp; **trans_cost** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Transaction cost associated with sale*

&nbsp;&nbsp;&nbsp;&nbsp; **margin** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Lending margin*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
rm <- create_policy_RM(100000, 0.4, 0.01, 0.05)
```

<a name="LA"></a>

## Life Annuity

**create_policy_LA(benefit, defer = 0, increase = 0, loading)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **benefit** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Annual benefit for policy*

&nbsp;&nbsp;&nbsp;&nbsp; **defer** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(Optional) Deferment period of policy*

&nbsp;&nbsp;&nbsp;&nbsp; **increase** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(Optional) Annual rate of increase for policy*

&nbsp;&nbsp;&nbsp;&nbsp; **loading** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Loading factor for contract*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
la <- create_policy_LA(60000, 5, 0.04, 0.05)
```

<a name="CA"></a>

## Care Annuity (LTC)

Note: Care annuities are evaluated based on the 3-State or 5-State model 
outlined in the [Health State module](../Health/overview.md). Parameters should be vectors of length
2 or 4 (no benefits paid whilst PH is dead, policies are characterized by 
remaining states).

**create_policy_CA(benefit, increase, min, loading)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **benefit** : vector 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Annual benefit for each policy*

&nbsp;&nbsp;&nbsp;&nbsp; **increase** : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Annual rate of increase for each policy*

&nbsp;&nbsp;&nbsp;&nbsp; **min** : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Minimum guaranteed period for each policy*

&nbsp;&nbsp;&nbsp;&nbsp; **loading** : vector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Loading factor for each policy*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
ca <- create_policy_CA(c(60000, 1200), c(0, 0.04), c(8, 0), c(0.04, 0.05))
```

<a name="PA"></a>

## Pooled Annuity

**create_policy_PA(benefit, size, interest, loading)**

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **balance** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial annual benefit for policy*

&nbsp;&nbsp;&nbsp;&nbsp; **size** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Size of pool*

&nbsp;&nbsp;&nbsp;&nbsp; **interest** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Assumed investment earnings rate (flat)*

&nbsp;&nbsp;&nbsp;&nbsp; **loading** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Loading factor for contract*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
pa <- create_policy_PA(60000, 1000, 0.04, 0.05)
```

<a name="VA"></a>

## Variable Annuity (GMWB)

**create_policy_VA(value, length, prop, g_fee) **

&nbsp;&nbsp; **Parameters:**

&nbsp;&nbsp;&nbsp;&nbsp; **value** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Initial Account value (single upfront premium)*

&nbsp;&nbsp;&nbsp;&nbsp; **length** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Length of contract (in years)*

&nbsp;&nbsp;&nbsp;&nbsp; **prop** : numeric 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Proportion of the premium that can be withdrawn annually*

&nbsp;&nbsp;&nbsp;&nbsp; **g_fee** : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Continuous guarantee fees for GMWB*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; Policy object

&nbsp;&nbsp; **Usage:**

```r
va <- create_policy_VA(100000, 40, 0.4, 0.02)
```
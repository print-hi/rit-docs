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
la <- create_policy_LA(60000, 5, 0.04, 0.05)
```

<a name="PA"></a>

## Pooled Annuity

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
pa <- create_policy_PA(60000, 1000, 0.04, 0.05)
```

<a name="CA"></a>

## Care Annuity (LTC)

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
ca <- create_policy_CA(c(60000, 1200), c(0, 0.04), c(8, 0), c(0.04, 0.05))
```

<a name="VA"></a>

## Variable Annuity (GMWB)

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
va <- create_policy_VA(100000, 40, 0.4, 0.02, 0.02)
```
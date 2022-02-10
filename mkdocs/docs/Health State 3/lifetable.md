# Life Table Generation

We can create a cohort multi-state lifetable for a specified individual using the corresponding
transition probability matrices. This can be used for the following applications:

* calculating probability of survival to different states
* calculating remaining life expectancy 

Given a set of transition probability matrices, the life table that is generated is always
deterministic; it is generated off of expected values and not simulation. 

One can also specify the initial state that the cohort is in for the life table: healthy (default)
or disabled. 

---

### Generating a Life Table

**create_life_table(trans_probs, age, init_state)**

&nbsp;&nbsp; **Paramters:**

&nbsp;&nbsp;&nbsp;&nbsp; trans_probs : list

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *list of transition probability matrices*

&nbsp;&nbsp;&nbsp;&nbsp; age : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *numeric denoting initial age of individual*

&nbsp;&nbsp;&nbsp;&nbsp; init_state : numeric

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *initial state of cohort: 0 for healthy, 1 for disabled*

&nbsp;&nbsp; **Returns:**

&nbsp;&nbsp;&nbsp;&nbsp; lifetable as a dataframe

&nbsp;&nbsp; **Usage:**

```r
# list of transition probability matrices under the trend model, 
# using US_HRS parameters of 65 year old male in 2021

trans_probs <- get_trans_probs('T', US_HRS, 65, 0, 2021)

# generate life table from the transition probability with starting
# cohort of 10,000 (default)
life_table <- create_life_table(trans_probs, 65, 0)
```

!!! note
    The lifetable ends at 110, and everyone still alive is assumed to die during age 110-111.
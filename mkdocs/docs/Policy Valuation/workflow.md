# Workflow Example

## Default Behaviour

```r
# Account-Based Pension
ap <- create_policy_AP(1000000, 50000)
cf_ap <- simulate_cf(ap)
val_ap <- value_policy(ap, cf_ap)

# Life Annuity
la <- create_policy_LA(60000, 5, 0, 0.01)
cf_la <- simulate_cf(la)
val_la <- value_policy(la, cf_la)

# Pooled Annuity
pa <- create_policy_PA(60000, 10000, 0.05, 0.01)
cf_pa <- simulate_cf(pa)
val_pa <- value_policy(pa, cf_pa)

# Care Annuity
ca <- create_policy_CA(c(60000, 1200), c(0, 0.04), c(5, 0), c(0.04, 0.01))
cf_ca <- simulate_cf(ca)
val_ca <- value_policy(ca, cf_ca)

# Reverse Mortgage
rm <- create_policy_RM(600000, 0.64, 0.01, 0.04)
cf_rm <- simulate_cf(rm)
val_rm <- value_policy(rm, cf_rm)

# Variable Annuity (GMWB)
va <- create_policy_VA(1000000, 30, 0.1, 0.01)
cf_va <- simulate_cf(va)
val_va <- value_policy(va, cf_va)
```

## Customised Behaviour

### Example 1: Life annuity where n'th policyholder dies in year n

```r
construct_state_matrix <- function(ages_at_death, max_years) {
    n_paths <- length(ages_at_death)

    # Create matrix with all entries = -1 (i.e. PH is dead)
    state <- matrix(rep(-1, n_paths*max_years), nrow=n_paths,
                    ncol=max_years, byrow=TRUE)
                    
    for (i in seq(1, n_paths)) {
        # Set all entries in i'th row prior to death as 0 (i.e. PH is alive)
        death_yr <- ages_at_death[i]
        state[i, 1:death_yr] <- rep(0, death_yr)
    }
    return(state)
}

# Construct state matrix
ages_at_death = seq(1, 100)
state <- construct_state_matrix(ages_at_death, max_years = 100)

# Create list of relevant economic variables
sdf <- matrix(rep(1.06, N_PATHS*MAX_YEARS),
              nrow=100,
              ncol=100,
              byrow=TRUE)
econ_var <- list(sdf=sdf)

la <- create_policy_LA(1, defer = 0, increase = 0)
cf_la <- simulate_cf(la, n = 100, state = state, econ_var = econ_var)
val_la <- value_policy(la, cf_la)
```

### Example 2: Life annuity using life tables from 'lifecontingencies'

```r
construct_state_matrix <- function(ages_at_death, max_years) {
    n_paths <- length(ages_at_death)

    # Create matrix with all entries = -1 (i.e. PH is dead)
    state <- matrix(rep(-1, n_paths*max_years), nrow=n_paths,
                    ncol=max_years, byrow=TRUE)

    for (i in seq(1, n_paths)) {
        # Set all entries in i'th row prior to death as 0 (i.e. PH is alive)
        death_yr <- ages_at_death[i]
        state[i, 1:death_yr] <- rep(0, death_yr)
    }
    return(state)
}

get_ages_at_death <- function(surv_probs, max_years, n_paths) {
    ages_at_death <- c()
    for (i in seq(1, n_paths)) {
        p <- stats::runif(length(surv_probs))
        lv <- min(which((p > surv_probs) == TRUE))
        ages_at_death <- c(ages_at_death, lv)
    }
    return(ages_at_death)
}

get_px_from_lx <- function(lx) {
    px <- lx
    px[1] <- 1
    for (i in seq(2, length(lx) - 1)) {
        px[i] <- 1 - (lx[i] - lx[i+1])/lx[i]
    }
    px[length(lx)] <- 0
    return(px)
}

library(lifecontingencies); data(soaLt);
initial_age <- 65

soa08Act <- with(soaLt, new("actuarialtable",interest=0.06,
                            x=x,lx=Ix,name="SOA2008"))
lx08 <- soa08Act@lx[initial_age + 1:length(soa08Act@lx)]

# Extract survival probabilities from soa0xAct
surv <- extract_px_from_lx(lx08)

# Simulate ages at death based on survival probabilities
death_ages <- get_ages_at_death(surv, 100, 100)

# Construct state matrix
state <- construct_state_matrix(death_ages, max_years = 100)

la <- create_policy_LA(1, defer = 0, increase = 0)
cf_la <- simulate_cf(la, n = 100, state = state)
val_la <- value_policy(la, cf_la)
```


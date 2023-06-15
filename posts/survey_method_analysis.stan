// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; //Number of samples
  vector[N] cpue_census; //y variable i.e. cpue 
  vector[N] cpue_roving; 
  vector[2] mean_priors;
}

transformed data {
   vector[N] difference = cpue_census - cpue_roving;
}

parameters {
  real mu_census;
  real<lower=0> sigma_census;
  
  real mu_roving;
  real<lower=0> sigma_roving;
  
  real mu_diff;
  real<lower=0> sigma_diff;
}

model {
  //Priors
  mu_census ~ normal(mean_priors[1], mean_priors[2]);
  mu_roving ~ normal(mean_priors[1], mean_priors[2]);
  mu_diff ~ normal(mean_priors[1], mean_priors[2]);
  
  sigma_census ~ exponential(1);
  sigma_roving ~ exponential(1);
  sigma_diff ~ exponential(1);
  
  cpue_census ~ normal(mu_census, sigma_census);
  cpue_roving ~ normal(mu_roving, sigma_roving);
  difference ~ normal(mu_diff, sigma_diff);
}


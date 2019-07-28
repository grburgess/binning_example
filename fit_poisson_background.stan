functions {

  vector integral_counts(int N, vector a, vector b, real K, real p, real x0) {

    vector[N] out;

    for (n in 1:N) {

      out[n] = b[n]^(p+1) - a[n]^(p+1);

    }

    return (K * (1./x0)^p  /(p+1) ) * out;
      
    
    


  }


}


data {

  int N;
  vector[N] a;
  vector[N] b;
  int observation[N];
  int background[N];
  real<lower=0> x0;

  
}

transformed data {}


parameters {

  real log_K;
  real p;

  real log_K_bkg;
  real p_bkg;
 

}

transformed parameters {

  real<lower=0> K = exp(log_K);
  real<lower=0> K_bkg = exp(log_K_bkg);


  
}


model {

  vector[N] expected_counts;
  vector[N] expected_bkg_counts;

  
  //  log_K ~ normal(1,1);
  // p ~ normal(-2, 1);


  expected_counts = integral_counts(N, a, b, K, p, x0);
  expected_bkg_counts = integral_counts(N, a, b, K_bkg, p_bkg, x0);


  observation ~ poisson(expected_counts + expected_bkg_counts);
  background ~ poisson(expected_bkg_counts);
  
  

}


generated quantities {

  /* int output[N]; */
  /* vector[N] rate; */
  

  /* rate = integral_counts(N, a, b, K, p, x0); */
  
  /* for (n in 1:N) { */
    
  /*   output[n] = poisson_rng(rate[n]); */


  /* } */



}

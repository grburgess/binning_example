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
  int counts[N];
  real<lower=0> x0;

  
}

transformed data {}


parameters {

  real log_K;
  real p;
  

}

transformed parameters {

  real<lower=0> K = exp(log_K);


  
}


model {

  vector[N] expected_counts;

  
  //  log_K ~ normal(1,1);
  // p ~ normal(-2, 1);


  expected_counts = integral_counts(N, a, b, K, p, x0);


  counts ~ poisson(expected_counts);

  
  

}


generated quantities {

  /* int output[N]; */
  /* vector[N] rate; */
  

  /* rate = integral_counts(N, a, b, K, p, x0); */
  
  /* for (n in 1:N) { */
    
  /*   output[n] = poisson_rng(rate[n]); */


  /* } */



}

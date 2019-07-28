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
  real<lower=0> K;
  real p;
  real<lower=0> x0;


  real<lower=0> K_bkg;
  real p_bkg;


}

transformed data {}

generated quantities {

  int observation[N];
  int background[N];
  vector[N] source_rate;
  vector[N] background_rate;
  

  source_rate = integral_counts(N, a, b, K, p, x0);
  background_rate = integral_counts(N, a, b, K_bkg, p_bkg, x0);
  
  for (n in 1:N) {
    
    observation[n] = poisson_rng(source_rate[n] + background_rate[n]);
    background[n] = poisson_rng( background_rate[n]);


  }



}

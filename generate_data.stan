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


}

transformed data {}

generated quantities {

  int output[N];
  vector[N] rate;
  

  rate = integral_counts(N, a, b, K, p, x0);
  
  for (n in 1:N) {
    
    output[n] = poisson_rng(rate[n]);


  }



}

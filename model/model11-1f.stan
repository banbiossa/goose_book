functions{
        real binomial_bernoulli_lpmf(int y, real q){
                return log_sum_exp(
                        log(0.5) + bernoulli_lpmf(y|q),
                        log(0.5) + bernoulli_lpmf(y|1)
                );
        }
}

data {
  int N;
  int<lower=0, upper=1> Y[N];
}

parameters {
  real<lower=0, upper=1> q;
}

model {
  for (n in 1:N){
    Y[n] ~ binomial_bernoulli(q);
  }
}
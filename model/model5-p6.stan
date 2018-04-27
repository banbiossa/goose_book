
data {
        int<lower=0> N;
        real<lower=0> x[N];
        int<lower=0, upper=1> f[N]; //furtilizer
        int<lower=0> Y[N];
}

parameters {
        real b[3];
}

transformed parameters {
        real log_lambda[N];
        for(n in 1:N)
                log_lambda[n] = b[1] + b[2]*x[n] + b[3]*f[n];
}

model {
        for(n in 1:N)
                Y[n] ~ poisson_log(log_lambda[n]);
}



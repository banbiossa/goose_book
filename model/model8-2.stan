
data{
        int N;
        int K;
        real X[N];
        real Y[N];
        int<lower=1, upper=K> KID[N];
}


parameters{
        real a[K];
        real b[K];
        real<lower=0> s_Y;
}


model{
        for(n in 1:N)
                Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y);
}

generated quantities{
        real Y_pred[N];
        for(n in 1:N)
                Y_pred[n] = normal_rng(a[KID[n]] + b[KID[n]] *X[n], s_Y);
}
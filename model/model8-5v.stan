
data{
        int N;
        int G;
        int K;
        vector[N] X;
        vector[N] Y;
        int<lower=1, upper=K> KID[N];
        int<lower=1, upper=G> K2G[K];
}


parameters{
        real a0;
        real b0;
        vector[G] a1;
        vector[G] b1;
        vector[K] a;
        vector[K] b;
        real<lower=0> s_ag;
        real<lower=0> s_bg;
        real<lower=0> s_a;
        real<lower=0> s_b;
        real<lower=0> s_Y;
}

transformed parameters{
        vector[K] a_base;
        vector[K] b_base;
        vector[N] y_base;
        for(k in 1:K){
                a_base[k] = a1[K2G[k]];
                b_base[k] = b1[K2G[k]];
        }
        for(n in 1:N)
                y_base[n] = a[KID[n]] + b[KID[n]]*X[n];
}

model{
        a1 ~ normal(a0, s_ag);
        b1 ~ normal(b0, s_bg);
        
        a ~ normal(a_base, s_a);
        b ~ normal(b_base, s_b);
        
        Y ~ normal(y_base, s_Y);
}




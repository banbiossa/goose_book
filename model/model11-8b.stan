functions{
        real CateCate_lpmf(int Y, int K, vector theta, vector[] phi, int n){
                vector[K] lp;
                for(k in 1:K){
                        lp[k] = (log(theta[k]) + log(phi[k,Y])) * n;
                }
                return log_sum_exp(lp);
        }
}

data{
        int<lower=1> E;
        int<lower=1> N;
        int<lower=1> I;
        int<lower=1> K;
        int<lower=1, upper=N> PersonID[E];
        int<lower=1, upper=I> ItemID[E];
        int<lower=1> n[E];
        vector<lower=0>[I] Alpha;
}

parameters{
        simplex[K] theta[N];
        simplex[I] phi[K];
}

model{
        for(k in 1:K){
                phi[k] ~ dirichlet(Alpha);
        }
        for(e in 1:E){
                ItemID[e] ~ CateCate(K, theta[PersonID[e]], phi, n[e]);
        }
}


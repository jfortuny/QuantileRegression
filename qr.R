# From http://data.library.virginia.edu/getting-started-with-quantile-regression/

# generate data with non-constant variance
x <- seq(0,100,length.out = 100)        # independent variable
sig <- 0.1 + 0.05*x                     # non-constant variance
b_0 <- 6                                # true intercept
b_1 <- 0.1                              # true slope

set.seed(1)                             # make the next line reproducible
e <- rnorm(100,mean = 0, sd = sig)      # normal random error with non-constant variance
y <- b_0 + b_1*x + e                    # dependent variable
dat <- data.frame(x,y)

library(ggplot2)
ggplot(dat, aes(x,y)) + geom_point()
ggplot(dat, aes(x,y)) + geom_point() + geom_smooth(method="lm")

ggplot(dat, aes(x,y)) + geom_point() + geom_quantile()

library(quantreg)
qr1 <- rq(y ~ x, data = dat, tau = 0.9)
summary(qr1)
str(qr1)
coef(qr1)

ggplot(dat, aes(x,y)) + geom_point() +
  geom_abline(intercept=coef(qr1)[1], slope=coef(qr1)[2])

# Multiple quantiles
qs <- 1:9/10
qr2 <- rq(y ~ x, data = dat, tau = qs)
coef(qr2)

ggplot(dat, aes(x,y)) + geom_point() + geom_quantile(quantiles = qs)
plot(summary(qr2), parm="x")

P12 <- dbinom(1, 3, 1-(1-0.01))
P22 <- dbinom(0, 2, 1-(1-0.01)^2)
P24 <- dbinom(2, 2, 1-(1-0.01)^2)

total <- P12 * (P22^3) * P24
print(P12)
print(P22)
print(P24)
print(round(total, 6))

%% Ensaio vazio
R1 = 16.5 % medido
V1nl = 226.6/sqrt(3) % 226.6 medido
I1nl = 1.34 % medido
Pn1 = V1nl * I1nl
W1 = 105; W2 = 194; % medido
nph = 3 % medido
Pnl = W1 + W2
Prot = Pnl - nph*R1*(I1nl)^2
Snl = 3 * V1nl * I1nl
Qnl = sqrt(Snl^2 - Pnl^2)
Xnl = Qnl/(nph*(I1nl)^2)

%% Rotor bloqueado
V1bl = 55.3/sqrt(3)
I1bl = 1.42
Pbl = 73 + 57
fr = 60
fbl = 60
Sbl = nph*V1bl*I1bl
Qbl = sqrt(Sbl^2 - Pbl^2)
Xbl = (fr/fbl)*(Qbl/(I1bl^2))
Rbl = Pbl/(nph*(I1bl^2))
% X1 = X2 = Xx
Xx = sym('Xx')
raizes = eval(solve(Xx - (Xbl-Xx)*[(Xnl-Xx)/(Xnl-Xbl)]))
X1 = raizes(2) % precisa ser menor que Xnl
X2 = X1
Xm = Xnl - X1
R2 = (Rbl- R1)*((X2+Xm)/Xm)^2
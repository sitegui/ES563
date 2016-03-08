clear all;

f = 60;
polos = 2;
Rs = 0.3;
Rr = 0.2;
Lm = 0.035;
Lls = 0.003;
Llr = 0.003;
Jl = 0.02;
dl = 0.001;
U = 220;

omega_r = linspace(0, 377, 100);
omega_1 = 2*pi*(120*f/polos)/60;
s = (omega_1 - omega_r)/omega_1;

R = Rr*(1-s) ./ s;
Zls = i*2*pi*f*Lls;
Zm = i*2*pi*f*Lm;
Zlr = i*2*pi*f*Llr;

A = Zlr + Rr + R;
B = Rs + Zls;
C = (A * Zm)/(A + Zm);
Zeq = B+C;
I_total = U/Zeq;
UB = B*I_total;
UA = U - UB;
I2 = UA ./ A;
UR = R .* I2;

P_motor = 3 .* real(UR .* conj(I2));
torque = P_motor ./ omega_r;
plot(omega_r, torque);
ylim([0 150]);
xlabel('Velocidade (rad/s)');
ylabel('Torque (Nm)');
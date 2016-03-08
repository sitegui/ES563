%% Curvas em função do torque
clear all;
V0 = 15;
Vb = 5.23;
Ra = 0.4845;
I0 = 1.5;
omega0 = 415.7;

Rh = (V0 - Vb)/I0 - Ra;
Ke = Rh * I0 / omega0;
Km = Ke;
Tmax = Km * (V0 - Vb)/Ra;
T = linspace(0, Tmax, 100);
omega = ((V0 - Vb) .* Rh - (Ra .* Rh .* T) ./ Km) ./ (Ke .* (Ra + Rh));
E = Ke .* omega;
Ia = (V0 - Vb - E) ./ Ra;
Pout = T .* omega;
Pin = V0 .* Ia;
n = Pout ./ Pin;

subplot(2, 2, 1);
plot(T*1e3, [Ia; Pout; 100*n]);
xlim([0, Tmax*1e3]);
yl = ylim();
ylim([0, yl(2)]);
xlabel('Torque (mN \cdot M)');
legend('Ia (A)', 'Pout (W)', '\eta (%)');

subplot(2, 2, 2);
plot(T*1e3, [Pin; omega]);
xlim([0, Tmax*1e3]);
yl = ylim();
ylim([0, yl(2)]);
xlabel('Torque (mN \cdot M)');
legend('Pin (W)', '\omega');

%% Curvas em função da velocidade
omega = linspace(0, omega0, 100);
Ke = Rh * I0 / omega0;
Km = Ke;
E = Ke .* omega;
Ia = (V0 - Vb - E)./Ra;
Pout = E .* Ia - (E .* E) ./ Rh;
Pin = V0 .* Ia;
n = Pout ./ Pin;
T = (Ia - E ./ Rh) .* Km;

subplot(2, 2, 3);
plot(omega, [Ia; Pout; 100*n]);
xlim([0, omega0]);
yl = ylim();
ylim([0, yl(2)]);
xlabel('Rotação (rad/s)');
legend('Ia (A)', 'Pout (W)', '\eta (%)');

subplot(2, 2, 4);
plot(omega, [Pin; 1e3*T]);
xlim([0, omega0]);
yl = ylim();
ylim([0, yl(2)]);
xlabel('Rotação (rad/s)');
legend('Pin (W)', 'T');
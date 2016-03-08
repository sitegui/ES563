%% T em função da velocidade (Questão 1.3)
clc;clear all; close all;
% Tabela de parâmetros usados neste plot
Ra = 0.4845;
Rh = 0.72;
Req=Ra+Rh;
I2 = 1.5^2;
Rth = 3;
Thal = 2.9;
Temp_Amb = 26;

% Variação do tempo
t=0:0.1:30;

% Equações
Temp_motor = Rth*Req*I2*(1-exp(-t./Thal)) + Temp_Amb;


% Plot
figure;
plot(Temp_motor);
title('Tempera Motor x Tempo');
xlabel('t');
ylabel('T(°C)');
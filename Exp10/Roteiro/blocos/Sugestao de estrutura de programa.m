clear all;


rs=0.8;
rrs=1;
Lms=0.1;
Lls=0.01;
Llr=0.01;
Jl=0.002;
dl=0.0001;
Bm = dl;
J=Jl;
wf=377;
thetar=0.0;
P=2;
phi1=thetar;
phi2=thetar+2*pi/3;
phi3=thetar-2*pi/3;
alpha=(Lms+Lls);
beta=(Llr+Lms);

f = 60;
polos = 2;
U = 220;

%Pré-Roteiro:
%omega_1 = 2*pi*(120*f/polos)/60;
%s = (omega_1 - omega_r)/omega_1;
%R = rrs*(1-s)/s;
%Zls = i*2*pi*f*Lls;
%Zm = i*2*pi*f*Lms;
%Zlr = i*2*pi*f*Llr;
%A = Zlr + rrs + R;
%B = rs + Zls;
%C = (A * Zm)/(A + Zm);
%Zeq = B+C;
%I_total = U/Zeq;
%UB = B*I_total;
%UA = U - UB;
%I2 = UA ./ A;
%UR = R .* I2;
%P_motor = 3 * real(UR * conj(I2));
%torque(TL) = P_motor / omega_r;

%Equações Slide Roteiro:
%F1A=Lms/2*(DiMsB+DiMsC);
%F1B=Lms/2*(DiMsA+DiMsC);
%F1C=Lms/2*(DiMsA+DiMsB);

%F2A=-Lms*(DiMrA*cos(phi1)+DiMrB*cos(phi2)+DiMrC*cos(phi3));
%F2B=-Lms*(DiMrA*cos(phi3)+DiMrB*cos(phi1)+DiMrC*cos(phi2));
%F2C=-Lms*(DiMrA*cos(phi2)+DiMrB*cos(phi3)+DiMrC*cos(phi1));;

%Disa=(1/alpha)*(-rs*iMsA+F1A+F2A+Vas);
%Disb=(1/alpha)*(-rs*iMsB+F1B+F2B+Vbs);
%Disc=(1/alpha)*(-rs*iMsC+F1C+F2C+Vcs);


%F1Ar=Lms/2*(DiMrB+DiMrC);
%F1Br=Lms/2*(DiMrA+DiMrC);
%F1Cr=Lms/2*(DiMrA+DiMrB);

%F2Ar=-Lms*(DiMsA*cos(phi1)+DiMsB*cos(phi3)+DiMsC*cos(phi2));
%F2Br=-Lms*(DiMsA*cos(phi2)+DiMsB*cos(phi1)+DiMsC*cos(phi3));
%F2Cr=-Lms*(DiMsA*cos(phi3)+DiMsB*cos(phi2)+DiMsC*cos(phi1));

%pag. 5 do pré-roteiro, Vabcr=Uabcr=0, logo, U'abcr=0
%Dira=(1/beta)*(-rrs*iMrA+F1Ar+F2Ar);
%Dirb=(1/beta)*(-rrs*iMrB+F1Br+F2Br);
%Dirc=(1/beta)*(-rrs*iMrC+F1Cr+F2Cr);

%iMxy = i'xy. Assumindo Nr = Ns, iMxy = i'xy = ixy


%F3A=iMsA*(iMrA-0.5*iMrB-0.5*iMrC);
%F3B=iMsB*(iMrB-0.5*iMrA-0.5*iMrC);
%F3C=iMsC*(iMrC-0.5*iMrB-0.5*iMrA);

%F4A=iMsA*(iMrB-iMrC);
%F4B=iMsB*(iMrC-iMrA);
%F4C=iMsC*(iMrA-iMrB);

%Dwr=(-P^2*Lms)/(4*Jl)*[(F3A+F3B+F3C)*sin(thetar) + ...
%(F4A+F4B+F4C)*(sqrt(3)/2)*cos(thetar) + ...
%-(Bm/Jl)*wr-(P/(2*Jl))*Tl

%Bm = dl??

%Dthetar=wr;



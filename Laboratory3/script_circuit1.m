clear
R1=1e3;R2=1e3;C1=1e-6;R3=1e3;R4=1e3;C2=1e-6;
w=600; % the frequency in rad/sec. for the input signal 
T=2*pi/w; Te=T/50; % sampling period
sim('circuit1');
%% reading data from simulink
t=data.time; % simulation base
u=data.signals(1,2).values; % input signal
y=data.signals(1,1).values; % output signal
plot(t,u,'r',t,y,'b'); 
title(['Raspunsul circuitului la semnal u(t)=sin(',num2str(w),'t)'])
legend('intrare','iesire');
xlabel('Timp (sec.)')
shg;grid
%%
H = tf(-R2/R1,[C1*R2 1])*tf(-R2/R1,[C1*R2 1]);
nyquist(H)



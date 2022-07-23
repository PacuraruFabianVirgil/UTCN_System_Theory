%% Lab 2
Im = -0.09, Re = 0.98;
t=linspace(0,10);
y = @(t) (sin(2*t))
yss = @(t) (sqrt(Im^2+Re^2)*sin(2*t+atan(Im/Re)))
hold
plot(t,y(t),'r--')
plot(t,yss(t))
legend('input signal','output signal')
%% Establish the bandwidth
H = tf([1 0],[0.3 1 1]);
nyquist(H);
viscircles([0 0],0.707,'LineStyle','--')
xlim([-1 1])
%% New function
H = tf(1,[0.3 1 1]);
nyquist(H);
viscircles([0 0],0.707,'LineStyle','--')
xlim([-1 1])
Im = -0.67, Re = 0.24;
t=linspace(0,10);
y = @(t) (sin(2*t))
yss = @(t) (sqrt(Im^2+Re^2)*sin(2*t+atan(Im/Re)));
figure
hold
plot(t,y(t),'r--')
plot(t,yss(t))
legend('input signal','output signal')
%% tema celelalte 2 probleme (se verifica)
k = 2;
Hd = zpk([],[-2,-300],600,'IOdelay',0.2);
figure; nyquist(Hd); shg;
Ho = feedback(k*Hd,1);
figure; step(Ho); shg;
re = -0.501;
im = -0.265;
Mp = sqrt(re^2+im^2)/sqrt((1+re)^2+im^2);
df = min(abs(roots([-4*Mp^2 0 4*Mp^2 0 -1])));
sigma = exp(-df*pi/sqrt(1-df^2));
stepinfo(Ho)
figure; bode(Ho)
t = linspace(0,2,1e4);
u = (square(288*2*t,50)+1)/2;
figure; lsim(Ho,u,t);
clear;clc
% approximations for magnitude
wma=[0.1 107 200 1e3];ma=[6 6 0 -13.5];
% approximations for phase
wfa=[0.1 10.7 107 1070 1e4];fa=[0 -5 -45 -85 -90];
% plotting the approximations
subplot(211);semilogx(wma,ma,'ro-');grid
title('Magnitude characteristics');
xlabel('\omega (rad/sec)');ylabel('|H(j\omega)|^dB');
subplot(212);semilogx(wfa,fa,'ro-');grid;shg;
title('Phase characteristics');ylabel('\angleH(j\omega) (degres)');
%%
% comparison with Bode in Matlab
h=tf(1500,[7 750]);w=logspace(-1,4,1e4);
[m,f]=bode(h, w);
mv(1:1e4,1)=m(:,:,:);fv(1:1e4,1)=f(:,:,:);
subplot(211);semilogx(w,20*log10(mv),'b',wma,ma,'ro-');grid
title('Magnitude characteristics');
xlabel('\omega (rad/sec)');ylabel('|H(j\omega)|^dB');
subplot(212);semilogx(w,fv,'b',wfa,fa,'ro-');grid;shg;
title('Phase characteristics');
xlabel('\omega (rad/sec)'); ylabel('\angleH(j\omega) (degres)');
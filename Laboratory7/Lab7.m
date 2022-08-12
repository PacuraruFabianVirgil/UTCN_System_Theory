%% Laboratory 7

% example c) from lab
Hdes = zpk([-9],[0 -5],[1],'iodelay', 0.1)
bode(Hdes); grid; shg; hold
%%
% we read the cut off frequency from Bode
wc = 1.74; semilogx(wc,0,'ro'); shg;
text(wc,10,'\omega_c=1.73','Color','r')
%%
semilogx(wc,-180,'r+'); shg;
gk = 180-108; % phase(Hdes(jwc))=-108
semilogx([wc wc],[-180 -180+gk],'r-'); shg;
semilogx(wc,-180+gk,'r^'); shg;
text(wc+0.1,-180+gk/2,'\gamma_k=72^o')
semilogx([0.1 100],[-180 -180],'m-.'); shg;
wpi=13.4; semilogx(wpi,-180,'mo'); shg;
text(wpi+2,-175,'\omega_{-\pi}=13.4','Color','r')
%% 
semilogx(wpi,0,'m+'); shg;
mk = -21.5;
semilogx([wpi wpi],[0 mk],'m-'); shg;
semilogx(wpi,mk,'rv'); shg;
text(wpi+0.1,mk/2,'m_k^{dB}=-21.5dB')
%%
kc = 10^(21.5/20);
bode(kc*Hdes);
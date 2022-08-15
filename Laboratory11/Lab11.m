Ts = 5e-2;
Hc = tf(1,[1 0]);
Hcz = c2d(Hc,Ts,'tustin');
Hp = zpk([],[-20 -40],2400);
Hpz = c2d(Hp,Ts,'zoh');
Hdesz = Hcz*Hpz;
subplot(1,2,1); rlocus(Hdesz);
Hdes = Hc*Hp;
subplot(1,2,2); rlocus(Hdes);

%%
k = [0.5 1.03 8 9.3];
n = ["OVERDAMPED", "CRITICALLY DAMPED", "UNDERDAMPED", "UNDAMPED"];
figure;
for i = 1:length(k)
    subplot(4,1,i); 
    hold on;
    step(feedback(k(i)*Hdesz,1));
    step(feedback(k(i)*Hdes,1));
    hold off;
    title(n(i));
end
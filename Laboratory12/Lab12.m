%% The Response of Discrete Time Systems
% Verify the tf
H = zpk([],[-2,-1],3); T = 0.1;
b2 = 3*T^2; a2 = (1+2*T)*(1+T);
a1 = -(3*T+2); a0 = 1;
Hz = tf([b2,0,0],[a2,a1,a0],T);
u = ones(1,80);
y = zeros(1,80);
% recursive part
y(1) = 1/a2*b2*u(1);
y(2) = 1/a2*(b2*u(2)-a1*y(1));
for k = 3:80
    y(k) = 1/a2*(b2*u(k)-a1*y(k-1)-a0*y(k-2));
end
t = linspace(0,8,80);
hold on; step(H,Hz,8); stem(t,y,'y'); hold off;
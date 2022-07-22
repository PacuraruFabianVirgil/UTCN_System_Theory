w = 900;
R1 = 1e3; R2 = 4.7e3; C1 = 1e-6;
H = tf(-R2/R1,[R2*C1 1]);
T = 2*pi/w;
t = linspace(0,5*T,1000);
u = sin(w*t);
y = lsim(H,u,t);
counter1 = 0;
counter2 = 0;
v = zeros(1,5);
for i = 2:length(y)
    if y(i-1)<0 && y(i)>=0
        counter1=counter1+1;
        if counter1==4
            ty = t(i);
        end
    end
    if u(i-1)<0 && u(i)>=0
        counter2=counter2+1;
        if counter2==4
            tu = t(i);
        end
    end
end
phi_sec = tu-ty;
phi_rad = phi_sec*w;
clc
fprintf('For a frequency of %d we get a phase shift of %f rad.\n',w,phi_rad);
hold on
plot(t,u)
plot(t,y)
hold off
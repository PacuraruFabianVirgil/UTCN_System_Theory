%% Laboratory 1

% Simulate the step response of the circuit with R1=1kohm, R2=4.7kohm,
% C1=1microF
R1 = 1e3; R2 = 4.7e3; C1 = 1e-6;
H = tf(-R2/R1,[R2*C1 1]);
step(H)

% Simulate u(t)=sin(900*t)
w = 900; Tu = 2*pi/w; T=4*R2*C1;
t = 0:Tu/100:7*Tu;
u = sin(w*t);
y = lsim(H,u,t);
figure
hold on
plot(t,u)
plot(t,y)
hold off
tu = 0.0384;ty = 0.0364;
phi_sec = tu-ty;

% Tu----2pi
% phi_sec----phi_rad
phi_rad = phi_sec*w;
figure
y_ss = 1.08*sin(w*t+phi_rad);
plot(t,y_ss,'*r')

w = 970; Tu = 2*pi/w; T=4*R2*C1;
t = 0:Tu/100:7*Tu;
u = sin(w*t);
lsim(H,u,t);hold;plot(t,0.707*ones(1,length(t)),'r');hold
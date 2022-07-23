H1 = tf(2,[1 1 1]);
H2 = tf([1 0 4],[0.3 1 1]);
H3 = tf([1 0 0],[0.3 1 1]);
H4 = tf([1 0],[0.3 1 1]);
hold on
nyquist(H1)
nyquist(H2)
nyquist(H3)
nyquist(H4)
viscircles([0 0],0.707,'LineStyle','--')
hold off
legend('First function','Second function','Third function','Fourth function')
clc
fprintf('The first transfer function acts as a low pass filter with the bandwith of (0, 1.8).\n')
fprintf('The second transfer function acts as a band reject filter with the bandwith of (0, 1.7) U (2.4, Inf).\n')
fprintf('The third transfer function acts as a high pass filter with the bandwith of (0.9, Inf).\n')
fprintf('The fourth transfer function acts as a band pass filter with the bandwith of (0.8, 4.1).\n')
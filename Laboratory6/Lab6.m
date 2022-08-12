tm = 0; k = 1;
Hdes = tf(k*[1 5], [1 9 0], 'iodelay', tm);
%nyquist(Hdes)

k = 10; tm = 0.24;
w = logspace(-1,3,1e4);
Hdes = tf(k*[1 5], [1 9 0], 'iodelay', tm);
nyquist(Hdes,w)

k = [0.5 1/0.93 2];
tm = exp(1);
for i=1:length(k)
    Hdes = tf(k(i)*[1 5], [1 9 0], 'iodelay', tm);
    Ho = feedback(Hdes,1);
    %subplot(3,1,i); step(Ho);
end
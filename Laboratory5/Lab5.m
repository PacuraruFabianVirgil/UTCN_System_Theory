clc
H1 = tf(30*[1 5 0],[2 27 36]);
H2 = tf(600*[4 100],[1 1000 300*700]);
H3 = tf(2,[1 50 2500]);
H4 = tf(0.1*[1 20 400],[1 1 400]);
H5 = tf(0.25,[25 1 1 0]);
H = H1;
[num,den] = tfdata(H);
initialSlope = 0;
i = length(den{1});
while(den{1}(i)==0)
    initialSlope = initialSlope - 20;
    den{1} = den{1}(1:(end-1));
    i = i-1;
end
i = length(num{1});
while(num{1}(i)==0)
    initialSlope = initialSlope + 20;
    num{1} = num{1}(1:(end-1));
    i = i-1;
end
k = num{1}(end)/den{1}(end);
rootsOfNum = roots(num{1});
rootsOfDen = roots(den{1});
totalRoots = zeros(1,length(rootsOfDen)+length(rootsOfNum));
slopes = zeros(1,length(rootsOfDen)+length(rootsOfNum));
for i=1:length(rootsOfDen)
    totalRoots(i) = (-1)*rootsOfDen(i);
    slopes(i) = -20;
end
for i=1:length(rootsOfNum)
    totalRoots(length(rootsOfDen)+i) = (-1)*rootsOfNum(i);
    slopes(length(rootsOfDen)+i) = 20;
end
totalRoots = sqrt(real(totalRoots).^2+imag(totalRoots).^2);
for i=1:length(totalRoots)
    for j=(i+1):length(totalRoots)
        if(totalRoots(i)>totalRoots(j))
            aux = totalRoots(i);
            totalRoots(i) = totalRoots(j);
            totalRoots(j) = aux;
            aux = slopes(i);
            slopes(i) = slopes(j);
            slopes(j) = aux;
        end
    end
end
i = 0;
flag = 1;
while(flag)
    if(10^i>=totalRoots(end))
        flag=0;
        bigPower = i+1;
    end
    i = i+1;
end
i = 0;
flag = 1;
while(flag)
    if(10^i<=totalRoots(1))
        flag=0;
        smallPower = i-1;
    end
    i = i-1;
end
wma = zeros(1,length(totalRoots)+2);
wma(1) = 10^smallPower;
wma(2:(end-1)) = totalRoots;
wma(end) = 10^bigPower;
ma = zeros(1,length(wma));
ma(1) = 20*log10(k) + initialSlope*smallPower;
sumOfSlopes = initialSlope;
for i=2:length(ma)
    ma(i) = sumOfSlopes*log10(wma(i)/wma(i-1))+ma(i-1);
    if(i~=length(ma))
        sumOfSlopes = sumOfSlopes + slopes(i-1);
    end
end

wfa = zeros(1,(length(wma)-2)*3+2);
wfa(1) = wma(1)/10;
for i = 0:2
    for j=2:(length(wma)-1)
        wfa(i*length(slopes)+j) = wma(j)*10^(i-1);
    end
end
wfa(end) = wma(end)*10;
coeffForEveryW = ones(length(slopes),length(wfa));
coeffForEveryW(:,1) = 0;
coeffForEveryW(:,end) = 90;
for i = 1:length(slopes)
    for j = 0:2
        coeffForEveryW(i,i+1+j*length(slopes)) = coeffForEveryW(i,i+1+j*length(slopes))*(40*j+5);
    end
end
for i = 1:length(slopes)
    for j = 1:length(wfa)
        if(coeffForEveryW(i,j)==1)
            if(j<i+1)
                coeffForEveryW(i,j) = coeffForEveryW(i,j)*5*log10(wfa(j)/wfa(1))/log10(wfa(i+1)/wfa(1));
            elseif(j<i+1+length(slopes))
                coeffForEveryW(i,j) = coeffForEveryW(i,j)*(5+40*log10(wfa(j)/wfa(i+1))/log10(wfa(i+1+length(slopes))/wfa(i+1)));
            elseif(j<i+1+2*length(slopes))
                coeffForEveryW(i,j) = coeffForEveryW(i,j)*(45+40*log10(wfa(j)/wfa(i+1+length(slopes)))/log10(wfa(i+1+2*length(slopes))/wfa(i+1+length(slopes))));
            else
                coeffForEveryW(i,j) = coeffForEveryW(i,j)*(85+5*log10(wfa(j)/wfa(i+1+2*length(slopes)))/log10(wfa(end)/wfa(i+1+2*length(slopes))));
            end
        end
    end
end
for i = 1:length(slopes)
    if (slopes(i)==-20)
        coeffForEveryW(i,:) = coeffForEveryW(i,:)*(-1);
    end
end
if(initialSlope~=0)
    coeffForEveryW(end+1,:) = 90*initialSlope/20;
end
fa = zeros(1,length(wfa));
for i=1:length(coeffForEveryW(:,1))
    fa = fa + coeffForEveryW(i,:);
end


subplot(211);semilogx(wma,ma,'ro-');grid
title('Magnitude characteristics');
xlabel('\omega (rad/sec)');ylabel('|H(j\omega)|^dB');
subplot(212);semilogx(wfa,fa,'ro-');grid;shg;
title('Phase characteristics');ylabel('\angleH(j\omega) (degres)');
% comparison with Bode in Matlab
h=tf([20 2],[6 5 1]);w=logspace(smallPower-1,bigPower+1,1e4);
bode(H,w);
[m,f]=bode(H, w);
mv(1:1e4,1)=m(:,:,:);fv(1:1e4,1)=f(:,:,:);
subplot(211);semilogx(w,20*log10(mv),'b',wma,ma,'ro-');grid
title('Magnitude characteristics');
xlabel('\omega (rad/sec)');ylabel('|H(j\omega)|^dB');
subplot(212);semilogx(w,fv,'b',wfa,fa,'ro-');grid;shg;
title('Phase characteristics');
xlabel('\omega (rad/sec)'); ylabel('\angleH(j\omega) (degres)');
function power_audio = check_power_or_audio(x,fs)
Nfft = 1024;
x=x(1:5*fs);
[Pxx,F] = pwelch(x,[],[],Nfft,fs);
sum1 = 0;
fc=50;
fb=.5;
SNR=zeros(1,2);
for i=1:4
    f0=i*fc;
    l1 = find(F > (f0+fb));
    l1 = l1(1);
    l2 = find(F < (f0-fb));
    l2 = l2(end);
    sum1 = sum1+sum(Pxx(l2:l1));
end
sum2 = sum(Pxx) - sum1;
SNR(1) = sum1/sum2;
fc=60;
sum1 = 0;
for i=1:4
    f0=i*fc;
    l1 = find(F > (f0+fb));
    l1 = l1(1);
    l2 = find(F < (f0-fb));
    l2 = l2(end);
    sum1 = sum1+sum(Pxx(l2:l1));
end
sum2 = sum(Pxx) - sum1;
SNR(2) = sum1/sum2;
power_audio = 0;
if SNR(1)>=2 || SNR(2)>=2
    power_audio = 1;
end
end
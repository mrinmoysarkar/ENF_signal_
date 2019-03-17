function a = enf_feature_60p(lf,hf)
warning('all','off');
%50p
%a(1)=mean(lf);%lF
%s=0;
%for i=1:length(lf)-1
%    s=s+abs(lf(i+1)-lf(i));
%end
%a(2)=s;%lF
%a(3)=max(lf)/rms(lf);%lF
%a(4)=median(lf);
%a(5) = iqr(lf);

% 50a
% a(1)=sum(0.5*abs(hf))/length(hf);
% a(2)=log(var(xcorr(hf)));
% [G,H]=arburg(hf,4);
% a(3)=G(2);

%60a
%  a(1)=log(var(xcorr(lf)));%LF
%  a(2)=iqr(lf);%LF
%  a(3)=median(hf);%HF
%  a(4)=sum(psd(lf));%LF

%60p
s=0;
for i=1:length(hf)-1
    s=s+abs(hf(i+1)-hf(i));
end
a(1)=s;%HF
a(2)=log(var(xcorr(hf)));%HF
[G,H]=arburg(hf,4);
a(3)=log(H);%HF



%a(5)=log(var(xcorr(lf+hf)));%HF
%a(5)=log(min(var(lf+hf)));%HF
%a(4)=log(mad(hf));%HF



% a(1)=mean(x);
% a(2)=log(var(x));
% a(3)=log(range(x));
% % wavlet
% [c,d]=wavedec(x,9,'db7');
% indx1=1;
% indx2 = 0;
% for i=1:length(d)-1
%     indx1=indx2+1;
%     indx2=indx2+d(i);
%     e=c(indx1:indx2);
%     a(3+i)=log(var(e));
% end
% 
% % e=c(indx1:indx2);
% % a(4)=log(var(e)); % approximation
% % indx1=indx2+1;
% % indx2=indx2+d(2)
% % e=c(d(1)+1:d(1)+d(2));
% % a(5)=log(var(e)); % detailed 
% % 
% % e=c(d(1)+d(2)+1:d(1)+d(2)+d(3));
% % a(6)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+1:d(1)+d(2)+d(3)+d(4));
% % a(7)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+1:d(1)+d(2)+d(3)+d(4)+d(5));
% % a(8)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+d(5)+1:d(1)+d(2)+d(3)+d(4)+d(5)+d(6));
% % a(9)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+1:d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7));
% % a(10)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+1:d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+d(8));
% % a(11)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+d(8)+1:d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+d(8)+d(9));
% % a(12)=log(var(e));
% % 
% % e=c(d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+d(8)+d(9)+1:d(1)+d(2)+d(3)+d(4)+d(5)+d(6)+d(7)+d(8)+d(9)+d(10));
% % a(13)=log(var(e));
% 
% r=aryule(x,2);
% a(14)=r(2);
% a(15)=r(3);
% 
% f=filter(r,1,x);
% a(16)=log(var(f));
% %b=[a(1:5),a(8:12)];
% %a=b;
% a(17)=rms(x); %rms
% a(18)=sum(abs(x.^2)); % square integral
% a(19)=sum(0.5*abs(x))/length(x); % modified mean absolute value
% a(20)=sum(x.^2)/length(x); % power
% a(21)=exp(sum(log(abs(x)))/length(x)); % log detector
% a(22)=sqrt(abs(sum(x.^2)/length(x))); % v-order_2
 %a(4)=kurtosis(hf);
% a(24)=log(std(x));
%a(5)=mode(hf);
%a(5)=median(hf);
% s=0;
% for i=1:length(x)-1
%     s=s+abs(x(i+1)-x(i));
% end
% a(27)=s; % waveform length
% a(28)=s/length(x); % average amplitude change
% 
 %a(5)=skewness(hf);
% [ca,cd]=dwt(x,'db4');
%    a(30)=entropy(ca);
%    %a(30)=sum((ca.^2).*(log((ca.^2)))); % entropy
%    a(31)=entropy(cd);
%    %a(31)=sum((cd.^2).*(log((cd.^2))));
    %a(5)=entropy(lf);
%    %a(32)=sum((x.^2).*(log(x.^2)));
%    a(33)=(abs(sum(sqrt(abs(x)))/length(x)))^2; % square root mean
%    a(34)=log(var(xcorr(x)));
 %   a(3)=sum(psd(lf));
%    a(36)=10*log10(sum(psd(x))); % periodogram
%    a(37)=sum((x.^2).*(log(x.^2))); % entropy
%    a(38)=log(min(var(x)));
% %    a(39)=max(smooth(psd(x))); % black-turkey
% %    a(40)=sum(smooth(psd(x)));
%    a(39)=norm(x);
%    [A,E]=lpc(x,4);  % yule-walker AR parameters
%    a(40)=A(1);
%    a(41)=A(2);
%    a(42)=A(3);
%    a(43)=A(4);
%    a(44)=log(E);
    %[G,H]=arburg(lf,2); %burg AR parameters
    %a(5)=G(1);
    %a(5)=G(2);
%    a(47)=G(3);
%    a(48)=G(4);
%    a(49)=log(H);
%    a(50)=rms(x)/(sum(abs(x))/length(x)); % rms shape factor
%    a(51)=a(33)/(sum(abs(x))/length(x)); % square root shape factor
%    a(52)=max(x)/rms(x);% crest factor
%    a(53)=max(x)/a(33);
%    a(54)=max(x)/(sum(abs(x))/length(x)); % impulse factor
%    a(55)=moment(x,5); % 5th order
    %a(5)=moment(hf,7); % 6th order
%    a(57)=log(mse(x)); % mean square error
%    %a(60)=ztest(x,mean(x),std(x)); % ztest
%    %a(58)=abs(geomean(x));
%    %a(59)=abs(harmmean(x)); 
%    a(2)=iqr(lf);% interquartile mean
%    a(59)=log(mad(x));
%    a(60)=log(max(prctile(x,[0 100]))); % percentile
%    %a(61)=zscore(x);
%    a(61)=partialcorr(x);
%    STFT=abs(specgram(x));
%    a(62)=log(sum((STFT).^2));
% %    a(63)=xcorr(hf);
% %    a(64)=log(a(63));
% %    a(65)=log(a(61));
% %    w=awgn(x,10);
% %    a(63)=covar(x,w);
%    J=abs(fft(x));
%    a(63)=log(sum((J).^2));
    %z=hf+1*i*(hilbert(hf));
    %a(5)=sum(abs(z).^2);
end
    
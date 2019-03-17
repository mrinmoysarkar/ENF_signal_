function a = get_feature(lf,hf,option)
warning('all','off');
if option == 1 % 60 power
    s=0;
    for i=1:length(hf)-1
        s=s+abs(hf(i+1)-hf(i));
    end
    a(1)=s;%HF
    a(2)=log(var(xcorr(hf)));%HF
    [G,H]=arburg(hf,4);
    a(3)=log(H);%HF
elseif option == 2 % 60 audio
    a(1)=log(var(xcorr(lf)));%LF
    a(2)=iqr(lf);%LF
    a(3)=median(hf);%HF
    a(4)=sum(psd(lf));%LF
elseif option == 3 % 50 power
    a(1)=mean(lf);%lF
    s=0;
    for i=1:length(lf)-1
        s=s+abs(lf(i+1)-lf(i));
    end
    a(2)=s;%lF
    a(3)=max(lf)/rms(lf);%lF
    a(4)=median(lf);
    a(5) = iqr(lf);
    [G,H]=arburg(hf,4);
    a(6)=G(1);
    a(7)=G(2);
    a(8)=G(3);
    a(9)=G(4);
elseif option == 4 % 50 audio
    a(1)=log(var(xcorr(hf)));
    a(2)=sum(0.5*abs(hf))/length(hf);
    [G,H]=arburg(hf,4);
    a(3)=G(2);
    a(4)=median(hf);
elseif option == 5 % hajj feature
    x = lf+hf;
    a(1) = mean(x);
    a(2)=log(var(x));
    a(3)=log(range(x));
    [c,d]=wavedec(x,9,'db7');
    indx1=1;
    indx2 = 0;
    for i=1:length(d)-1
        indx1=indx2+1;
        indx2=indx2+d(i);
        e=c(indx1:indx2);
        a(3+i)=log(var(e));
    end
    r=aryule(x,2);
    a(14)=r(2);
    a(15)=r(3);
    
    f=filter(r,1,x);
    a(16)=log(var(f));
end

end
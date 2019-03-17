function a = enf_feature_50a(lf,hf,pa50)
warning('all','off');

if pa50 == 1
    %50a first classification BF
    a(1)=log(var(xcorr(hf)));
    [G,H]=arburg(hf,4);
    a(2)=G(2);
elseif pa50 == 2
    %50a second classification DE
    a(1)=sum(0.5*abs(hf))/length(hf);
    a(2)=log(var(xcorr(hf)));
    [G,H]=arburg(hf,4);
    a(3)=G(2);
elseif pa50 == 3
    %50a third class GH
    [G,H]=arburg(hf,4);
    a(1)=G(2);
    a(2)=median(hf);
end
end
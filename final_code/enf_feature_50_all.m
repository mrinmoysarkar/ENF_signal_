function a = enf_feature_50_all(lf,hf)
warning('all','off');
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
a(6)=G(2);
end

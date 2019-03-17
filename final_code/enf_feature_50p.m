function a = enf_feature_50p(lf,hf,pa50)
warning('all','off');
if pa50 == 1
    %50p 1st BF thake B choose threshold 0.7
    a(1)=mean(lf);%lF
    s=0;
    for i=1:length(lf)-1
        s=s+abs(lf(i+1)-lf(i));
    end
    a(2)=s;%lF
    a(3)=max(lf)/rms(lf);%lF
    a(4)=median(lf);
    
elseif pa50 == 2
    %50p 2nd FH thake H choose threshold 0.7
    a(1)=mean(lf);%lF
    s=0;
    for i=1:length(lf)-1
        s=s+abs(lf(i+1)-lf(i));
    end
    a(2)=s;%lF
    a(3)=max(lf)/rms(lf);%lF
    a(4)=median(lf);
        
elseif pa50 == 3
    %50p 3rd FE thake E choose threshold 0.83
    a(1)=mean(lf);%lF
    s=0;
    for i=1:length(lf)-1
        s=s+abs(lf(i+1)-lf(i));
    end
    a(2)=s;%lF
    a(3)=max(lf)/rms(lf);%lF
    a(4)=median(lf);
    
elseif pa50 == 4
    %50p 4th FD thake D choose threshold 0.8
    a(1)=mean(lf);%lF
    a(2)=max(lf)/rms(lf);%lF
    a(3)=median(lf);
    a(4) = iqr(lf);
    [G,H]=arburg(hf,4);
    a(5)=G(2);
    a(6)=G(1);
    a(7)=G(3);
    a(8)=G(4);
    
elseif pa50 == 5
    %50p 5th FG choose threshhold 0.7
    a(1)=median(lf);
    [G,H]=arburg(hf,4);
    a(2)=G(2);
    a(3)=G(1);
    a(4)=G(3);
    a(5)=G(4);
end
end

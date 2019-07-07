clear all;
close all;
load('database_LF_HF.mat');
load('practice.mat');
dbase = database_LF_HF50;
pa=1;

n = length(dbase);
indx = 1;

for i=1:n
    label = dbase(i).name;
    label = label(6);
    
    if pa==0
         n1 = length(dbase(i).power);
    else
         n1 = length(dbase(i).audio);
    end
    for j=1:n1
        if pa==0
            lf = dbase(i).power(j).LF;
            hf = dbase(i).power(j).HF;
        else
            lf = dbase(i).audio(j).LF;
            hf = dbase(i).audio(j).HF;
        end
        features = enf_features(lf,hf);
        X(indx,:) = features;
        Y(indx,:)=label;
        indx = indx+1;
    end
end

% similarity check

d = squareform(pdist(X','euclidean'))



function a = enf_features(lf,hf)
%     %60p
%     s=0;
%     for i=1:length(hf)-1
%         s=s+abs(hf(i+1)-hf(i));
%     end
%     a(1)=s;%HF
%     a(2)=log(var(xcorr(hf)));%HF
%     [G,H]=arburg(hf,4);
%     a(3)=log(H);%HF

%     %60a
%      a(1)=log(var(xcorr(lf)));%LF
%      a(2)=iqr(lf);%LF
%      a(3)=median(hf);%HF
%      a(4)=sum(psd(lf));%LF

%     50p
%     a(1)=mean(lf);%lF
%     s=0;
%     for i=1:length(lf)-1
%         s=s+abs(lf(i+1)-lf(i));
%     end
%     a(2)=s;%lF
%     a(3)=max(lf)/rms(lf);%lF
%     a(4)=median(lf);
%     a(5) = iqr(lf);
%     [G,H]=arburg(hf,4);
%     a(6)=G(1);
%     a(6)=G(2);
%     a(8)=G(3);
%     a(9)=G(4);
    
    %%50a
    a(1)=sum(0.5*abs(hf))/length(hf);
    a(2)=log(var(xcorr(hf)));
    a(3)=median(hf);
    [G,H]=arburg(hf,4);
    a(4)=G(2);
%     a(5)=G(2);
%     a(6)=G(3);
%     a(7)=G(4);

end
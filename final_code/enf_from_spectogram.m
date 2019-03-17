clear all;
close all;

% [x,fs]=audioread(file_name);
% [enf,p_a,fc]=get_enf(x,fs,0);
% lf=smooth(enf,.5,'rloess');
% hf=enf-lf;




class_name='';
p=[];
practice={};
for i=1:3
    file_name = strcat('..\Testing_dataset\Test_',num2str(i),'.wav');
    [x,fs]=audioread(file_name);
    [enf,p_a,fc]=get_enf_sp(x,fs,0);
    disp(mean(enf));
%     lf=smooth(enf,.5,'rloess');
%     hf=enf-lf;
%     practice(i).LF=lf;
%     practice(i).HF=hf;
%     practice(i).P_A = p_a;%0 power 1 audio

end



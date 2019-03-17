clear all;
close all;

load('database_LF_HF.mat');

n = size(database_LF_HF50,2);

power50 = {};
audio50 = {};
p50 = 1;
a50 = 1;

for i =1:n
    name = database_LF_HF50(i).name;
    name = name(end);
    audio = database_LF_HF50(i).audio;
    power = database_LF_HF50(i).power;
    n1 = size(audio,2);
    n2 = size(power,2);
    
    for j=1:n1
        audio50(a50).LF = audio(j).LF;
        audio50(a50).HF = audio(j).HF;
        audio50(a50).name = name;
        a50 = a50 + 1;
    end
    for j=1:n2
        power50(p50).LF = power(j).LF;
        power50(p50).HF = power(j).HF;
        power50(p50).name = name;
        p50 = p50 + 1;
    end
    
end


n = size(database_LF_HF60,2);
power60 = {};
audio60 = {};
p60 = 1;
a60 = 1;

for i =1:n
    name = database_LF_HF60(i).name;
    name = name(end);
    audio = database_LF_HF60(i).audio;
    power = database_LF_HF60(i).power;
    n1 = size(audio,2);
    n2 = size(power,2);
    
    for j=1:n1
        audio60(a60).LF = audio(j).LF;
        audio60(a60).HF = audio(j).HF;
        audio60(a60).name = name;
        a60 = a60 + 1;
    end
    for j=1:n2
        power60(p60).LF = power(j).LF;
        power60(p60).HF = power(j).HF;
        power60(p60).name = name;
        p60 = p60 + 1;
    end
    
end

practice60p = power60;%only 60hz power
practice60a = audio60;%only 60hz audio
practice50p = power50;%only 50hz power
practice50a = audio50;%only 50hz audio

save('train_acc_check.mat', 'practice60p', 'practice60a', 'practice50p', 'practice50a')


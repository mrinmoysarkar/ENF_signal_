clear all;
close all;
load('database_LF_HF.mat');

database_LF_HF50(7).name='Grid_K';

k=1;l=1;
for i=1:3
    for j=1:length(database_LF_HF50(i).audio)
        database_LF_HF50(7).audio(k).LF = database_LF_HF50(i).audio(j).LF;
        database_LF_HF50(7).audio(k).HF = database_LF_HF50(i).audio(j).HF;
        k = k+1;
    end
    for j=1:length(database_LF_HF50(i).power)
        database_LF_HF50(7).power(l).LF = database_LF_HF50(i).power(j).LF;
        database_LF_HF50(7).power(l).HF = database_LF_HF50(i).power(j).HF;
        l = l+1;
    end
end

database_LF_HF50(8).name='Grid_L';
k=1;l=1;
for i=4:6
    for j=1:length(database_LF_HF50(i).audio)
        database_LF_HF50(8).audio(k).LF = database_LF_HF50(i).audio(j).LF;
        database_LF_HF50(8).audio(k).HF = database_LF_HF50(i).audio(j).HF;
        k = k+1;
    end
    for j=1:length(database_LF_HF50(i).power)
        database_LF_HF50(8).power(l).LF = database_LF_HF50(i).power(j).LF;
        database_LF_HF50(8).power(l).HF = database_LF_HF50(i).power(j).HF;
        l = l+1;
    end
end

save('database_LF_HF.mat','database_LF_HF50','database_LF_HF60')
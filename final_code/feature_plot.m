clear all;
close all;
load('database_LF_HF.mat');

d = database_LF_HF60(1);
disp(d.name);
p = d.power;
a = d.audio;
d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = enf_feature_60p(p(i).LF,p(i).HF);
end

% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,1),d(:,2),d(:,3),'ro');

hold on;
d = database_LF_HF60(2);
disp(d.name);
p = d.power;
a = d.audio;
d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = enf_feature_60p(p(i).LF,p(i).HF);
end

% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,1),d(:,2),d(:,3),'b*');

d = database_LF_HF60(3);
disp(d.name);
p = d.power;
a = d.audio;
d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = enf_feature_60p(p(i).LF,p(i).HF);
end
% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,1),d(:,2),d(:,3),'gv');
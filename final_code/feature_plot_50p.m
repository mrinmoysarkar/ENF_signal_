clear all;
close all;
feature1 = 1;
feature2 = 2;
feature3 = 3;
load('database_LF_HF.mat');
st = {'ro','gd','b+','c*','k^','mv'};
for j=1:6
d = database_LF_HF50(j);
disp(d.name);

p = d.power;
d=zeros(length(p),9);
for i=1:length(p)
    d(i,:) = get_feature(p(i).LF,p(i).HF,3);
end

% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,feature1),d(:,feature2),d(:,feature3),char(st(j)));
hold on;
end

xlabel(strcat('Feature No. ',num2str(feature1)));
ylabel(strcat('Feature No. ',num2str(feature2)));
zlabel(strcat('Feature No. ',num2str(feature3)));
%legend('Texas','Eastern U.S.','Western U.S.');
legend('Lebanon','Turkey','Ireland','France','Tenerife','India (Agra)');
set(gca,'fontsize',18)

% A Texas
% B Lebanon
% C Eastern U.S.
% D Turkey
% E Ireland
% F France
% G Tenerife
% H India (Agra)
% I Western U.S.

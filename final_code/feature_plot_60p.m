clear all;
close all;
feature1 = 1;
feature2 = 2;
feature3 = 3;

load('database_LF_HF.mat');

d = database_LF_HF60(1);
disp(d.name);
p = d.power;
%a = d.audio;

d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = get_feature(p(i).LF,p(i).HF,1);
end

% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,feature1),d(:,feature2),d(:,feature3),'ro');
%plot(d(:,3),'ro');
hold on;


d = database_LF_HF60(2);
disp(d.name);
p = d.power;
%a = d.audio;

d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = get_feature(p(i).LF,p(i).HF,1);
end

% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,feature1),d(:,feature2),d(:,feature3),'b*');
%plot(d(:,3),'b+');


d = database_LF_HF60(3);
disp(d.name);
p = d.power;
%a = d.audio;

d=zeros(length(p),3);
for i=1:length(p)
    d(i,:) = get_feature(p(i).LF,p(i).HF,1);
end
% d(:,1) = d(:,1) / max(abs(d(:,1)));
% d(:,2) = d(:,2) / max(abs(d(:,2)));
% d(:,3) = d(:,3) / max(abs(d(:,3)));
plot3(d(:,feature1),d(:,feature2),d(:,feature3),'gv');
%plot(d(:,3),'gv');


xlabel(strcat('Feature No. ',num2str(feature1)));
ylabel(strcat('Feature No. ',num2str(feature2)));
zlabel(strcat('Feature No. ',num2str(feature3)));
legend('Texas','Eastern U.S.','Western U.S.');
%legend('Lebanon','Turkey','Ireland','France','Tenerife','India (Agra)');
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
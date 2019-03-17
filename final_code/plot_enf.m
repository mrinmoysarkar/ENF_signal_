clear all;
close all;
load('database_LF_HF.mat');
for j=1:3
d = database_LF_HF60(j);
disp(d.name);
p = d.power;
a = d.audio;
enfp=[];
for i=1:length(p)
    enfp = [enfp (p(i).LF + p(i).HF)'];
end

enfa=[];
for i=1:length(a)
    enfa = [enfa (a(i).LF + a(i).HF)'];
end
figure(j);
subplot(211)
plot(enfp)
xlim([0 4500])
ylim([59.9 60.1])
ylabel('ENF values (Hz)')
xlabel('Sample No.')
title('ENF from Power Signal')
set(gca,'fontsize',18)
subplot(212)
plot(enfa)
xlim([0 700])
ylim([59.5 60.5])
ylabel('ENF values (Hz)')
xlabel('Sample No.')
title('ENF from Audio Signal')
set(gca,'fontsize',18)
end
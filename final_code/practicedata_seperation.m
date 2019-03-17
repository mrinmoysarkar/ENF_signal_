clear all;
close all;
%load('practice.mat');
load('Test.mat');
%grid_name = 'AHCFFBGINDAFBDCINNAEHBBADCGNGBDDCHGEAIHIEHECFFNGEI';
grid_name = 'NDDCDNNDAFANGBGBFCEHGHHHGHFDAIDNFHIIECBDENIBEFGNAGIINIGHAEFCCCFDGCECGIEICENBEEHADIHCGAABIHCNDBAGBFBB';
practice50a={};
practice50p={};
practice60a={};
practice60p={};
l=1;m=1;n=1;o=1;
for i=1:length(practice)
     if strfind('ACI',grid_name(i))
         if practice(i).P_A==0
             practice60p(l).LF=practice(i).LF;
             practice60p(l).HF=practice(i).HF;
             practice60p(l).name=grid_name(i);
             l=l+1;
         else
             practice60a(m).LF=practice(i).LF;
             practice60a(m).HF=practice(i).HF;
             practice60a(m).name=grid_name(i);
             m=m+1;
         end
     elseif strfind('BDEFGH',grid_name(i))
         
         if practice(i).P_A==0
             practice50p(n).LF=practice(i).LF;
             practice50p(n).HF=practice(i).HF;
             practice50p(n).name=grid_name(i);
             n=n+1;
         else
             practice50a(o).LF=practice(i).LF;
             practice50a(o).HF=practice(i).HF;
             practice50a(o).name=grid_name(i);
             o=o+1;
         end
     else
         mu = mean(practice(i).LF);
         if practice(i).P_A==0
             
             if mu>48 && mu<52
             practice50p(n).LF=practice(i).LF;
             practice50p(n).HF=practice(i).HF;
             practice50p(n).name=grid_name(i);
             n=n+1;
             else
             practice60p(l).LF=practice(i).LF;
             practice60p(l).HF=practice(i).HF;
             practice60p(l).name=grid_name(i);
             l=l+1;
             end
         else
             if mu>48 && mu<52
             practice50a(o).LF=practice(i).LF;
             practice50a(o).HF=practice(i).HF;
             practice50a(o).name=grid_name(i);
             o=o+1;
             else
             practice60a(m).LF=practice(i).LF;
             practice60a(m).HF=practice(i).HF;
             practice60a(m).name=grid_name(i);
             m=m+1;
             end
         end
     end
end
%save('practice.mat','practice60p','practice60a','practice50p','practice50a','-append');
save('Test.mat','practice60p','practice60a','practice50p','practice50a','-append');
clear all;
close all;
load('database_LF_HF.mat');
load('practice.mat');


n = length(database_LF_HF50);
indx = 1;

for i=1:n
    label = database_LF_HF50(i).name;
    label = label(6);
    n1 = length(database_LF_HF50(i).audio);
    for j=1:n1
        lf = database_LF_HF50(i).audio(j).LF;
        hf = database_LF_HF50(i).audio(j).HF;
        %features = enf_feature_50_all(lf,hf);
        features = enf_features(lf,hf);
        X(indx,:) = features;
        Y(indx,:)=label;
        indx = indx+1;
    end
end
gridnames='BDEFGH';

%%%%%%%%%%%%%%%%%%%%%%% one vs all
for k=1:length(gridnames)
    xx = X;
    yy = substitute(gridnames(k),Y);
    classes = unique(yy);
    SVMModels{k} = fitcsvm(xx,yy,'ClassNames',classes,'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
    CompactSVMModel = compact(SVMModels{k});%
    CompactSVMModel = fitPosterior(CompactSVMModel,xx,yy);%
    SVMModels{k} = CompactSVMModel;
end


% % train accuracy
% true_label='';
% pred_label='';
% for i=1:length(Y)
%     sample = X(i,:);
%     true_label(i)=Y(i);
%     
%     for j=1:length(SVMModels)
%         [labels,PostProb] = predict(SVMModels{j},sample);
%         if labels{1} ~= 'N'
%             pred_label(i)=labels{1};
%         end
%     end
%     if length(true_label) ~= length(pred_label)
%         pred_label(i)='N';
%     end
% end
% disp(true_label)
% disp(pred_label)
% 
% j=0;
% for i=1:length(true_label)
%     if true_label(i)==pred_label(i)
%         j = j+1;
%     end
% end
% acc = j/length(true_label);
% disp(acc*100);
% 
% % test accuracy
% true_label='';
% pred_label='';
% for i=1:length(practice50a)
%     lf = practice50a(i).LF;
%     hf = practice50a(i).HF;
%     sample = enf_features(lf,hf);
%     label = practice50a(i).name;
%     true_label(i)=label;
%     
%     for j=1:length(SVMModels)
%         [labels,PostProb] = predict(SVMModels{j},sample);
%         if labels{1} ~= 'N'
%             pred_label(i)=labels{1};
%         end
%     end
%     if length(true_label) ~= length(pred_label)
%         pred_label(i)='N';
%     end
% end
% disp(true_label)
% disp(pred_label)
% 
% j=0;
% for i=1:length(true_label)
%     if true_label(i)==pred_label(i)
%         j = j+1;
%     end
% end
%         
% acc = j/length(true_label);
% disp(acc*100);



%%%%%%%%%%%%%%% all combination
all_combination = combnk(gridnames,2);
for i=1:length(all_combination)
    indxes = get_indxes(Y,all_combination(i,:));
    yy=Y(logical(indxes));
    yy=convertCell(yy);
    xx=X(logical(indxes),:);
    
    classes = unique(yy);
    SVMModels{i} = fitcsvm(xx,yy,'ClassNames',classes,'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
    CompactSVMModel = compact(SVMModels{i});%
    CompactSVMModel = fitPosterior(CompactSVMModel,xx,yy);%
    SVMModels{i} = CompactSVMModel;
end

% train accuracy
true_label='';
pred_label='';
for i=1:length(Y)
    sample = X(i,:);
    true_label(i)=Y(i);
    label_count = zeros(1,length(gridnames));
    
    for j=1:length(SVMModels)
        [labels,PostProb] = predict(SVMModels{j},sample);
        n = strfind(gridnames,labels{1});
        label_count(n) = label_count(n)+1;
    end
    [m,mi] = max(label_count);
    
    pred_label(i)=gridnames(mi);
end


disp(true_label)
disp(pred_label)

j=0;
for i=1:length(true_label)
    if true_label(i)==pred_label(i)
        j = j+1;
    end
end
acc = j/length(true_label);
disp(acc*100);


% test accuracy
true_label='';
pred_label='';
for i=1:length(practice50a)
    lf = practice50a(i).LF;
    hf = practice50a(i).HF;
    sample = enf_features(lf,hf);
    label = practice50a(i).name;
    true_label(i)=label;
    label_count = zeros(1,length(gridnames));
    for j=1:length(SVMModels)
        [labels,PostProb] = predict(SVMModels{j},sample);
        n = strfind(gridnames,labels{1});
        label_count(n) = label_count(n)+1;
    end
    [m,mi] = max(label_count);
    pred_label(i)=gridnames(mi);
end
disp(true_label)
disp(pred_label)

j=0;
for i=1:length(true_label)
    if true_label(i)==pred_label(i)
        j = j+1;
    end
end
        
acc = j/length(true_label);
disp(acc*100);






%%%%%%% functions %%%%%%%%

function yy=convertCell(y)
    for i=1:length(y)
        yy{i,1}=y(i);
    end
end


function indx = get_indxes(Y,grid_name)
    indx = zeros(length(Y),1);
    for i=1:length(Y)
        if Y(i)==grid_name(1) || Y(i)==grid_name(2)
            indx(i) = 1;
        end
    end
end

function yy = substitute(lbl,arr)
    for i=1:length(arr)
        if arr(i)==lbl
            yy{i,1}=lbl;
        else
            yy{i,1}='N';
        end
    end
end

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
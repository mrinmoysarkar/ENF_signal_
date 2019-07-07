clear all;
close all;
load('database_LF_HF.mat');
load('practice.mat');


n = length(database_LF_HF50);
indx = 1;

for i=1:n
    label = database_LF_HF50(i).name;
    label = label(6);
    n1 = length(database_LF_HF50(i).power);
    for j=1:n1
        lf = database_LF_HF50(i).power(j).LF;
        hf = database_LF_HF50(i).power(j).HF;
        features = enf_feature_50_all(lf,hf);
        X(indx,:) = features;
        Y(indx,:)=label;
        indx = indx+1;
    end
end
gridnames='BDEFGH';

%%%%%%%%%%%%%%%%%%%%%%%
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


% train accuracy
true_label='';
pred_label='';
for i=1:length(Y)
    sample = X(i,:);
    true_label(i)=Y(i);
    
    for j=1:length(SVMModels)
        [labels,PostProb] = predict(SVMModels{j},sample);
        if labels{1} ~= 'N'
            pred_label(i)=labels{1};
        end
    end
    if length(true_label) ~= length(pred_label)
        pred_label(i)='N';
    end
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
for i=1:length(practice50p)
    lf = practice50p(i).LF;
    hf = practice50p(i).HF;
    sample = enf_feature_50_all(lf,hf);
    label = practice50p(i).name;
    true_label(i)=label;
    
    for j=1:length(SVMModels)
        [labels,PostProb] = predict(SVMModels{j},sample);
        if labels{1} ~= 'N'
            pred_label(i)=labels{1};
        end
    end
    if length(true_label) ~= length(pred_label)
        pred_label(i)='N';
    end
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



%%%%%%%%%%%%%%%%
% all_combination = combnk(gridnames,2);
% for i=1:length(all_combination)
%     indxes = get_indxes(Y,all_combination(i,:));
%     yy=Y(logical(indxes));
%     yy=convertCell(yy);
%     xx=X(logical(indxes),:);
%     
%     classes = unique(yy);
%     SVMModels{i} = fitcsvm(xx,yy,'ClassNames',classes,'Standardize',true,...
%         'KernelFunction','rbf','BoxConstraint',1);
%     CompactSVMModel = compact(SVMModels{i});%
%     CompactSVMModel = fitPosterior(CompactSVMModel,xx,yy);%
%     SVMModels{i} = CompactSVMModel;
% end
% 
% % train accuracy
% true_label='';
% pred_label='';
% for i=1:length(Y)
%     sample = X(i,:);
%     true_label(i)=Y(i);
%     label_count = zeros(1,length(gridnames));
%     
%     for j=1:length(SVMModels)
%         [labels,PostProb] = predict(SVMModels{j},sample);
%         n = strfind(gridnames,labels{1});
%         label_count(n) = label_count(n)+1;
%     end
%     [m,mi] = max(label_count);
%     
%     pred_label(i)=gridnames(mi);
% end
% 
% 
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
% 
% % test accuracy
% true_label='';
% pred_label='';
% for i=1:length(practice50p)
%     lf = practice50p(i).LF;
%     hf = practice50p(i).HF;
%     sample = enf_feature_50_all(lf,hf);
%     label = practice50p(i).name;
%     true_label(i)=label;
%     label_count = zeros(1,length(gridnames));
%     for j=1:length(SVMModels)
%         [labels,PostProb] = predict(SVMModels{j},sample);
%         n = strfind(gridnames,labels{1});
%         label_count(n) = label_count(n)+1;
%     end
%     [m,mi] = max(label_count);
%     pred_label(i)=gridnames(mi);
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

function [grid,prob]=classify_svm(sample,training,group,vth)
warning('off','all');
classesall = unique(group);
grid_name = char(classesall);
t=1:length(classesall);
combination_matrix = combnk(t,2);
grid_name_combination_mat = combnk(char(classesall),2);
grid_name_combination_mat = cellstr(grid_name_combination_mat);
%disp(combination_matrix);
[r,c]=size(combination_matrix);
for k=1:r
    grid_no = combination_matrix(k,:);
    yy={};
    xx=[];
    l=1;
    for i=1:2
        for j=1:length(training)
            if char(classesall(grid_no(i))) == char(group(j))
                xx(l,:)=training(j,:);
                yy{l,1}=char(group(j));
                l=l+1;
            end
        end
    end
    classes = unique(yy);
    SVMModels{k} = fitcsvm(xx,yy,'ClassNames',classes,'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
    CompactSVMModel = compact(SVMModels{k});%
    CompactSVMModel = fitPosterior(CompactSVMModel,xx,yy);%
    SVMModels{k} = CompactSVMModel;
end
[r,c] = size(sample);
for ii=1:r
    p=[];
    label='';
    for i=1:length(SVMModels)
        [labels,PostProb] = predict(SVMModels{i},sample(ii,:));
        labels=SVMModels{i}.ClassNames;
        [p(i),mind]=max(PostProb);
        label(i)=char(labels(mind));
    end
    %disp(label);
    %disp(p);
    
    %disp(p(find(p>.95)));
    [m,in]=max(p);
    if m > vth
        grid(ii) = label(in);
        prob(ii)=m;
        %xcv = find(p>.7);%index of all grid which have probability > 0.7
        %ll = label(xcv);%label of all grid which have probability > 0.7
        if length(label) == 1
            continue;
        end
        ll=label;
        %disp(ll);
        l=unique(ll);
        occur = zeros(1,length(l));
        max_probability = zeros(1,length(l));
        for i=1:length(l)
            occur(i)=length(strfind(ll,l(i)));
            max_probability(i) = max(p(strfind(ll,l(i))));
        end
        %disp(l)
        %disp(occur)
        %disp(max_probability)
        %%%%% 23/3/2016
        [max_occur, ] = max(occur);
        index_of_max_values = find(occur == max_occur);
        if length(index_of_max_values) == 1
            while 1
                if max_probability(index_of_max_values) > .6
                    grid(ii) = l(index_of_max_values);
                    prob(ii) = max_probability(index_of_max_values);
%                     indexes = find(occur > 1);
%                     if length(indexes) > 1
%                         multiple_occur_handle(label,l(indexes),max_probability(indexes),occur(indexes),p,grid_name_combination_mat);
%                     end 
                    break;
                else
                    l(index_of_max_values) = [];
                    occur(index_of_max_values) = [];
                    max_probability(index_of_max_values) = [];
                    [max_occur, ] = max(occur);
                    index_of_max_values = find(occur == max_occur);
                    if length(index_of_max_values) ~= 1
                        %else treatment
                        [grid(ii),prob(ii)] = multiple_occur_handle(label,l(index_of_max_values),max_probability(index_of_max_values),occur(index_of_max_values),p,grid_name_combination_mat);
                        break;
                    end
                end
            end
        else
            [grid(ii),prob(ii)] = multiple_occur_handle(label,l(index_of_max_values),max_probability(index_of_max_values),occur(index_of_max_values),p,grid_name_combination_mat);
                      
%             ll=l(index_of_max_values);
%             l = ll;
%             ind = ii;
%             disp(l);
%             while length(l) >= 2
%                 l = combnk(l,2);
%                 %grid_name_combination_mat = cellstr(grid_name_combination_mat)
%                 newlebel='';
%                 [r, ]=size(l);
%                 pp=[];
%                 ppi=1;
%                 for i=1:r
%                     ms=strfind(grid_name_combination_mat,l(i,:));
%                     ind = find(~cellfun(@isempty,ms));
%                     disp(p(ind))
%                     if p(ind)>=.5 %.5 for 60p 60a
%                         newlebel=strcat(newlebel,label(ind));
%                         pp(ppi)=p(ind);ppi=ppi+1;
%                     elseif r==1 && p(ind)>=.5
%                         x1=occur(strfind(ll,l(1)));
%                         x2=occur(strfind(ll,l(2)));
%                         if x1>x2
%                             newlebel=strcat(newlebel,l(1));
%                         else
%                             newlebel=strcat(newlebel,l(2));
%                         end
%                     end
%                 end
%                 xcv = find(pp>.56);
%                 l=newlebel(xcv);
%                 l=unique(l);
%                 %disp(l);
%             end
%             
%             if isempty(l)
%                 grid(ii) = 'N';
%                 prob(ii) = 1;
%                 disp('ddidiid')
%             else
%                 grid(ii) = l;
%                 if ind ~= ii
%                     prob(ii) = p(ind);
%                 end
%             end
        end
    else
        grid(ii) = 'N';
        prob(ii)=m;
    end
end
end
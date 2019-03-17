function [gridname, probability] = multiple_occur_handle(label,uniquelabel,unique_max_probability,occurance,all_probability,combination_matrix)
    uniquelabel = sort(uniquelabel);
    %disp(uniquelabel);
    %disp(unique_max_probability);
    %disp(occurance);
    %disp(all_probability);
    %disp(label);
    %disp(combination_matrix);
    %for i=1:length(uniquelabel)
    %   indx = strfind(label,uniquelabel(i));   
    %    avg_prob(i) = length(find(all_probability(indx)>.9));
    %end
    %disp(avg_prob)
    %[m,mi] = max(avg_prob);
    %disp(uniquelabel(mi));
    combination_mat = combnk(uniquelabel,2);
    %disp(combination_mat);
    grid_name_combination_mat = cellstr(combination_matrix);
    %disp(grid_name_combination_mat);
    while 1
        ms=strfind(grid_name_combination_mat,combination_mat(1,:));
        ind = find(~cellfun(@isempty,ms));
        L = label(ind);
        L_ = grid_name_combination_mat{ind};
        idx = strfind(L_,L);
        L_(idx)=[];
        P = all_probability(ind);
        if P < 0.6
            combination_mat(1,:)=[];
        elseif length(combination_mat) > 2
            combination_mat(1,:)=[];
            indx = 1;
            while 1
                flg = strfind(combination_mat(indx,:),L_);
                if ~isempty(flg)
                    combination_mat(indx,:)=[];
                    indx = 1;
                end
                indx = indx+1;
                if indx > length(combination_mat)
                    break;
                end
            end
        else
            gridname = L;
            probability = P;
            break
        end
        if isempty(combination_mat)
            gridname = 'N';
            probability = 1;
            break
        end
    end
end
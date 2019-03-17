function [trainning_matrix,group]=train_mat_generator(database,total_loop,pa50)
    trainning_matrix=[];
    group={};
    l=1;
    for i=1:length(database)
        if total_loop == 2 || total_loop == 4
            data = database(i).audio;
        else
            data = database(i).power;
        end
        name = database(i).name(6);
        for j=1:length(data)
            lf=data(j).LF;
            hf=data(j).HF;
            if total_loop == 1
                feature = enf_feature_60p(lf,hf);
            elseif total_loop == 2
                feature = enf_feature_60a(lf,hf);
            elseif total_loop == 3
                feature = enf_feature_50p(lf,hf,pa50);
            elseif total_loop == 4
                feature = enf_feature_50a(lf,hf,pa50);
            end
            trainning_matrix(l,:) = feature;
            group{l,1}=name;
            l=l+1;
        end
    end
end
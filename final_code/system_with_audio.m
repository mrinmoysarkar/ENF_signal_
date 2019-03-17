clear all;
close all;
load('database_LF_HF.mat');
%load('practice.mat');
load('Test.mat');
%practice = practice;% all practice data
PRACTICE{1} = practice60p;%only 60hz power
PRACTICE{2} = practice60a;%only 60hz audio
PRACTICE{3} = practice50p;%only 50hz power
PRACTICE{4} = practice50a;%only 50hz audio


% train matrix generation
DATABASE{1} = database_LF_HF50;
DATABASE{2} = database_LF_HF60;
DATABASE{3} = database_LF_HF50_BF;
DATABASE{4} = database_LF_HF50_DE;
DATABASE{5} = database_LF_HF50_GH;
DATABASE{6} = database_LF_HF50_BFp;
DATABASE{7} = database_LF_HF50_HFp;
DATABASE{8} = database_LF_HF50_EFp;
DATABASE{9} = database_LF_HF50_DFp;
DATABASE{10} = database_LF_HF50_GFp;



DATATYPE={'60-POWER','60-AUDIO','50-POWER','50-AUDIO'};
total_correct = 0;
total_labels = 0;

for total_loop = 1:4
    practice = PRACTICE{total_loop};
    if total_loop == 1 || total_loop == 2
        database = DATABASE{2};
        vth = 0.9;
        [trainning_matrix,group]=train_mat_generator(database,2,0); % only audio in trainer
    else
        database = DATABASE{1};
    end
    
    %another way to check sample data all sample data at a time fast method
    correct_lebel='';
    j=0;
    for i=1:length(practice)
        lf = practice(i+j).LF;
        hf = practice(i+j).HF;
        sample = [];
        if total_loop == 1 || total_loop == 2 % only audio in trainer
            feature = enf_feature_60a(lf,hf);
            sample(1,:) = feature;
            [grid_name(i),p(i)]=classify_svm(sample,trainning_matrix,group,vth);
        
        elseif total_loop == 3 || total_loop == 4 % only audio in trainer
            vth = 0.7;
            for a50=1:3
                sample = [];
                feature = enf_feature_50a(lf,hf,a50);
                sample(1,:) = feature;
                database = DATABASE{2+a50};
                [trainning_matrix,group]=train_mat_generator(database,4,a50);% only audio in trainer
                [grid_name(i),p(i)]=classify_svm(sample,trainning_matrix,group,vth);
                if grid_name(i) ~= 'N'
                    break;
                end
            end
        end
     
        if(length(practice)<50)
            correct_lebel(i)=practice(i+j).name;
        end
    end
    %[grid_name,p]=classify_svm(sample,trainning_matrix,group);
    disp(DATATYPE{total_loop});
    %disp(p)
    disp('classified name:')
    disp(grid_name);
    %disp('KKKKLLKLLLKL');
    disp('correct name:')
    disp(correct_lebel);
    j=0;
    for i=1:length(correct_lebel)
        if grid_name(i) == correct_lebel(i)
            j = j+1;
        end
    end
    if ~isempty(correct_lebel)
        L = length(correct_lebel);
        total_correct = total_correct + j;
        total_labels = total_labels + L;
        disp(j*100/L);
    else
        disp(0);
    end
    clearvars -except total_loop PRACTICE DATABASE DATATYPE total_correct total_labels;  
end



disp('over all system correctness:');
disp(total_correct*100/total_labels);
function enf = get_enf_from_power_signal(x,fs)
downsample_factor=4;
x=decimate(x,downsample_factor);
smooth_degree=.05;
fs=fs/downsample_factor;
hd = bandpass_filter(40,70,fs);
x= filter(hd,x);
data_window_length = 5;
L = data_window_length*fs;
data_overlapping_factor = 1;
FL = L*data_overlapping_factor;
total_data_length = length(x);
no_of_enf_point = floor(1+(total_data_length-FL)/L);
enf=zeros(1,no_of_enf_point);
for i=1:no_of_enf_point
    index1 =(i - 1) * L +1;
    index2 = index1 + FL -1;
    [F P] = rootmusic(x(index1:index2),2,fs);
    enf(i) = F(1);  
end
enf = smooth(enf,smooth_degree,'rloess');
end
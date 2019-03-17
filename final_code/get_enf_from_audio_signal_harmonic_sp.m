function enf = get_enf_from_audio_signal_harmonic_sp(sig,fs,fc)
f_center=[50 60];
if fc==0
    analysis=2;
else
    analysis=1;
    f_center(1)=fc;
end
no_of_harmonic =min(floor(.5*fs/60)-1,floor(.5*fs/50)-1);
del = .5;
smooth_degree=.05;
data_window_length = 15;%in second
L = data_window_length*fs;
data_overlapping_factor = 10;%in second
FL = fs*(data_window_length-data_overlapping_factor);
total_data_length = length(sig);
no_of_enf_point = floor((total_data_length-L)/FL)+1;
enfd={};
enfd(1).enf=zeros(no_of_harmonic,no_of_enf_point);
enfd(1).pow = zeros(no_of_harmonic,no_of_enf_point);
enfd(2).enf=zeros(no_of_harmonic,no_of_enf_point);
enfd(2).pow = zeros(no_of_harmonic,no_of_enf_point);

for k=1:analysis
    fo=f_center(k);
    for j=1:no_of_harmonic
        foo = fo*j;
        hd = bandpass_filter(foo-del,foo+del,fs);
        x_f=filter(hd,sig);
        for i=1:no_of_enf_point
            index1 =(i - 1) * FL +1;
            index2 = index1 + L -1;
            %[F,P] = rootmusic(x_f(index1:index2),2,fs);
            nfft = 20480;
            [specto,freq,tem,po] = spectrogram(x_f(index1:index2),1000,500,nfft,fs);
            [pm,m_in] = max(po);
            F = freq(m_in(1));
            enfd(k).enf(j,i) = F;
            enfd(k).pow(j,i) = max(pm);
        end
    end
end

if sum(sum(enfd(1).pow))>sum(sum(enfd(2).pow)) || fc ~= 0
    pow = enfd(1).pow;
    enf = enfd(1).enf;
    fo=f_center(1);
else
    pow = enfd(2).pow;
    enf = enfd(2).enf;
    fo=f_center(2);
end

for i=1:no_of_enf_point
    [m,m_indx] = max(pow(:,i));
    enf(1,i) = enf(m_indx,i)-m_indx*fo+fo;
end

enf = smooth(enf(1,:),smooth_degree,'rloess');
end

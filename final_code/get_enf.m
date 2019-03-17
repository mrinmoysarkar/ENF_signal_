function [enf,P_A,f] =get_enf(x,fs,fc)
if check_power_or_audio(x,fs)
    enf = get_enf_from_power_signal(x,fs);
    P_A=0;
else
    enf = get_enf_from_audio_signal_harmonic(x,fs,fc);
    P_A=1;
end
if fc==0
    mu=mean(enf);
    if mu<52 && mu>48
        f=50;
    else
        f=60;
    end
else
    f=fc;
end
end
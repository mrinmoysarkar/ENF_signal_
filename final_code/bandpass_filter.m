function Hd = bandpass_filter(Fc1,Fc2,Fs,N)
if nargin <4
    N   = 200;  % Order
end
% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

end

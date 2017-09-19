% Solution by Rahmat Saeedi

close all
    %Reading the audio file
    [x, FS, NBits]=wavread('love_mono22.wav');
    FS                      %Printing number of bits and sampling frequency
    NBits
    %Getting the size of audiofile
    [Size, ~]=size(x)
    %Calculating the Duration of the audio file is s
    Duration=Size/FS
    %Calculating the BitRate of the audio file
    BitRate=NBits*FS
    %Calculating the fft of the audio file
    X=fft(x);
    % where the first few DFT coefficients are
    X_0=X(1)
    X_1=X(2)
    X_2=X(3)
    % Scalling X
    X_prime=X/sqrt(Size);
    %Calculating the magnitude spectrum
    X_prime_Mag=20.*log10(abs(X_prime));
    %Obtaining frequency range in KHZ
    fmp=FS/Size*[1:(Size/2-1)]/1000;
    fml=FS/2/1000;
    fmn=-FS/Size*[(Size/2-1):-1:1]/1000;
    fm=[0 fmp fml fmn];
    %plotting the magnitude spectrum
    plot(fm,X_prime_Mag)
    title('Love\_mono22.wav');
    xlabel('Frequeny  (kHz)');
    ylabel('Magnitude Spectrum |X''(r)| (dB)');
    
    
    %%Power Spectrum of x
    [Px, F]=psd(x, 512, FS, [], 480);
    figure                      %Creatting new figure
    plot(F/1000, 10*log10(Px)); %Plots the power spectrum
    xlabel('Frequency (kHz)');
    ylabel('Power Spectral Density (in dB)');
    %Finding the exact frequency of the annoying noise
    Annoying_Noise_Freq=fm(find(X_prime_Mag==max(X_prime_Mag)))
    

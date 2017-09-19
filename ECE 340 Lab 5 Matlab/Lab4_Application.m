% Solution by Rahmat Saeedi

close all
    %Reading the audio file
    [x, FS, NBits]=wavread('love_mono22.wav');
    %Calculating the fft of the audio file
    X=fft(x);
    % Scalling X
    [Size,~]=size(x);
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
    %Finding the exact frequency of the annoying noise
    Annoying_Noise_Freq=fm(find(X_prime_Mag==max(X_prime_Mag)))
    
    X_new=X;
    
    for i=0:20
        X_new(find(X_prime_Mag==max(X_prime_Mag))+i)=0;
        X_new(find(X_prime_Mag==max(X_prime_Mag))-i)=0;
        fm(find(X_prime_Mag==max(X_prime_Mag))+i)
        fm(find(X_prime_Mag==max(X_prime_Mag))-i)

    end
    x_new=ifft(X_new);
    audiowrite('love_filteredMyWay.wav',x_new,FS);

    

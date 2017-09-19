% Solution by Rahmat Saeedi
close all;
clc;
clear all;


%% Q1
%513-tap Low pass IFR
Fs=22050; % sampling frequency
fc=2500;  % Cutoff frequency

wc=fc/(Fs/2);            %Cutoff
window = hamming(513);   %window
filter_coeff=fir1(513-1,wc, 'low', window); 

%frequency response of filter
freqz(filter_coeff,1);

%Audio File
    %Reading the audio file
    [x, FS, NBits]=wavread('love_mono22.wav');
    %Filter the audio file
    x_filtered=filter(filter_coeff,1,x); 
    
    %%Power Spectrum of x
    [Px, F]=psd(x, 513-1, FS, [], 480);
    figure                      %Creatting new figure
    plot(F/1000, 10*log10(Px)); %Plots the power spectrum
    xlabel('Frequency (kHz)');
    ylabel('Power Spectral Density of x (in dB)');
    
    %%Power Spectrum of x_filtered
    [Px_filtered, F_filtered]=psd(x_filtered, 513-1, FS, [], 480);
    figure                      %Creatting new figure
    plot(F_filtered/1000, 10*log10(Px_filtered)); %Plots the power spectrum
    xlabel('Frequency (kHz)');
    ylabel('Power Spectral Density of filtered x, LPF (in dB)');
    

    audiowrite('love_filtered.wav',x_filtered./max(abs(x_filtered)),FS);
    %Comments:
    % filtered audio has little high frequency components as the amplitude 
    % of those components have been significantly reduced
    
 %% Q2
  %513-tap High pass IFR
fc2=5000;  % Cutoff frequency

wc2=fc2/(Fs/2);            %Cutoff
window2 = hamming(513);   %window
filter_coeff2=fir1(513-1,wc2, 'high', window2); 

%frequency response of filter
figure
freqz(filter_coeff2,1);

%Audio File
    %Filter the audio file
    x_filtered2=filter(filter_coeff2,1,x); 
    

    %%Power Spectrum of x_filtered
    [Px_filtered2, F_filtered2]=psd(x_filtered2, 513-1, FS, [], 480);
    figure                      %Creatting new figure
    plot(F_filtered2/1000, 10*log10(Px_filtered2)); %Plots the power spectrum
    xlabel('Frequency (kHz)');
    ylabel('Power Spectral Density of filtered x, HPF (in dB)');
    
    
    audiowrite('love_filtered2.wav',x_filtered2./max(abs(x_filtered2)),FS);
    %Comments:
    % filtered audio has only high frequency components as the amplitude 
    % of low frequency components have been significantly reduced
    

 %% Q3
  %513-tap Bandstop IFR
fc3=[2850 3150];  % Cutoff frequencies

wc3=fc3./(Fs/2);            %Cutoff
window3 = hamming(513);   %window
filter_coeff3=fir1(513-1,wc3, 'stop', window3); 

%frequency response of filter
figure
freqz(filter_coeff3,1);

%Audio File
    %Filter the audio file
    x_filtered3=filter(filter_coeff3,1,x); 
    

    %%Power Spectrum of x_filtered
    [Px_filtered3, F_filtered3]=psd(x_filtered3, 513-1, FS, [], 480);
    figure                      %Creatting new figure
    plot(F_filtered3/1000, 10*log10(Px_filtered3)); %Plots the power spectrum
    xlabel('Frequency (kHz)');
    ylabel('Power Spectral Density of filtered x, BSF (in dB)');
    
    
    audiowrite('love_filtered3.wav',x_filtered3./max(abs(x_filtered3)),FS);
    %Comments:
    %filtered audio has frequencies around 3kHz stoped using bandstop filter
    % as the amplitude of those frequencies have been significantly reduced
   %% Q4
   figure
   
   
% MATLAB code for spectral analysis and lowpass filtering of an image
% see section 17.6, Fig. 17.20, Fig. 17.21
%
% reading the image 'ayantika.tif'
I = imread('ayantika.tif');
Iu=I;     % copy of original image
imshow(I)                   % display the image
fprintf('\nThe image Ayantika has been displayed')
fprintf('\nPress any key to continue')
pause
I = double(I);
I = I - mean(mean(I));
% 2D Bartlett window
x = bartlett(32);
for i = 1:32
    zx(i,:) = x';
	zy(:,i) = x ;
end
bartlett2D = zx .* zy;
%
n = 0;
% calculate power spectrum
P = zeros(256,256);
for (i = 1:16:320)
    for (j = 1:16:288)
        Isub = I(i:i+31,j:j+31).*bartlett2D;
        P = P + fftshift(fft2(Isub,256,256));
        n = n + 1;
    end
end
Pabs = (abs(P)/n).^2;
mesh([-128:127]*2/256,[-128:127]*2/256,Pabs/max(max(Pabs)));
xlabel('Horizontal Frequency'); ylabel('Vertical Frequency');
zlabel('Image Power Spectrum (in dB)');
print -dtiff plot1.tiff
fprintf('\nThe Image Power Spectrum has been displayed and saved')
fprintf('\nPress any key to continue')
pause


filter_coeff = [1  2 3 2 1; 2  3  4  3 2; 3  4  5  4 3; 2  3  4  3  2; 1  2  3  2 1]/65 ;
% Frequency Response plot
spec = fft2(filter_coeff,128,128) ;     % Frequency spectrum of 2-D Filter
R = abs(spec(1:65,1:65)) ;
mesh(R), grid
xlabel('Horizontal Frequency')
ylabel('Vertical Frequency');
zlabel('Frequency Response');
print -dtiff plot.tiff
fprintf('\nThe Frequency Response of the 2-D Filter has been displayed and saved')
fprintf('\nPress any key to continue')
pause
%
% Digital filtering the image
filtered_image = filter2(filter_coeff, double(I)) ;
imshow(uint8(filtered_image))
%imshow(Iu)
imwrite(uint8(filtered_image),'ayantika_filt.tif','tif') ;
fprintf('\nThe Filtered Image has been displayed and saved')   
    
    
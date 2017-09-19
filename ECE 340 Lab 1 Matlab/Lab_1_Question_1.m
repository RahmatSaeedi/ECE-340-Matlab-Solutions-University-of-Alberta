% Solution by Rahmat Saeedi
close all; clear all;
%% Q1
%Definning  X1
k1=-10:1:40;
n1=k1+11;
x1(n1)=-5.1*sin(0.1 .*pi .*n1 -3 .*pi ./4)+1.1 .*cos(0.4 .*pi .*n1);
%Definning  X2
k2=0:1:100;
n2=k2+1;
x2(n2)=(-0.9).^(n2).*exp(1i .*pi .*n2 ./10);
%Plotting X1 and real and imaginary parts of X2
figure
hold on;
subplot(3,1,1);
stem(k1,x1);
xlabel('K');
ylabel('X1[K]');
subplot(3,1,2);
stem(k2,real(x2));
xlabel('K');
ylabel('Real Part of X2[K]');
subplot(3,1,3);
stem(k2,imag(x2));
xlabel('K');
ylabel('Imaginary Part of X2[K]');
%Calculating energy of X1 & X2
X1_Energy=sum(abs(x1).^2)
X2_Energy=sum(abs(x2).^2)
%% Q2
%Reading the wave file
[x3, FS, NBITS]=wavread('baila.wav');
X3_Size=size(x3)
%Getting the size of the 
[x3_size temp]=size(x3);
k3=1:1:max(x3_size);
%Plotting the wave file
plot(k3,x3'); %My computer can't handel the data with stem, Out of memory PC, so I used plot instead of stem
xlabel('Time, K (1/44100 sec)');
ylabel('baila.wav, X3[K]');
%Calculating energy of X3
X3_Energy=sum(abs(x3).^2)
%Calculating and saving half of the original file
x3s=x3(1:x3_size/2);
wavwrite(x3s,FS,NBITS,'baila_half.wav');
%% Q3
%Read Lena.jpg
lena=imread('lena.jpg');
%Get Size of lena
[lena_row, lena_col]=size(lena)
%Get the maximum pixel value
max_pix_value=max(max(lena))
%Create brighter image
lena_bright=lena+30;
%Save the new image
imwrite(lena_bright,'lena_brigh.jpg','jpg','Quality',100);
%% Q4
%Creatting system response with unit step input and a=2; BIBO UNStable
sysResp_a_2=sysresp(ones(1,51),2);
sysResp_a_2(1)=[];
stem(sysResp_a_2);
xlabel('K');
ylabel('y[k] when a=2');

%Creatting system response with unit step input and a=0.5; BIBO Stable
figure
sysResp_a_0_5=sysresp(ones(1,51),0.5);
sysResp_a_0_5(1)=[];
stem(sysResp_a_0_5);
xlabel('K');
ylabel('y[k] when a=0.5');

%Creatting system response with unit step input and a=0.8; BIBO Stable
figure
sysResp_a_0_8=sysresp(ones(1,51),0.8);
sysResp_a_0_8(1)=[];
stem(sysResp_a_0_8);
xlabel('K');
ylabel('y[k] when a=0.8');
%Note system is BIBO stable whenever a<1
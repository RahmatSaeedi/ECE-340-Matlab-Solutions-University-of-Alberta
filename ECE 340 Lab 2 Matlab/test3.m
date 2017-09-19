% Solution by Rahmat Saeedi
%% test3.m
close all;clear;clc;
I=imread('barbaraLarge.jpg');
% Low pass filtering before downsampling
% creates a 3x3 low pass filter kernel
filt=fspecial('average',[3 3]);
% applies the lpf by convolving the image with the filter kernel
filt_img=imfilter(I,filt,'conv');

B_LPF=imresize(filt_img, 0.7 , 'nearest', 0);
B=imresize(I, 0.7, 'nearest', 0);

figure,  imshow(I); title('Original Barbara Image');
figure,  imshow(B); title('Barbara Image resized by 70% of original size');
figure,  imshow(B_LPF); title('Low pass filter applied before Resizing to 70% of original size');








close all; clear all;clc;
fore = imread('data\Poisson_editing\data1\foreground.jpg');
mask = imread('data\Poisson_editing\data1\mask.jpg');
back = imread('data\Poisson_editing\data1\background.jpeg');
final_image = Poisson_blending(fore,back,mask);
imwrite(final_image,'blending_result\data1.jpg');
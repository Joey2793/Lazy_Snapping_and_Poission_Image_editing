close all; clear all;clc;
addpath('./GCMex');
im_in = imread('data/Lazysnapping_data/dog.PNG');

gray_stroke = imread('data/Lazysnapping_data/dog stroke.png');

%ball backcolor 29  
% rgb = double(im_in);
% [H,W,channel] = size(rgb);
% %from row than to col
% rgbvector = reshape(rgb,[H*W,3]);
% gray = rgb2gray(gray_stroke);
% [prob_f,prob_b] = DataCost(rgbvector,gray);
% prob_f = reshape(prob_f,[H W]);
% prob_b = reshape(prob_b, [H W]);
% imwrite(prob_f,'graphcut_result/dog_f.png');
% imwrite(prob_b,'graphcut_result/dog_b.png');

% [X1,map1]=imread('data/Lazysnapping_data/dance.PNG');
% [X2,map2]=imread('data/Lazysnapping_data/dance stroke 1.png');
% [X3,map3]=imread('graphcut_result/dance_label1.png');
% [X4,map4]=imread('graphcut_result/dance_fore1.png');
% subplot(1,4,1), imshow(X1,map1);title('Original');
% subplot(1,4,2), imshow(X2,map2);title('Stroke');
% subplot(1,4,3), imshow(X3,map3);title('Label');
% subplot(1,4,4), imshow(X4,map4);title('Extract');

[img_label,masked_img] = Graph_cut(im_in,gray_stroke,76,31,5);

imwrite(img_label,'graphcut_result/dog_label4.png');
imwrite(masked_img,'graphcut_result/dog_fore4.png');
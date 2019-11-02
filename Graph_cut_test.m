close all; clear all;clc;
addpath('./GCMex');
im_in = imread('data/Lazysnapping_data/dog.PNG');

gray_stroke = imread('data/Lazysnapping_data/dog stroke.png');



[img_label,masked_img] = Graph_cut(im_in,gray_stroke,76,31,5);

imwrite(img_label,'graphcut_result/dog_label4.png');
imwrite(masked_img,'graphcut_result/dog_fore4.png');

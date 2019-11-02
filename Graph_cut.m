function [img_label,masked_img] = Graph_cut(im_in,gray_stroke,color1,color2,k)
if nargin < 3, color1 = 76,color2 = 31, k = 3; end
%rgb = im2double(im_in);
rgb = double(im_in);
[H,W,channel] = size(rgb);
%from row than to col
rgbvector = reshape(rgb,[H*W,3]);
gray = rgb2gray(gray_stroke);
% 76 red
%class = gray == color1;
%classvector = reshape(class,[H*W,1]);
classvector = zeros([H*W,1]);

pairwise1 = SmoothCost(rgbvector,H,W);
%ball backcolor 29  
[prob_f,prob_b] = DataCost(rgbvector,gray,color1,color2,k);
%UNARY = cat(3,prob_f,prob_b);
%una = reshape(UNARY,[H*W,2]);
%original 1,0;0,1
una = [transpose(prob_f);transpose(prob_b)];
labelcost = [0,1;1,0];

[labels E Eafter] = GCMex(double(classvector), single(una), pairwise1, single(labelcost),0);
img_label =  reshape(labels,[H,W]);
%imshow(img_label);
masked_img = im_in;
masked_img(repmat(~img_label,[1,1,3])) = 0;
%imshow(masked_img);
end










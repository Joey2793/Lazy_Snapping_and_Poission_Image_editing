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







%----------smoothcost----------------%
% pairwise1 = sparse(H*W,H*W);
% for row = 0:H-1
%   for col = 0:W-1
%     pixel = 1+ row*W + col;
%     %from up to down
%     if row+1 < H 
%         w_dif =exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+col+(row+1)*W,:))/sigma)^2));
%         pairwise1(pixel, 1+col+(row+1)*W) = w_dif; 
%     end
%     %from down to up
%     if row-1 >= 0
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+col+(row-1)*W,:))/sigma)^2));
%         pairwise1(pixel, 1+col+(row-1)*W) = w_dif; end 
%     %from left to right
%     if col+1 < W
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+(col+1)+row*W,:))/sigma)^2));
%         pairwise1(pixel, 1+(col+1)+row*W) = w_dif; end
%     %from right to left
%     if col-1 >= 0
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+(col-1)+row*W,:))/sigma)^2));
%         pairwise1(pixel, 1+(col-1)+row*W) = w_dif; end 
%   end
% end

%figure,imshow(rgb)
%figure,imshow(gray)








%---------------data cost function--------------
% function [prob_f,prob_b] = DataCost(rgbvector,gray)
% %[row,col,channel] = size(rgb);
% %from row than to col
% %rgbvector = reshape(rgb,[row*col,3]);
% %blue 31: back      red 76:fore
% %rgbv = double(rgbvector);
% 
% index = find(gray == 76);
% index1 = find(gray == 31);
% 
% 
% fore_sample = rgbvector(index,:);
% 
% back_sample = rgbvector(index1,:);
% 
% gmf = fitgmdist(fore_sample, 3);
% gmb = fitgmdist(back_sample, 3);
% %wf = gmf.ComponentProportion;
% %wb = gmb.ComponentProportion;
% prob_f = pdf(gmf,rgbvector);
% prob_b = pdf(gmb,rgbvector);
% %prob_f = posterior(gmf,rgbvector)*transpose(wf);
% %prob_b = posterior(gmb,rgbvector)*transpose(wb);
% 
% end
% 
% 
% 
% 

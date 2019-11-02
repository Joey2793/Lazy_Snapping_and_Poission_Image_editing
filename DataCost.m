function [prob_F,prob_B] = DataCost(rgbvector,gray,color1,color2,k)
if nargin < 3, color1 = 76;color2 = 31,k = 3; end
%[row,col,channel] = size(rgb);
%from row than to col
%rgbvector = reshape(rgb,[row*col,3]);
%blue 31: back      red 76:fore
%rgbv = double(rgbvector);

index = find(gray == color1);
%in tableball back color  = 29
index1 = find(gray == color2);


fore_sample = rgbvector(index,:);

back_sample = rgbvector(index1,:);
%row need to be more than columns
gmf = fitgmdist(fore_sample, k);
gmb = fitgmdist(back_sample, k);
%wf = gmf.ComponentProportion;
%wb = gmb.ComponentProportion;
prob_f = pdf(gmf,rgbvector);
prob_b = pdf(gmb,rgbvector);
%prob_f = posterior(gmf,rgbvector)*transpose(wf);
%prob_b = posterior(gmb,rgbvector)*transpose(wb);
prob_F = prob_f./(prob_f+prob_b);
prob_B = prob_b./(prob_f+prob_b);
end




function pairwise1 = SmoothCost(rgbvector,H,W,sigma )
if nargin < 4, sigma = 1; end
pairwise1 = sparse(H*W,H*W);
% for row = 0:H-1
%   for col = 0:W-1
%     pixel = 1+ row*W + col;
%     %from up to down
%     if row+1 < H 
%         w_dif =exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+col+(row+1)*H,:))/sigma)^2));
%         pairwise1(pixel, 1+col+(row+1)*H) = w_dif; 
%     end
%     %from down to up
%     if row-1 >= 0
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+col+(row-1)*H,:))/sigma)^2));
%         pairwise1(pixel, 1+col+(row-1)*H) = w_dif; end 
%     % to down
%     if col+1 < W
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+(col+1)+row*W,:))/sigma)^2));
%         pairwise1(pixel, 1+(col+1)+row*W) = w_dif; end
%     %to up
%     if col-1 >= 0
%         w_dif = exp(-1/2*((norm(rgbvector(pixel,:)-rgbvector(1+(col-1)+row*W,:))/sigma)^2));
%         pairwise1(pixel, 1+(col-1)+row*W) = w_dif; end 
%   end
% end
for N = 1:H*W
    reminder = rem(N,H);
    result = fix(N/H);
    if reminder ~= 0
        w_dif = exp(-1/2*((norm(rgbvector(N,:)-rgbvector(N+1,:))/sigma)^2));
        pairwise1(N, N+1) = w_dif; end 
    if reminder ~= 1
        w_dif = exp(-1/2*((norm(rgbvector(N,:)-rgbvector(N-1,:))/sigma)^2));
        pairwise1(N, N-1) = w_dif; end
    if result < W-1
        w_dif = exp(-1/2*((norm(rgbvector(N,:)-rgbvector(reminder+ (result+1)*H,:))/sigma)^2));
        pairwise1(N, reminder+ (result+1)*H) = w_dif; end
    if result ~= 0 
        if result ==1 & reminder == 0
            continue
        else
            w_dif = exp(-1/2*((norm(rgbvector(N,:)-rgbvector(reminder+ (result-1)*H,:))/sigma)^2));
            pairwise1(N, reminder+ (result-1)*H) = w_dif; end
end
end
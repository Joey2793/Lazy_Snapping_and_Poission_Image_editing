function pairwise1 = SmoothCost(rgbvector,H,W,sigma )
if nargin < 4, sigma = 1; end
pairwise1 = sparse(H*W,H*W);


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

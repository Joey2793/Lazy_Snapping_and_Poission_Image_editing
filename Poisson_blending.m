function final_image = Poisson_blending(fore,back,mask)
%data processing
[H,W,channel] = size(fore);
forevector = double(reshape(fore,[H*W,3]));
back1 = imresize(back,[H W]);
backvector = reshape(back1,[H*W,3]);
SE = strel('square',3);
mask1 = mask > 0;
mask_dilation = imdilate(mask1,SE);
maskvector = reshape(mask_dilation,[H*W,1]);


%----construct Ax = b----
A = sparse(H*W,H*W);
br = zeros(H*W,1);
bg = zeros(H*W,1);
bb = zeros(H*W,1);
for N=1:H*W
    
    if maskvector(N) == 0
        A(N,N) = 1; 
        br(N) = backvector(N,1);
        bg(N) = backvector(N,2);
        bb(N) = backvector(N,3);
    end
    if maskvector(N) == 1
        reminder = rem(N,H);
        result = fix(N/H);
        A(N,N) = 4;
        A(N,N+1) =-1;
        A(N,N-1) = -1;
        A(N,reminder+(result-1)*H) = -1;
        A(N,reminder+(result+1)*H) = -1;
        br(N) = 4*forevector(N,1)-forevector(N+1,1)-forevector(N-1,1)-forevector(reminder+(result-1)*H,1)-forevector(reminder+(result+1)*H,1);
        bg(N) = 4*forevector(N,2)-forevector(N+1,2)-forevector(N-1,2) ...
        -forevector(reminder+(result-1)*H,2)-forevector(reminder+(result+1)*H,2);
        bb(N) = 4*forevector(N,3)-forevector(N+1,3)-forevector(N-1,3) ...
        -forevector(reminder+(result-1)*H,3)-forevector(reminder+(result+1)*H,3);
    end
end
xr = lsqminnorm(A,br);
xg = lsqminnorm(A,bg);
xb = lsqminnorm(A,bb);
final_r = reshape(xr,[H,W]);
final_g = reshape(xg,[H,W]);
final_b = reshape(xb,[H,W]);
final_img = cat(3,final_r,final_g,final_b);
final_image = uint8(final_img);
imshow(final_image);






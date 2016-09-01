function [L,Ln] = upmdl(L,img,or,Bin,alpha,pct)       % L is llr of previous frame

%% new liklihood model
[I,Ao,Ab,At] = sarea(img,or,Bin);                      % Search Area & Quantize
[nL,nLn]     = llr(I,Ao,Ab,Bin);                       % L is llr of present frame
%% select pct percent of object seeds randomly
sd  = find(nL ~= 0);                                   % object seeds (in linear indexing format)
idx = randperm(size(sd,1))';                           % distribute object seeds idx randomly
idx = idx(1:ceil(pct*size(sd,1)),1);                   % select some of object seeds idx for updating
%% fuse current liklihood with previous liklihood
for i = 1:size(idx,1)                                  % use selected seeds to update object
L(sd(idx)) = (1-alpha)*L(sd(idx)) + alpha*nL(sd(idx)); % new liklihood
end
Ln   = (L-min(L(:))) / (max(L(:))-min(L(:)));          % normalize

end

 
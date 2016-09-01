function [I,Ao,Ab,At] = sarea(img,or,Bin)

%% compute search(background) area
d     = ceil( (or(3)+or(4)) * (0.25) * (sqrt(2)-1) );  % Delta
br(1) = or(1) - d;                                     % Left
br(2) = or(2) - d;                                     % Up
br(3) = or(3) + 2*d;                                   % Width
br(4) = or(4) + 2*d;                                   % Height
%% keep rectangle in image (prevent error)
if br(1) < 1; br(1) = 1; end                                
if br(2) < 1; br(2) = 1; end
if br(1) > size(img,2)-br(3); br(1) = size(img,2)-br(3); end
if br(2) > size(img,1)-br(4); br(2) = size(img,1)-br(4); end
%% logical indexing
Ao    = zeros(size(img,1),size(img,2));
At    = zeros(size(img,1),size(img,2));
Ao(or(2):or(2) + or(4),or(1):or(1) + or(3)) = 1;       % object area
At(br(2):br(2) + br(4),br(1):br(1) + br(3)) = 1;       % total object + background area
Ab    = At - Ao;                                       % background area
%% quantization
Q     = 256/Bin;                                       % Quantization Step
I     = (floor(double(img)/Q))+1;                      % Indexed Image [1~Bin]

end

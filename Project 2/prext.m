function or = prext(or,mp)

%% compute search(background) area
d     = ceil( (or(3)+or(4)) * (0.25) * (sqrt(2)-1) );  % Delta
br(1) = or(1) - d;                                     % Left
br(2) = or(2) - d;                                     % Up
br(3) = or(3) + 2*d;                                   % Width
br(4) = or(4) + 2*d;                                   % Height
%% keep rectangle in image (prevent error)
if br(1) < 1; br(1) = 1; end                                
if br(2) < 1; br(2) = 1; end
if br(1) > size(mp,2)-br(3); br(1) = size(mp,2)-br(3); end
if br(2) > size(mp,1)-br(4); br(2) = size(mp,1)-br(4); end
%% compute object area
or(1) = br(1) + d;                                     % Left
or(2) = br(2) + d;                                     % Up

end
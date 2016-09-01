function [L,Ln] = llr(I,Ao,Ab,Bin)

%% prepare quantized image
R     = I(:,:,1);                                     % red
G     = I(:,:,2);                                     % green
B     = I(:,:,3);                                     % blue
%% compute object & background histograms
io    = find(Ao == 1);                                % object area (linear indexing)
Ho    = zeros(Bin,Bin,Bin);                           % construct histogram of object area
for i = 1:size(io,1)
Ho(R(io(i)),G(io(i)),B(io(i))) = Ho(R(io(i)),G(io(i)),B(io(i))) + 1;
end
ib    = find(Ab == 1);                                % background area
Hb    = zeros(Bin,Bin,Bin);                           % construct histogram of background area
for i = 1:size(ib,1)
Hb(R(ib(i)),G(ib(i)),B(ib(i))) = Hb(R(ib(i)),G(ib(i)),B(ib(i))) + 1;
end
%% compute log liklihood ratio
Ho(Ho == 0) = 1;                                      % Epsilon
Hb(Hb == 0) = 1;
L     = log(Ho./Hb);                                  % Log - Liklihood Ratio
L     = L.*(L > 0);                                   % Remove Negative (background) Values
Ln    = (L - min(L(:)))/(max(L(:)) - min(L(:)));      % Normalize

end

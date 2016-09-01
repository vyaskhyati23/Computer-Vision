function mp = map(I,L,At)

%% prepare quantized image
R     = I(:,:,1);                                     % red
G     = I(:,:,2);                                     % green
B     = I(:,:,3);                                     % blue
%% log liklihood map
mp    = zeros(size(I(:,:,1)));            % Feature Map Images
it    = find(At == 1);                    % Total Area in Search location (linear indexing)
for i = 1:size(it,1)
mp(it(i)) = L(R(it(i)),G(it(i)),B(it(i)));
end

end

 
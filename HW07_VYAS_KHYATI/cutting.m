% @author: Khyati K.Vyas
function cutting(fn)

image=imread(fn);
imshow(fn);
title('Binary Image');

sobel_vt=[1 0 -1;2 0 -2;1 0 -1];
filter_vt=imfilter(image,sobel_vt,'same','repl');
imshow(filter_vt.*2);

image(filter_vt(filter_vt>0))=[255 0 255];

% [rows ,cols]=find(filter_vt>0);
% for i=1:size(rows)
%         image(rows(i),cols(i),1)=255;
%         image(rows(i),cols(i),2)=0;
%         image(rows(i),cols(i),3)=255;
%         
% end

imshow(image);
end
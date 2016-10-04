% @author: Khyati K.Vyas
function [decesion]=slantedLabelDetector(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECKER FUNCTION TO DETECT IF LABEL IS %
% SLANTED OR NOT                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
addpath('../TEST_IMAGES');

%READ THE IMAGE AND A TEMPLATE WHICH IS AN IDEAL IMAGE OF A BOTTLE.
im_label=imread(fn);
%im_label=imread('image084.jpg');
template   =imread('template.jpg');


%CROPPING THE PART OF THE BOTTLE WHICH CONTAINS ONLY THE BOTTLE.I CALCULATED
%THE APPROXIMATE LOCATION OF THE CAP AND GAVE THE FOLLOWING COORDIANTES AND
%WIDTH AND HEIGHT.
im_label=imcrop(im_label,[115 0.5 130 800]);
%imshow(im_label);

%I CONVERTED THE IMAGE AND TEMPLATE INTO BINARY USING ONLY THE RED PLANE.SINCE , THE
%LABEL CONSISTS OF MAINLY OF RED COLOR. THIS WILL GIVE ME THE LABEL IN
%WHITE AND THE OTHER PARTS OF THE BOTTLE IN BLACK.
im_label=im2bw(im_label(:,:,1));
template   = im2bw(template(:,:,1));


%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
se = strel('square',6)
im_label=imerode(im_label,se);


%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
se = strel('square',8)
template=imopen (template,se);
template=imfill(template,'holes');


%THIS CALCUATES THE CROSS CORRELATION BETWEEN THE TEMPLATE WHICH IS THE
%IDEAL IMAGE OF THE BOTTLE WITH THE INPUT IMAGE AND GIVES A VALUE BETWEEN
%-1 AND 1 FOR EACH PIXEL. WE CALCULATE THE MAXIMUM OF THESE VALUES. 
c = normxcorr2(template,im_label);
max_value=max(c(:));

%disp(max_value);


%AFTER EXPERIMENTAL RESULTS, FOUND A THRESHOLD OF 0.7. IF MA_VALUE IS LESS
%THAN 0.7, THE BOTTLE HAS A LOW MATCH WITH THE IDEAL TEMPLATE AND HENCE
%MUST BE REJECTED. OR IT GOES ON TO DETECT THE SHAPE OF THE BOTTLE.
if(max_value<0.7)
    %disp('BOTTLE HAS A SLANTED LABEL!! REJECT BOTTLE!!')
    decesion=false;
    return;
else
    %  disp('GO AHEAD');
    decesion=true;
    return;


end

end

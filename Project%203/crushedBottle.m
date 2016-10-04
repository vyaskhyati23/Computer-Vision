% @author: Khyati K.Vyas
function [decesion]=crushedBottle(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECKER FUNCTION TO DETECT IF BOTTLE IS %
% DEFORMED.                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
addpath('../TEST_IMAGES');

%READ THE IMAGE AND A TEMPLATE WHICH IS AN IDEAL IMAGE OF A BOTTLE.
im_label=imread(fn);
%im_label=imread('image063.jpg');
template   =imread('template.jpg');
template1   =imread('template1.jpg');
template2  =imread('template2.jpg');
template3   =imread('template3.jpg');



%CROPPING THE PART OF THE BOTTLE WHICH CONTAINS ONLY THE BOTTLE.I CALCULATED
%THE APPROXIMATE LOCATION OF THE CAP AND GAVE THE FOLLOWING COORDIANTES AND
%WIDTH AND HEIGHT.
im_label=imcrop(im_label,[115 0.5 130 800]);
%imshow(im_label);

%I CONVERTED THE IMAGE AND TEMPLATE INTO BINARY USING ONLY THE RED PLANE.SINCE , THE
%LABEL CONSISTS OF MAINLY OF RED COLOR. THIS WILL GIVE ME THE LABEL IN
%WHITE AND THE OTHER PARTS OF THE BOTTLE IN BLACK.
im_label=im2bw(im_label(:,:,2));
template   = im2bw(template(:,:,2));
template1   = im2bw(template1(:,:,2));
template2   = im2bw(template2(:,:,2));
template3   = im2bw(template3(:,:,2));

% figure;imshow(im_label);
% figure;imshow(template);
% figure;imshow(template1);
% figure;imshow(template2);
% figure;imshow(template3);

%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
se = strel('square',6)
im_label=imerode(im_label,se);


%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
% se = strel('square',8)
% template=imopen (template,se);
% template=imfill(template,'holes');


%THIS CALCUATES THE CROSS CORRELATION BETWEEN THE TEMPLATE WHICH IS THE
%IDEAL IMAGE OF THE BOTTLE WITH THE INPUT IMAGE AND GIVES A VALUE BETWEEN
%-1 AND 1 FOR EACH PIXEL. WE CALCULATE THE MAXIMUM OF THESE VALUES. 
c = normxcorr2(template,im_label);
max_value=max(c(:));

%template1.jpg
c1 = normxcorr2(template1,im_label);
max_value1=max(c1(:));

%template2.jpg
c2 = normxcorr2(template2,im_label);
max_value2=max(c2(:));

%template3.jpg
c3 = normxcorr2(template3,im_label);
max_value3=max(c3(:));


%disp(max_value);disp(max_value1);disp(max_value2);disp(max_value3);

%CALCULATES THE MAXIMUM OF ALL THE 4 CROSS CORRELATION VALUES.
maximum=max([max_value,max_value1,max_value2,max_value3]);


%AFTER EXPERIMENTAL RESULTS, FOUND A THRESHOLD OF 0.65. IF MAx VALUE IS LESS
%THAN 0.65, THE BOTTLE HAS A LOW MATCH WITH THE IDEAL TEMPLATE AND HENCE
%MUST BE REJECTED. OR IT GOES ON TO DETECT THE SHAPE OF THE BOTTLE.
if(maximum<0.65)
    %disp('BOTTLE IS DEFORMED!! REJECT BOTTLE!!');
   decesion=false;
    return;
else
    disp('PERFECT BOTTLE!!');
    decesion=true;
    return;
    
end

end
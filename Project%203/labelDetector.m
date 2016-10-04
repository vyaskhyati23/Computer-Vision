% @author: Khyati K.Vyas
function [decesion]=labelDetector(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECKER FUNCTION TO DETECT IF LABEL IS %
% PRESENT OR NOT                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
addpath('../TEST_IMAGES');

%READ THE IMAGE
%im_label=imread('image062.jpg');
im_label=imread(fn);


%CROPPING THE PART OF THE BOTTLE WHICH CONTAINS ONLY THE LABE;.I CALCULATED
%THE APPROXIMATE LOCATION OF THE LABEL AND GAVE THE FOLLOWING COORDIANTES AND
%WIDTH AND HEIGHT.
im_label=imcrop(im_label,[115 0.5 130 800]);
%imshow(im_label);

%I CONVERTED THE IMAGE INTO BINARY USING ONLY THE RED PLANE.SINCE , THE
%LABEL CONSISTS OF MAINLY OF RED COLOR. THIS WILL GIVE ME THE LABEL IN
%WHITE AND THE OTHER PARTS OF THE BOTTLE IN BLACK.
im_label=im2bw(im_label(:,:,1));


%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
se = strel('disk',6)
im_label=imerode(im_label,se);

%THIS FINDS THE NUMBER OF CONNECTED REGIONS IN THE IMAGE.
bw=bwconncomp(im_label);
% disp(bw);
% imshow(im_label);

%NOW IF NO LABEL IS MISSING, THAT IS IF THE IMAGE CONTAINS ONLT THE BOTTLE
%WITHOUT A LABEL AT ALL,IT WILL HAVE ONLY A SINGLE CONNECTED COMPONENT,WHICH 
%IS THE ENTIRE BOTTLE ITSELF.
%IF IT DOES NOT, THAT MEANS THERE IS A LABEL PRESENT. THEREFORE,MORE
%THAN ONE CONNECTED COMPONENTS, THAT IS ABOVE AND BELOW THE LABEL WILL BE
%DETECTED. THUS IT GOES AHEAD TO CHECK IF THE LABEL IS A WHITE LABEL OR AN
%IDEAL LABEL.

if(bw.NumObjects == 1)
    %disp('LABEL NOT FOUND!! REJECT BOTTLE!');
    decesion=false;
    return;
else
    %disp('GO AHEAD!');
    decesion=true;
    return;

end
end


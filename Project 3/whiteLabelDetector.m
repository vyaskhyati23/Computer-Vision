% @author: Khyati K.Vyas
function [decesion]=whiteLabelDetector(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECKER FUNCTION TO DETECT IF LABEL IS %
% WITHOUT ANY PRINT OR NOT               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
addpath('../TEST_IMAGES');
%READS THE IMAGE.
im_label=imread(fn);
%im_label=imread('image123.jpg');

%CROPPING THE PART OF THE BOTTLE WHICH CONTAINS ONLY THE LABEL.I CALCULATED
%THE APPROXIMATE LOCATION OF THE LABEL AND GAVE THE FOLLOWING COORDIANTES AND
%WIDTH AND HEIGHT.
im_label=imcrop(im_label,[120 186 101 81]);


%I CONVERTED THE IMAGE INTO BINARY USING ONLY THE GREEN PLANE.SINCE , THE
%LABEL CONSISTS OF MAINLY OF RED COLOR. THIS WILL GIVE ME THE LABEL IN
%WHITE AND THE OTHER PARTS OF THE BOTTLE IN BLACK.ORPHLOGICAL OPERATIONS
%TO GET RID OF EXTRA UNWANTEDREGIONS.
im_label=im2bw(im_label(:,:,2));
se=strel('square',5);
im_label=imerode(im_label,se);
bw=bwconncomp(im_label);


%IF THE NUMBER OF CONNECTED COMPONENTS IS LESS THAN 3, THEN IT MUST BE A
%WHITE LABEL.
if(bw.NumObjects < 3)
    %disp('WHITE LABEL FOUND!! REJECT BOTTLE!');
    decesion=false;
    return;
else
    % disp('GO AHEAD!');
    decesion=true;
    return;


   
end 
end
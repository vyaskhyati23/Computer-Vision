% @author: Khyati K.Vyas
function [decesion]=levelDetector(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECKER FUNCTION TO DETECT IF LEVEL IS %
% PERFECT OR NOT                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
addpath('../TEST_IMAGES');

%READ THE IMAGE.
im_level=imread(fn);
%im_level=imread('image001.jpg');


%CROPPING THE PART OF THE BOTTLE WHICH CONTAINS ONLY THE COLA.I CALCULATED
%THE APPROXIMATE LOCATION OF THE BOTTLE AND GAVE THE FOLLOWING COORDIANTES AND
%WIDTH AND HEIGHT
im_level = imcrop(im_level,[180 91 29 78]);
%CONVERTED IMAGE INTO BINARY.
im_level=im2bw(im_level);

%%MORPHOLOGICSL EROSION TO GET RID OF STRAY DETECTED REGIONS.
se = strel('disk',5)
im_level=imerode(im_level,se);

%THIS FINDS THE NUMBER OF CONNECTED REGIONS IN THE IMAGE.
bw=bwconncomp(im_level);
%disp(bw);

%THIS FINDS , IF THE BOTTLE IS OVERFILLED, CONNECTED COMPONENTS WILL BE 0.
%IF BOTTLE IS PROPERLY FULL OR UNDER FILLED, CONNECTED OCOMPONENTS WILL BE
%1.
% TAKING COMPLEMENT OF THE BINARY IMAGE, IF THE BOTTLE IS UNDEFILLED, THE
% NUMBER OF OBJETS WILL BE 0 AND CONNECTED OBJECTS WILL BE GREATER THAN ONE
% IN CASE OF NORMALLY FILLED BOTTLE.

if(bw.NumObjects ==0)
    %disp('BOTTLE IS OVERFILLED!! REJECT BOTTLE!');
    disp('FALSE');
elseif(bw.NumObjects==1)
    im_level=imcomplement(im_level);
    bw=bwconncomp(im_level);
    disp(bw);
    if(bw.NumObjects==0)
        %disp('BOTTLE IS UNDERFILLED !! REJECT BOTTLE!');
        decesion=false;
        return;
    else
        %disp('GO AHEAD');
        decesion=true;
        return;

    end
end

end

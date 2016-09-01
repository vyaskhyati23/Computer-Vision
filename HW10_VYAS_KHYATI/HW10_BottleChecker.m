% @author: Khyati K.Vyas
function [decesion]=HW10_BottleChecker(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%
% THIS FUNCTION CALLS THE CAP CHECKER FUNCTION        %
% WHICH CALLS THE REST OF THE FUNCTION IN THIS ORDEE  %
% capChecker();                                       %
% labelDetecor();                                     %
% whiteLabelDetector();                               %
% slantedLabelDetector();                             %
% levelDetector();                                    %
% crushedBottle();                                    %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all;
addpath('../TEST_IMAGES');

%READ THE IMAGE AND 
%im=imread('image025.jpg');
im=imread(fn);

%Performing initial noise removal using Gaussian filter
fltr  = fspecial('Gauss',30,2.5);  
im  = imfilter(im, fltr,'same','repl');

%CROP PART OF THE IMAGE THAT CONTAINS THE CENTER BOTTLE.
im = imcrop(im,[103 0.5 130 800]);

%CONVERT THE IMAGE INTO BINARY. PERFORM MORPHOLOGICAL OPERATIONS TO GET RID
%OF UNWANTED REGIONS. I DO THIS SINCE I WANT TO DETECT IF THE SPACE IS
%EMPTY OR NO.IF THE SPACE IS EMPTY, IT WILL BE A COMPLETE WHITE REGION.
im=im2bw(im);
se=strel('square',10);
im=imdilate(im,se);

%FIND THE NUMBER OF CONNECTED COMPONENTS
bw=bwconncomp(im);

%IF ONLY ONE COMPONENT IS FOUND, IT MEANS THE AREA IS EMPTY. NO OTHER
%OBJECT IS PRESENT IN THAT AREA.

if(bw.NumObjects ==1)
      decesion=true;
      return;
end 
if (capChecker(fn) == 0)
    decesion=false;
      return;
elseif(labelDetector(fn)==0)
    decesion=false;
    return
elseif(whiteLabelDetector(fn)==0)
    decesion=false;
    return;
elseif(slantedLabelDetector(fn)==0)
    decesion=false;
    return;
elseif(levelDetector(fn)==0)
    decesion=false;
    return;
elseif(crushedBottle(fn)==0)
    decesion=false;
    return;
else
    decesion=true;
    return;
end

end
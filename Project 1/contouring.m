% @author: Khyati K.Vyas
function contouring()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This fucntion  performs active contouring to convert    %
%   the image into a binary image with foreground pixels    %
%   as white and background pixels as black.Writes the      %
%   final image to a new file to be used for the crop_image %
%   function.                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
addpath('../Images');

%read the image from edge_Detection() function.
im = imread('silhouette.jpg');


% Creating a mask of zeros equal to the size of the image.
% This is the initial contour.
mask = zeros(size(im));
mask(25:end-25,25:end-25) = 1;

% binaryImage is a mask of the detected objects.
%Iterations were adjusted from 100,300,500,1000,2500
%1000 gave appropriate results.
iterations =1000;
binaryImage = activecontour(im, mask, iterations);

% Show detected objects
figure(3);
imshow(binaryImage);
title('Detected objects');
%writting the image in a new file to be used in the crop_image()function.
imwrite(binaryImage,'DetectedObject.jpg');

%performing morphological dilation to fill an left out gaps while edges are
%detected
%After trial and error,structural element used is a square of size 10.
se=strel('square',10);
im=imdilate(binaryImage,se);
%writting the image in a new file to be used in the crop_image()function.
imwrite(im,'SegmentedObject.jpg');



end
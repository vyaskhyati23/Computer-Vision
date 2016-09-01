% @author: Khyati K.Vyas
function cropping_Image(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This fucntion crops the image containng only the part   %
%   of the image that is occupied by the currency.          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
addpath('../Images');

%reading the original image()
image=imread(fn);
%image=imread('20DB.jpg');
%reading the image formed in the contouring() function.
im=imread('DetectedObject.jpg');

%performing morphological erosion to handle unwanted edges detected.
%After trial and error,structural element used is a square of size 10.
se=strel('square',10);
im=imerode(im,se);

%cropping the image based on the segmented object .Cropped image will
%contain only the part of the image that we need.
%reference : Matlab documentation
Sdata=regionprops(im,'BoundingBox');
Img=imcrop( image,Sdata(1).BoundingBox);
imshow(Img);
%writting image in a new file to be used in the histogram() function.
imwrite(Img,'cropped.jpg');

end
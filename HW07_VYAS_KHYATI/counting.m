% @author: Khyati K.Vyas
function counting(fn)
addpath('../Test_IMAGES');


INTERACTIVE = 0;

%read the file
im_rgb = imread(fn);

%Allows to save or load the points chosed by the user.
if  INTERACTIVE
    
    %x and y coordinates of the flesh of the mellon
    fprintf('SELECT FLESH (ORANGE) PIXELS, THEN HIT ENTER \n');
    [x_orange, y_orange] = ginput();
    
    %x and y coordinates of the skin of the mellon
    fprintf('SELECT SKIN (GREEN) PIXELS, THEN HIT ENTER \n');
    [x_green, y_green] = ginput();
    
    %x and y coordinates of the cutting board the mellon is placed on
    fprintf('SELECT CUTTING BOARD (WHITE) PIXELS, THEN HIT ENTER \n ');
    [x_white, y_white] = ginput();
    
    
    save my_temporary_data1246;
else
    %loads x and y coordinates of the flesh , skin of the mellon and the
    %cutting board.
    load my_temporary_data1246 x_orange y_orange x_green y_green x_white y_white;
    
end

%Converting from rgb to lab colorspace.
im_lab      = rgb2lab(im_rgb );
imshow(im_lab);
axis image;
title('Image in CIElab colorspace');
pause(1);

%Extracting the a and b plane from lab colorspace.
im_a      = im_lab(:,:,2);
im_b      = im_lab(:,:,3);

%sub2ind gives the equivalent index corresponding to each
%row and column pair for the selected points in the mellon flesh.
orange_indices      = sub2ind( size(im_a), round(y_orange), round(x_orange) );
% gives the matrix of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the mellon flesh in the a
% plane and b plane.
orange_a  = im_a( orange_indices );
orange_b  = im_b( orange_indices );


%sub2ind the equivalent index corresponding to each
%row and column pair for the selected points in the mellon skin.
green_indices      = sub2ind( size(im_a), round(y_green), round(x_green) );
%gives the matrix of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the mellon skin in the a
% plane and b plane .
green_a  = im_a( green_indices );
green_b  = im_b( green_indices );


%sub2ind gives the  equivalent index corresponding to each
%row and column pair for the selected points in the background.
white_indices      = sub2ind( size(im_a), round(y_white), round(x_white) );
% gives the vector of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the cutting board  in the a
% plane and b plane .
white_a  = im_a( white_indices );
white_b       = im_b( white_indices );

% This forms a matrix of the a and b plane  of the mellon flesh
% after getting the indices of each selected point.
orange_ab       = [ orange_a orange_b ];


% This forms a matrix of the a and b plane  of the mellon skin.
%   after getting the indices of each selected point.

green_ab       = [ green_a green_b ];


% This forms a matrix of the a and b plane  of the cutting board.
%after getting the indices of each selected point.

white_ab       = [ white_a white_b ];

% This forms a matrix by taking the x and columns from each matrix
% formed above to create a new composite matrix which contains the indices
% from each plane.
im_ab       = [ im_a(:) im_b(:) ];

% mahalanobis distance is calculated for the flesh , skin and cutting board
% using the matrix recived from sub2ind.
mahal_orange   = ( mahal( im_ab,orange_ab));
mahal_green    = ( mahal( im_ab,green_ab ));
mahal_white    = ( mahal( im_ab,white_ab ));


%   After calculating the mahlanobis distance for skin, flesh and cutting
%   boards using the selected pixels, we can now clasify the rest of the points
%   based on these points.Therfore,to find the edges of the mellon, I made
%   a class using 2 models, one that calculated the pixels that have a mahal
%   distance to the cutting board less than the flesh and the other
%   calculated the distance to the skin less than the mahal distance to the
%   cutting board.

classification     = mahal_white<mahal_orange & mahal_green<mahal_white ;

%This will reshape the final image depending on the elements in the new
%classified image.
classified   = reshape( classification, size(im_a,1), size(im_a,2) );


% display the image.
imshow( classified);
axis image;
title('IMAGE USING MAHALANOBIS DISTANCE.')
pause();

%we use the bwareaopen function to remove the noise that remains in the
%image. i.e after classification certain pixels have mahal distance that
%are closer to the skin, when they actually do not lie on the edge.This is
%due to the fact that the fruit skin contains an off-white looking mesh on
%the outr laer which has color similar to some parts of the cutting board.
%Therfore, all the objects in the binary image with pixels less than 80
%will be removed from the image.
classified=bwareaopen(classified,80);
imshow(classified);
axis image;
title('After using bwareaopen');
pause(1);

%creating the structural element.
se=strel('square',3);

% disp(se);
%using dilation on the image will increase the size of the pixels.
b=imdilate(classified,se);
imshow(b);
axis image;
title('After Dilation');
pause();

%using erosion on the image will increase the size of the pixels.
b=imerode(b,se);
imshow(b);
axis image;
title('After Erosion');
pause();

%using bwconcomp, we get all the connected parts in the image.Thus this
%will give us the size of the image and the number of objects in the image
%and the dimension of each individual component.
count=bwconncomp(b);
melons=count.NumObjects;
disp('The number of melons in the image are:');
disp(melons);



%saves the image formed after finding the connected components in the jpeg
%format.
imwrite(b,'binary_image.jpg');

%creating the prewitt filter to detect the edges.
prewitt_vt=[1 0 -1;1 0 -1;1 0 -1];
filter_vt=imfilter(b,prewitt_vt,'same','repl');
%to display the edges with higher constrast.
imshow(filter_vt.*2);
pause(1);

%im_rgb(filter_vt(filter_vt>0))=[255 0 255];

%forms a vector with all the x and y cordinates where the edge is
%detected.find helps in finding all the nonzero elements in the
%image.Therefore, we are looking for only the pixels that are white. since
%in my binary image, white shows the edge.

[x ,y]=find(filter_vt>0);

%Magenta = red + blue;
%run a for loop over the original mellon image and set all the x and y
%coordiantes in the red and blue plane to 255 where the edge is detected
%i.e. the pixel value is white or 1. And set the x and y coordinates in the
%green plane to 0.
for i=1:size(x)
    im_rgb(x(i),y(i),1)=255;
    im_rgb(x(i),y(i),2)=0;
    im_rgb(x(i),y(i),3)=255;
    
end

%Display the mellons image with the edge at which the laser will cut to
%seperate the flesh and skin.
imshow(im_rgb);
title('Laser Cutting Edge');



end
% @author: Khyati K.Vyas
function HW06_VYAS_KHYATI_FIND_GRAFFITI()
%Reference : Thoma Kinsman.
%function DEMO__GET_RaPBERY_COLORS_releaed( fn )

addpath('../TEST_IMAGES');
%allows user to interact to choose points.
INTERACTIVE = 0;

%Read image and display with a pause for 3 seconds.

%im_rgb = imread('IMG_Graffiti_249.jpg' );
im_rgb = imread('IMG_Graffiti_301.jpg' );
imshow(im_rgb);
title('Original image');
pause(3);

%Allows to save or load the points chosed by the user.
if  INTERACTIVE
    
    fprintf('SELECT RaPBERRIES AND HIT ENTER');
    [x_fg, y_fg] = ginput();
    
    
    fprintf('SELECT BACKGROUND LEAVES AND HIT ENTER ');
    [x_bg, y_bg] = ginput();
    
    save my_temporary_data_graf1;
else
    %collects the x y b of foreground and background only.
    load my_temporary_data_graf1 x_fg y_fg x_bg y_bg ;
end

%Converting from rgb to lab colorspace.
im_lab      = rgb2lab(im_rgb );
imshow(im_lab);
title('Image in CIElab colorspace');
pause(3);

%Extracting the a and b plane from lab colorspace.
%I worked with all the 3 planes and found a and b
%gave the best results.
im_a           = im_lab(:,:,2);
im_b           = im_lab(:,:,3);

% im_a      = im_lab(:,:,2);
% im_b      = im_lab(:,:,1);

%sub2ind gives b of equivalent index corresponding to each
%row and column pair for the selected points in the foreground.

fg_indices      = sub2ind( size(im_a), round(y_fg), round(x_fg) );

%gives the b of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the foreground in the a
% plane and b plane.

fg_a       = im_a( fg_indices );
fg_b       = im_b( fg_indices );

%sub2ind gives b of equivalent index corresponding to each
%row and column pair for the selected points in the background.

bg_indices      = sub2ind( size(im_a), round(y_bg), round(x_bg) );
%gives the b of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the background in the a
% plane and b plane .
bg_a       = im_a( bg_indices );
bg_b       = im_b( bg_indices );

% This forms a matrix of the a and b plane  of the foreground object
%after getting the indices of each selected point.
fg_ab       = [ fg_a fg_b ];


% This forms a matrix of the a and b plane  of the background object.
%after getting the indices of each selected point.

bg_ab       = [ bg_a bg_b ];

% This forms a matrix by taking the rows and columns from each matrix
% formed above to create a new composite matrix which contains the indices
% from each plane.
im_ab       = [ im_a(:) im_b(:) ];

% mahalanobis distance is calculated for the background and the foreground
% using the matrix formed by b recived from sub2ind.
mahal_fg    = ( mahal( im_ab,fg_ab ));
mahal_bg    = ( mahal( im_ab,bg_ab ));

%   After calculating the mahlanobis distance for forgreound and background
%   using the selected pixels, we can now clasify the rest of the points
%   baed on these points.Therefore, if any pixel has a mahalanobis
%   distance to foreground less than that for the background, we clasify
%   that a a forground image.

clas_clasified     = mahal_fg< mahal_bg;
%This will reshape the final image depending on the elements in the new
%clasifies image. (clas_foreground )
clasified   = reshape( clas_clasified, size(im_a,1), size(im_a,2) );
imshow( clasified);
title('IMAGE USING MAHALANOBIS DISTANCE.')
axis image;
colormap(gray);
pause(5);

end



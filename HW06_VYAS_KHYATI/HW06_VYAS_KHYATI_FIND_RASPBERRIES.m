% @author: Khyati K.Vyas
function HW06_VYAS_KHYATI_FIND_RASPBERRIES()

%Reference : Thomas Kinsman.
%function DEMO__GET_RASPBERY_COLORS_released( fn )

addpath('../TEST_IMAGES');
%allows user to interact to choose points.
INTERACTIVE = 0;

%Read image and display with a pause for 3 seconds.
im_rgb = imread('TBK_RASPBERRIES__smr.jpg');
imshow(im_rgb);
title('Original image');
pause(3);

%Allows to save or load the points chosed by the user.
if  INTERACTIVE

    fprintf('SELECT RASPBERRIES AND HIT ENTER');
    [x_fg, y_fg] = ginput();
    
    
    fprintf('SELECT BACKGROUND LEAVES AND HIT ENTER ');
    [x_bg, y_bg] = ginput();
    
    save my_temporary_data;
else
    load my_temporary_data;
end

%Converting from rgb to lab colorspace.
im_lab      = rgb2lab(im_rgb );
imshow(im_lab);
title('Image in CIElab colorspace')
pause(3);

%Extracting the light and a plane from lab colorspace.
%I worked with all the 3 planes and found light and a
%gave the best results.

im_a       = im_lab(:,:,1);
im_light   = im_lab(:,:,2);
% imhv=im_a+im_light;
% imshow(imhv);

%sub2ind gives values of equivalent index corresponding to each
%row and column pair for the selected points in the foreground.

fg_indices  = sub2ind( size(im_a), round(y_fg), round(x_fg) );
disp(fg_indices);

%gives the values of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the foreground in the light
% plane and a plane.
fg_a            = im_a( fg_indices );
fg_light        = im_light( fg_indices );


%sub2ind gives values of equivalent index corresponding to each
%row and column pair for the selected points in the background.
bg_indices   = sub2ind( size(im_a), round(y_bg), round(x_bg) );

%gives the values of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the background in the light
% plane and a plane.
bg_a             = im_a( bg_indices );
bg_light         = im_light( bg_indices );

% This forms a matrix of the light and a plane of the foreground object 
%after getting the indices of each selected point.
fg_aLight       = [ fg_light fg_a ];  
% This forms a matrix of the light and a plane of the background object.
%after getting the indices of each selected point.
bg_aLight       = [ bg_light bg_a ];     
% This forms a matrix by taking the rows and columns from each matrix
% formed above to create a new composite matrix which contains the indices
% from each plane.
im_la       = [ im_a(:) im_light(:) ];


% mahalanobis distance is calculated for the background and the foreground
% using the matrix formed by values recived from sub2ind.

mahal_fg    = ( mahal( im_la,fg_aLight ));
mahal_bg    = ( mahal( im_la,bg_aLight ));

%   After calculating the mahlanobis distance for forgreound and background
%   using the selected pixels, we can now classify the rest of the points
%   based on these points.Therefore, if any pixel has a mahalanobis
%   distance to foreground less than that for the background, we classify
%   that as a forground image. 
%   Also, I have raised the mahalanobis distance array for the foreground by a
%   factor of 3 since the size of the raspberries is small compared to any
%   object in the background. therefore, to classify it correctly as 
%   foreground, the mahalanobis distance is multiplied by 3, which I found
%   by some trial and error.

class_foreground     = mahal_fg.^3 <mahal_bg;
%This will reshape the final image depending on the elements in the new
%classifies image. (class_foreground )
classified   = reshape(class_foreground, size(im_a,1), size(im_a,2));

% display the image and convert into gray colormap to get values in black
% and white for contrast enhancement.
imshow( classified );
title('IMAGE USING MAHALANOBIS DISTANCE');
colormap(gray);
pause(5);

end

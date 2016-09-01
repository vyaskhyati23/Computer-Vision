% @author: Khyati K.Vyas
function HW06_VYAS_KHYATI_FIND_AIRPLANE()

%Reference : Thomas Kinsman.
%function DEMO__GET_RASPBERY_COLORS_released( fn )

addpath('../TEST_IMAGES');
%allows user to interact to choose points.
INTERACTIVE = 0;

%Read image and display with a pause for 3 seconds.
fn = 'TBK_Airplane.png';
im_rgb = imread( fn );
imshow(im_rgb);
title('Original image');
pause(3);

%Used a gaussian filter over the entire image to reduce noise.
gaussian_flt=[1 2 1;2  4  2;1  2  1]/16;
removed_noise=imfilter(im_rgb,gaussian_flt ,'same' , 'repl');
%displays the image after noise is removed.Pauses for 3 seconds.
imshow( removed_noise);
title('IMAGE AFTER REMOVAL OF NOISE');
pause(3);


%Allows to save or load the points chosed by the user.
if  INTERACTIVE

    fprintf('SELECT AIRPLANE PIXELS, THEN HIT ENTER');
    [x_fg, y_fg] = ginput();
    
    
    fprintf('SELECT BACKDROP PIXELS, THEN HIT ENTER ');
    [x_bg, y_bg] = ginput();
    
    save my_temporary_data1;
else
    load my_temporary_data1;
end

%Converting from rgb to hsv colorspace.
im_hsv      = rgb2hsv(removed_noise );
imshow(im_hsv);
title('Image in HSV colorspace');
pause(3);

%Extracting the saturation and value plane from lab colorspace.
%I worked with all the 3 planes and found saturation and value
%gave the best results.

im_saturation      = im_hsv(:,:,1);
im_value           = im_hsv(:,:,2);

%sub2ind gives values of equivalent index corresponding to each
%row and column pair for the selected points in the foreground.

fg_indices      = sub2ind( size(im_saturation), round(y_fg), round(x_fg) );

%gives the values of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the foreground in the saturation
% plane and value plane.

fg_saturations  = im_saturation( fg_indices );
fg_values       = im_value( fg_indices );

%sub2ind gives values of equivalent index corresponding to each
%row and column pair for the selected points in the background.

bg_indices      = sub2ind( size(im_saturation), round(y_bg), round(x_bg) );
%gives the values of equvialent indices corresponding to the chosen
% x and y pairs for the selected points in the background in the saturation
% plane and value plane .
bg_saturations  = im_saturation( bg_indices );
bg_values       = im_value( bg_indices );

% This forms a matrix of the saturation and value plane  of the foreground object 
%after getting the indices of each selected point.
fg_saturationValue       = [ fg_saturations fg_values ];                   


% This forms a matrix of the saturation and value plane  of the background object.
%after getting the indices of each selected point.

bg_saturationValue       = [ bg_saturations bg_values ];      

% This forms a matrix by taking the rows and columns from each matrix
% formed above to create a new composite matrix which contains the indices
% from each plane.
im_saturationValue       = [ im_saturation(:) im_value(:) ];

% mahalanobis distance is calculated for the background and the foreground
% using the matrix formed by values recived from sub2ind.
mahal_fg    = ( mahal( im_saturationValue,fg_saturationValue ));
mahal_bg    = ( mahal( im_saturationValue,bg_saturationValue ));

%   After calculating the mahlanobis distance for forgreound and background
%   using the selected pixels, we can now classify the rest of the points
%   based on these points.Therefore, if any pixel has a mahalanobis
%   distance to foreground less than that for the background, we classify
%   that as a forground image. 
%   Also, I have raised the mahalanobis distance for the backgground by a
%   factor of (1/3) to improve accuracy. of classifying the background from
%   the foreground. which I found by some trial and error.

class_classified     = mahal_fg< mahal_bg.^(1/3);
%This will reshape the final image depending on the elements in the new
%classifies image. (class_foreground )
classified   = reshape( class_classified, size(im_saturation,1), size(im_saturation,2) );


% display the image and convert into gray colormap to get values in black
% and white for contrast enhancement.
imagesc( classified);
title('IMAGE USING MAHALANOBIS DISTANCE')
axis image;
colormap(gray);
pause(5);
end



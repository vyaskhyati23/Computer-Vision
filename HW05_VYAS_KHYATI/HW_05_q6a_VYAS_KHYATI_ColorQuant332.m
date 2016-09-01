% @author: Khyati K.Vyas
function HW_05_q6a_VYAS_KHYATI_ColorQuant332()

addpath('../TEST_IMAGES');

a_list_of_files = {'TBK_Kite.JPG',    'TBK_BRICKS.JPG'...
    ,'kod_parrots.png', 'TBK_Science_Frog.jpg',   'TBK_CAMO_FAILURE.JPG'...
    ,'kod_kid.png',     'kod_ref_image_cheryl.jpg'};


%for loop runs from 1 to the number of images.
for idx = 1:length(a_list_of_files)
    
    %takes one image file at a time and stores it in a variable filename.
    filename =a_list_of_files{idx};
    %read the image.
    im = imread( filename );
    imagesc( im );
    axis image;
    %updates the figure windows and processes the pendng calls.
    drawnow;
    pause(1);
    
    %  Create a 332 colormap to use:
    a_332_cmap = gen_332_cmap( );
    
    %  CREATE AN INDEXED VERSION OF THAT IMAGE, USING THE 332 COLORMAP.
    %for loop runs for the number of quantization levels. Converts the
    %image from rgb2ind allowing no dithering i.e. it tries to match
    %the rgb color in the image exactly to the colormap whereas if
    %dithering was allowed it would try and approximate a color for the
    %rgb image to match the colormap colors.
    im_idx = rgb2ind( im, a_332_cmap, 'nodither' );
    
    % %displaying the image with the specific colormap and colrobar on
    %the side to show the reducing number of colors.
    imagesc( im_idx );
    colormap( a_332_cmap );
    axis image;
    colorbar;
    xlabel(' INDEXED COLOR IMAGE -- SHOWING ONLY 256 COLORS ', 'FontSize',12);
     %pauses for a second after each iteration.
    pause(1);
end


end
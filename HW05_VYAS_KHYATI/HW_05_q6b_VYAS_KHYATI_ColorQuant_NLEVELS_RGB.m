% @author: Khyati K.Vyas
function HW_05_q6b_VYAS_KHYATI_ColorQuant_NLEVELS_RGB()
addpath('../TEST_IMAGES');

a_list_of_files = {'TBK_Kite.JPG',    'TBK_BRICKS.JPG'...
    ,'kod_parrots.png', 'TBK_Science_Frog.jpg',   'TBK_CAMO_FAILURE.JPG'...
    ,'kod_kid.png',     'kod_ref_image_cheryl.jpg'};

%for loop runs from 1 to the number of images.
for idx = 1:length(a_list_of_files)
    
    %takes one image file at a time and stores it in a variable filename.
    filename =a_list_of_files{idx};
    %read the image.
    im_input = imread( filename );
    n=[  256, 128, 64,  24, 16, 10, 7, 6, 5, 4, 3 ];
    
    for N_LEVELS=n
        %for loop runs for the number of quantization levels. Converts the
        %image from rgb2ind allowing no dithering i.e. it tries to match
        %the rgb color in the image exactly to the colormap whereas if
        %dithering was allowed it would try and approximate a color for the
        %rgb image to match the colormap colors.
        [ im_idx,cmap ] = rgb2ind( im_input, N_LEVELS, 'nodither' );
        
        %displaying the image with the specific colormap and colrobar on
        %the side to show the reducing number of colors.
        imagesc(im_idx);
        colormap(cmap);
        colorbar;
        display=[filename,' N LEVELS =',num2str(N_LEVELS)];
        title(display);
        %pauses for a second after each iteration.
        pause(1);
    end
    
end


end
% @author: Khyati K.Vyas
function HW_05_q6d_VYAS_KHYATI_ColorQuant_NLEVELS_LAB()

addpath('../TEST_IMAGES');

a_list_of_files = {'TBK_Kite.JPG',    'TBK_BRICKS.JPG'...
    ,'kod_parrots.png', 'TBK_Science_Frog.jpg',   'TBK_CAMO_FAILURE.JPG'...
    ,'kod_kid.png',     'kod_ref_image_cheryl.jpg'};


%for loop runs from 1 to the number of images.
for idx = 1:length(a_list_of_files)
    
    %takes one image file at a time and stores it in a variable filename.
    filename =a_list_of_files{idx};
    
    %read the image.
    im_in = imread( filename );
    
    %converting rgb image to CIElab colorspace.
    im_lab = rgb2lab(im_in );
    
    
    n=[  256, 128, 64,  24, 16, 10, 7, 6, 5, 4, 3 ];
    
    for N_LEVELS=n
        %for loop runs for the number of quantization levels. Converts the
        %image from rgb2ind allowing no dithering i.e. it tries to match
        %the rgb color in the image exactly to the colormap whereas if
        %dithering was allowed it would try and approximate a color for the
        %rgb image to match the colormap colors.
        [ im_idx ,lab_cmap ] = rgb2ind( im_lab, N_LEVELS, 'nodither' );
        
        %converting the image back to rgb colorspace afterapplying the
        %colormap.However, when we perform this fucntion, it produces a
        %black screen.If we do not use this function, we may be able to see
        %results but in the CIElab colorspace.
        lab_cmap            = lab2rgb( lab_cmap );
        
        %deletes all the current variations of a single image.
        clf;
        
        %displaying the image with the specific colormap and colrobar on
        %the side to show the reducing number of colors.
        
        imagesc( im_idx);
        colormap(lab_cmap);
        axis image;
        colorbar;
        display=[filename,' N LEVELS =',num2str(N_LEVELS)];
        title(display);
        
        %pauses for a second after each iteration.
        pause(0.1);
    end
    
    
end
end
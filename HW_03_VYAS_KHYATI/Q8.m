% @author: Khyati K.Vyas
function Q8()
    im=imread('TBK_Kite.jpg');
    im_r=im(:,:,1);
    im_g=im(:,:,2);
    %im_b=im(:,:,3);
    
    sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
    
    filter_vt=imfilter(im_g,sobel_vt,'same','repl');
    sobel_hz= sobel_vt.';
    filter_hz=imfilter(im_g,sobel_hz,'same','repl');
    image1=filter_vt+filter_hz;
    
    filter_vt1=imfilter(im_r,sobel_vt,'same','repl');
    sobel_hz= sobel_vt.';
    filter_hz1=imfilter(im_r,sobel_hz,'same','repl');
    image2=filter_vt1+filter_hz1;
    
    final_image=image1+image2;
    
    final_image=final_image.*5.5;
    rem_noise= imnoise(final_image,'salt & pepper',0.02);
    final=medfilt2(rem_noise);
    imshow(final);
    
end
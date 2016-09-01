% @author: Khyati K.Vyas
function Q6()
    im=imread('HEADs_UP__do_not_text_and_walk.jpg');
   
    im_r=im(:,:,1);
    im_g=im(:,:,2);
    im_b=im(:,:,3);
    imgb=im_g+im_r;   
    
   
    sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
    filter_vt=imfilter(imgb,sobel_vt,'same','repl');
    sobel_hz= sobel_vt.';
    filter_hz=imfilter(imgb,sobel_hz,'same','repl');
    image=filter_vt+filter_hz;
    image=image.*7;
    image=image+80;

    imshow(image);
    
end
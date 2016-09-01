% @author: Khyati K.Vyas
function Q7()
    im=imread('TBK_Road_Home_frm_CVPR_2012.jpg');
    sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
    filter_vt=imfilter(im,sobel_vt,'same','repl');
    sobel_hz= sobel_vt.';
    filter_hz=imfilter(im,sobel_hz,'same','repl');
    image=filter_vt+filter_hz;
    image1=image.*3.5;
    imshow(abs(image1));

end
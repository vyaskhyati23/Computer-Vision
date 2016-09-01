% @author: Khyati K.Vyas
function Q5()
    im=imread('Parent_Drop_off.jpg');
    sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
    filter_vt=imfilter(im,sobel_vt,'same','repl');
    sobel_hz= sobel_vt.';
    filter_hz=imfilter(im,sobel_hz,'same','repl');
    image=filter_vt+filter_hz;
    imshow(abs(image));
end
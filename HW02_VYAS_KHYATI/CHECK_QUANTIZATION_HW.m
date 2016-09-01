% @author: Khyati K.Vyas
function CHECK_QUANTIZATION_HW(fn)

original_image=imread(fn);
factor=[ 1 2 4 8 16 32 40 50 60 70 80 90 100 128 ];

    for n=factor
        new_im  = round( original_image /n);
        im_restored  = new_im * n;
        imshow(im_restored);
        display=['Quantization Factor =',num2str(n)];
        title(display);
        pause(1.5);
    end
end
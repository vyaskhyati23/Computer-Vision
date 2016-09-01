% @author: Khyati K.Vyas
function Q3()

    im=imread('SHOPPING_LIST.jpg');
    imgray=rgb2gray(im);
    im0=histeq(imgray);
    im1=im2double(im0);
    im2=im1.*1.9;
    im3=im2.^0.3;
    imshow(im3);
    
end
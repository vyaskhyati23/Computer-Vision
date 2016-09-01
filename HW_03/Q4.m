% @author: Khyati K.Vyas
function Q4()
    im=imread('THERMOMETER_20160213_1110.jpg');
    im=rgb2ycbcr(im);
    im=im(:,:,1);
    im=imadjust(im);
    im=im2double(im);
    im(im >1.0)=1;
    imshow(im);
    
    
end
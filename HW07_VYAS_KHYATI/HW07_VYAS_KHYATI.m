% @author: Khyati K.Vyas
function HW07_VYAS_KHYATI(fn)

addpath('../TEST_IMAGES');

%Reads the image.
im=imread(fn);
%Displays the image and pauses for 2 seconds.
imshow(im);
pause(2);
%Calls the counting function.
counting(fn);

end
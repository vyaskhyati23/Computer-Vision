% @author: Khyati K.Vyas
function histogram_Matched_Images()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This fucntion  performs the histogram matching       %
%    using various samples taken under different settings %
%    to form the reference images.The                     %                  
%                                                         %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
addpath('../Images');

%Reading image samples for dollars%
im3=imread('20D_cropped.jpg');
im4=imread('100D_cropped.jpg');
%Matched image for dollars%
match=imhistmatch(im4,im3);
imshow(match);
%Writing the formed image to a new file to be in histogram() function.
imwrite(match,'match.jpg');

%Reading image samples for Rs.10 %
im1=imread('10_cropped.jpg');
im2=imread('10R_cropped.jpg');
%Matched image for 10 ruppee notes%
match1=imhistmatch(im1,im2);
imshow(match1);
%Writing the formed image to a new file to be in histogram() function.
imwrite(match1,'match1.jpg');


%Reading image samples for Rs.100 %
im7=imread('100R_cropped.jpg');
im8=imread('100_cropped.jpg');
%Matched image for 100 ruppee notes%
match2=imhistmatch(im8,im7);
imshow(match2);
%Writing the formed image to a new file to be in histogram() function.
imwrite(match2,'match2.jpg');

%Reading image samples for Rs.500 %
im5=imread('500R_cropped.jpg');
im6=imread('500_cropped.jpg');
%Matched image for 500 ruppee notes%
match3=imhistmatch(im6,im5);
imshow(match3);
%Writing the formed image to a new file to be in histogram() function.
imwrite(match3,'match3.jpg');

end
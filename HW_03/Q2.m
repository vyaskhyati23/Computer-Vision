% @author: Khyati K.Vyas
function shopping_list()
%     %{2. Professor Kinsman cannot read his shopping list.  
%     Here we will try a method for quantizing it to black and white to see if 
%     that improves it.
%     a. Read in the SHOPPING_LIST image supplied. 
%     b. Convert it to one color. 
%     c. Use the graythresh( ) routine to find the best method for converting the image into black and white.
%     d. Using this threshold, quantize the image into <= the threshold and > the threshold.  
%     e. Graythresh( ) uses an underlying clustering method.  What is the name of this method?  What was it initially designed for? 
%     f. Display the resulting quantized image.  Put the resulting image in your write-up, and discuss the results.  How well did this work, and why 


    im=imread('SHOPPING_LIST.jpg');
    %one_color=rgb2gray(im);
    one_color=im(:,:,2);
    imshow(one_color);
   
    threshold=graythresh(one_color);
    disp(threshold);
    one_color1=im2double(one_color);
    
    
%      new_im  = round(one_color /threshold);
%      one_color11  = new_im * threshold;
    
    one_color1(one_color1 > threshold)=1.0;
    one_color1(one_color1 <= threshold) = 0.0;
   
    imshow(one_color1);
end

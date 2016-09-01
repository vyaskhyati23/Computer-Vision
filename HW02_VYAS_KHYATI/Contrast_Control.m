% @author: Khyati K.Vyas
function Contrast_Control()
    im=imread('Might_or_Might_NOT.jpg');
    
    %Adjusting Image Intensity
    figure; 
    subplot(2,2,1);
    imshow(im);
    
    
    subplot(2,2,3);
    histogram(im);
    
    image_adjust=imadjust(im);
    
    subplot(2,2,2);
    imshow(image_adjust);
    
    subplot(2,2,4);
    histogram(image_adjust);
    
    %Histogram Equalization
    figure;
    subplot(2,2,1);
    imshow(im);
    
    subplot(2,2,3);
    histogram(im);
    
    image_histeq=histeq(im);
    
    subplot(2,2,2);
    imshow(image_histeq);
    
    subplot(2,2,4);
    histogram(image_histeq);
    
    %Adaptive Histogram Equalization
    figure;
    subplot(2,2,1);
    imshow(im);
    
    subplot(2,2,3);
    histogram(im);
    
    adaptive_histeq=adapthisteq(im);
    
    subplot(2,2,2);
    imshow(adaptive_histeq);
    
    subplot(2,2,4);
    histogram(adaptive_histeq);
    
end
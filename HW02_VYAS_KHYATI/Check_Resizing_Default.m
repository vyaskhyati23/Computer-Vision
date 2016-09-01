% @author: Khyati K.Vyas
function  Check_Resizing_Default(fn) 
    im=imread(fn);
    imshow(im);
    pause(3);
    factor=[ 1 2 4 8 16 24 32 48 50 52 56 64 128 ];
    
    for n=factor
        %im=image(1:2:end, 1:2:end);
        orgSize=[size(im,1),size(im,2)];
        newSize=round(orgSize/n);
        im_small= imresize(im,newSize);
        im_restored= imresize(im_small,orgSize);
        imshow(im_restored);
        display=['Sub-Sampling is :',num2str(n)];
        title(display);
        pause(1.5);
    end
    
end
    
    
    
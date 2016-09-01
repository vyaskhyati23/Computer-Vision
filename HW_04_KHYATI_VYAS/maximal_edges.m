% @author: Khyati K.Vyas
function  maximal_edges(image)

image=imread('TBK_portland_maine_007.jpg');
image=im2double(image);
fltr  = fspecial('Gauss',30,2.5);    % Play with the values here to remove the unimportant edges.
im2   = imfilter(image, fltr,'same','repl');    % Takes a second or two…
figure;
imagesc(im2);
title('Input Image');


im_r=im2(:,:,1);
im_g=im2(:,:,2);
im_b=im2(:,:,3);


sobel_vt=[1 0 -1;2 0 -2;1 0 -1];
sobel_hz= sobel_vt.';

%  Sobel filter on red plane
%filter_vt=imfilter(im_r,sobel_vt,'same','repl');
% filter_hz=imfilter(im_r,sobel_hz,'same','repl');
% image_red=filter_vt+filter_hz;
% %figure;
% %imshow(image_red);
% title('Sobel: RED plane');

% %   Sobel filter on green plane
% sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
% filter_vt=imfilter(im_g,sobel_vt,'same','repl');
% sobel_hz= sobel_vt.';
% filter_hz=imfilter(im_g,sobel_hz,'same','repl');
% image_green=filter_vt+filter_hz;
% %figure;
% %imshow(image_green);
% title('Sobel: GREEN plane');

% %   Sobel filter on blue plane
% sobel_vt=[1 0 -1;2 0 -2;1 0 -1]/8;
% filter_vt=imfilter(im_b,sobel_vt,'same','repl');
% sobel_hz= sobel_vt.';
% filter_hz=imfilter(im_b,sobel_hz,'same','repl');
% image_blue=filter_vt+filter_hz;
% %figure;
% %imshow(image_blue);
% title('Sobel: BLUE plane');

%
%     im3=cat(3,image_red,image_green,image_blue);
%     figure;
%     imagesc(im3);
%     title('ALL THREE PLANES');

% Worked on all 3 planes,found that green plane provides the best result.
edge_x=imfilter(im_g,sobel_vt,'same','repl');
edge_y=imfilter(im_g,sobel_hz,'same','repl');

%Calculating the edge magnitude.
edge_magnitude=((edge_x.^2+edge_y.^2)).^(1/2);

%Calculating the orientation.
angle=atan2(edge_y,edge_x)*(180/pi);
angle=round(angle,45);
    
%creating a new matrix
magnitude=edge_magnitude;

for r=1:size(im_g,1)
    for c=1:size(im_g,2)
        
        %If angle is 0,check for the pixel and 1 pixel ahead and behind
        %it,If it is greater than both, set it to that.If either of the
        %pixels have a value greater than that, set the pixel value to
        %0.
        if angle(r,c)==0
            if (magnitude(r,c)> magnitude(r,c+1)&& (magnitude(r,c)> magnitude(r,c-1)))
                magnitude(r,c)= magnitude(r,c);
            else
               magnitude(r,c)=0;
            end
            
            %If angle is 90,check for the pixel and 1 pixel above and below
            %it,If it is greater than both, set it to that.If either of the
            %pixels have a value greater than that, set the pixel value to
            %0.
        elseif angle(r,c)==90
            if (magnitude(r,c)>magnitude(r-1,c)&& (magnitude(r,c)> magnitude(r+1,c)))
                magnitude(r,c)= magnitude(r,c);
            else
                magnitude(r,c)=0;
            end
            
            %If angle is 45,check for the pixel and 1 pixel diagonally above
            %in the right direction and one pixel diagonally behind in the
            %left direction.If it is greater than both, set it to that.If either of the
            %pixels have a value greater than that, set the pixel value to
            %0.
        elseif angle(r,c)==45
            if (magnitude(r,c)>magnitude(r+1,c+1)&& (magnitude(r,c)> magnitude(r-1,c-1)))
                magnitude(r,c)= magnitude(r,c);
            else
                magnitude(r,c)=0;
            end
            %If angle is 135,check for the pixel and 1 pixel diagonally
            %behind in the left direction and one pixel diagonally below in the
            %right direction.If it is greater than both, set it to that.If either of the
            %pixels have a value greater than that, set the pixel value to
            %0.
        elseif angle(r,c)==135
            if (magnitude(r,c)>magnitude(r+1,c-1)&& (magnitude(r,c)>magnitude(r-1,c+1)))
                magnitude(r,c)= magnitude(r,c);
            else
                magnitude(r,c)=0;
            end
        end
    end
end

imwrite(magnitude,'final_image.jpg');
end
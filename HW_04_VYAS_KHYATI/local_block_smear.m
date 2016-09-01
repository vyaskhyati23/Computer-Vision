% @author: Khyati K.Vyas
function local_block_smear(input_image)

input_image=imread('TBK_portland_maine_007.jpg');
input_image=im2double(input_image);

dimensions = size( input_image ) ;
disp(dimensions);
disp(dimensions(2));
if length( dimensions ) > 2          %
    input_image = rgb2gray( input_image );
    figure;
    imshow(input_image);
    title('Input Grayscale image');
end

% Default return values …
output_image = input_image;

% Add comments about all of this, and everthing that is happening.
% What are the 3’s for ??

%the 3's avoid the edges.Since we run the row and col loop for -2 to 2.
for row = 3 : (dimensions(2) - 3)
    for col = 3 : (dimensions(1) - 3 )
        sum = 0;
        %Ignoring the edges.
        for ii = -2 : 2
            for kk  = -2 : 2
                sum =sum+ input_image(col + kk,row + ii);
                % The convention is image(row,col) but here it was changed to
                % image(col,row).
                % sum is unit8 by default.Therefore, sum will always be
                % zero.Since it caps everything beyond 255 to 255.Therfore,
                % we need to convert the image to double.
                
            end
        end
     output_image(col,row ) = sum / 25;
        
    end
end
figure;
imshow(output_image);
title('After Smearing');
end
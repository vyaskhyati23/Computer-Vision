% @author: Khyati K.Vyas
% Compare element-wise versus array-wise operations on matrices
m4=magic(4);

% Q1: What does this operation do? % Does it work on the entire matrix or on each element?
ANS1=m4.^2;
disp(ANS1);
disp('ANS 1: .^ Works on each element.');

% Q2: What does this operation do? % Does it work on the entire matrix or on each element?
ANS2=m4^2;
disp(ANS2);
disp('ANS 2: ^ Works on entire element.');

% Q3: Can you generate a 7x7 magic square?
m7=magic(7);
disp(m7);
disp('ANS 3: Yes. A new variable m7 is created.');

% Q4: Print out one element
ltuae=m7(5,5);
ANS4=['ANS 4: Prints out the element in row 5 and column 5' ,num2str(ltuae)];
disp(ANS4);

% Q5:  Extract a sub-matrix from rows 1 to 4, and columns 1 to 2
submat= m7( 1:4, 1:2);
disp('ANS 5:');
disp(submat)

% Q6: Treat the entire matrix as one long vector, and print the 34th element:
disp('ANS 6:');
m7(34)

% Q7:  If we wanted to print element #34 using (row,col) notation, what notation would we use?
disp('ANS 7:');
m7( 6, 5 )

% Q8: Extract the last row: 
disp('ANS 8:');
m7( end, : )

% Q9: What command would I use to get this row of the matrix, m7:
%   38    47     7     9    18    27    29
disp('ANS 9: Command is m7(2,:)');
m7(2,:)

% Q10: Extract the 4th column, and transpose it using the .' operator:
disp('ANS 10: It prints as a row');
m7( :, 4 ).';

% Q11: Read in the cameraman image, from the Matlab image example repository:
disp('ANS 11: Opens the cameraman.tif image in a new window.');
im_cam = imread('cameraman.tif');
imshow( im_cam );

% Q12: Get a sub-section of the cameraman, and show just the heads of the man and the tripod:
disp('ANS 12: Displays the sub-section of the image based on the row and column limits.');
im_cam_head = im_cam( 35:83  , 97:176 );
imshow( im_cam_head );

% Q13: What command would you use to isolate the part of the image that is the
% faint building in the back right side?
disp('ANS 13: im_cam(133:153 ,220:230) command isolates the faint building.');
im_subset = im_cam(133:153 ,220:230);
imagesc( im_subset );
pause( 3 );

% Q14:  Read in the peppers.png image
disp('ANS 14: Reads the peppers.png from the image repositary.');
im_peppers = imread( 'peppers.png' );
imshow( im_peppers );

% Q15: % Get a sub-section of the peppers image, and display it
ANS15=['ANS 15: The third parameter is used to display all the 3 color channels.'...
'cameraman.tif is a grayscale image.'];
disp(ANS15);
sub_im = im_peppers(  164:255   ,  200:312  , :  ); 
imshow( sub_im );


% Q16: % Go back to the camera man:
disp('ANS 16:');
im_cam_mult = im_cam * 4 ;
imagesc( im_cam_mult );
% Does this help us see the dark regions?
disp('Yes!The dark region appears better.eg.The cameramans jacket');
% Does it hide any regions?
disp('It hides the details of the background elements. ');


% Q17:   Try this version, what is different
disp('ANS 17: using im2double scales the output to double precesion in the range 0.0 to 1.0');
disp('It allows to view the background details better as opposed to Q 16.');
im_cam_mult = im2double( im_cam ) * 4;
imagesc( im_cam_mult );



% Q18: When we do this what does it do? Does it help us see his pockets?
% Why or why not?  What did we do to the image?  What can you not see?
ANS18=['ANS 18:We are setting all the pixel values greater than 1.0 to 1.0'... 
 'Yes it helps to view the pocket better.Since we set all the pixels with value' ...
 'greater than 1.0 to 1.0,We cannot clearly view the background details with pixel'...
 'values less than 1.0'];
disp(ANS18);
im_cam_mult( im_cam_mult > 1.0 ) = 1.0; 
imagesc( im_cam_mult );
im_uint8  = imread('cameraman.tif');
im_double = im2double( im_uint8 );


% Q19: What do the following commands emphasize about the image? 
%  How do they differ?
disp('ANS 19:In the first command we use a factor of 3 which makes the image darker.');
disp('Whereas in the second command the factor is so small,it makes the image brighter.');
im_new = im_double.^3 ; 
imagesc( im_new ); 
im_new = im_double.^(1/2.8);
imagesc( im_new );


% Q20: % Read in the image, RED_GREEN_BLUE_YELLOW_MEMORY_COLORS.jpg
% Convert the image to a double format.
disp('ANS 20:')
im = im2double( imread('RED_GREEN_BLUE_YELLOW_MEMORY_COLORS.jpg') );

% 20a: The image itself.
disp('ANS 20 a: Using imshow command to display the image');
imshow(im);
pause(2);

% 20b: Just the red   channel (the red   color plane).
disp('ANS 20 b: image_name(:,:,1) is used to display all rows,columns and red plane only.');
red_plane=im(:,:,1);
imshow(red_plane);
pause(2);

% 20c: Just the green   channel (the green   color plane).
disp('ANS 20 c: image_name(:,:,2) is used to display all rows,columns and green plane only.');
green_plane=im(:,:,2);
imshow(green_plane);
pause(2)

% 20d: Just the blue   channel (the blue   color plane).
disp('ANS 20 d: image_name(:,:,3) is used to display all rows,columns and blue plane only.');
blue_plane=im(:,:,3);
imshow(blue_plane);
pause(3);

% 20e: The inverse of the image.
disp('ANS 20 e: ');
inverse=1-im;
imshow(inverse);
pause(2);

% 20f: Just the first  channel.  What color is this
disp('ANS 20 f:Displays the red channel of the inversed image.');
first_plane=inverse(:,:,1);
imshow(first_plane);
pause(2);

% 20g: Just the second  channel.  What color is this
disp('ANS 20 g:Displays the green channel of the inversed image.');
second_plane=inverse(:,:,2);
imshow(second_plane);
pause(2);

% 20h: Just the third  channel.  What color is this
disp('ANS 20 h:Displays the blue channel of the inveresed image.');
third_plane=inverse(:,:,3);
imshow(third_plane);
pause(3);

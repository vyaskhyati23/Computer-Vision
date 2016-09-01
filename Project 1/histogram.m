% @author: Khyati K.Vyas
function histogram()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This fucntion  performs the histogram comparison  %
%    and prediction of the origin currency.            %                                              
%                                                      %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
addpath('../Images');

% Read the input image.
Im = imread('10R_cropped.jpg');
Im = im2double(Im);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Comparisona with match1(samples of Rs.10) and       %
%   calculation of error in each plane with the cropped %
%   input image.                                        %                   
%                                                       %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Im_Ruppees_10 = imread('match1.jpg');
Im_Rupees_10 = im2double(Im_Ruppees_10);

% convert to hsv
Im_r = rgb2hsv(Im);
Im_Rupees_10 = rgb2hsv(Im_Rupees_10);

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_10);title('Reference Image');

%PALNE 1
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_10 = imhist(Im_r(:,:,1))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,1));title('Histogram of input image: HUE');
hn2_r_10 = imhist(Im_Rupees_10(:,:,1))./numel(Im_Rupees_10);
subplot(2,2,4);imhist(Im_Rupees_10(:,:,1));title('Histogram of reference image:HUE ');

% Calculate the histogram error
error_plane_1_r_10 = sqrt(mean((hn1_r_10-hn2_r_10).^2));
disp('HISTOGRAM ERROR PLANE 1');
disp(error_plane_1_r_10); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_10);title('Reference Image');
%PLANE 2
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_10 = imhist(Im_r(:,:,2))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,2));title('Histogram of input image :SATURATION');
hn2_r_10 = imhist(Im_Rupees_10(:,:,2))./numel(Im_Rupees_10);
subplot(2,2,4);imhist(Im_Rupees_10(:,:,2));title('Histogram of reference image:SATURATION');

% Calculate the histogram error
error_plane_2_r_10 = sqrt(mean((hn1_r_10-hn2_r_10).^2));
disp('HISTOGRAM ERROR PLANE 2');
disp(error_plane_2_r_10); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_10);title('Reference Image');
%PLANE 3
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_10 = imhist(Im_r(:,:,3))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,3));title('Histogram of input image: VALUE');
hn2_r_10 = imhist(Im_Rupees_10(:,:,3))./numel(Im_Rupees_10);
subplot(2,2,4);imhist(Im_Rupees_10(:,:,3));title('Histogram of reference image:VALUE');

% Calculate the histogram error
error_plane_3_r_10 = sqrt(mean((hn1_r_10-hn2_r_10).^2));
disp('HISTOGRAM ERROR PLANE 3');
disp(error_plane_3_r_10); %display the result to console

total_error_sum_r_10=error_plane_1_r_10+error_plane_2_r_10+error_plane_3_r_10;
disp('Total histogram error');
disp(total_error_sum_r_10);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Comparisona with match2(samples of Rs.100) and      %
%   calculation of error in each plane with the cropped %
%   input image.                                        %                   
%                                                       %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Im_Ruppees_100 = imread('match2.jpg');
Im_Rupees_100 = im2double(Im_Ruppees_100);

% convert to hsv
Im_r = rgb2hsv(Im);
Im_Rupees_100 = rgb2hsv(Im_Rupees_100);

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_100);title('Reference Image');

%PALNE 1
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_100 = imhist(Im_r(:,:,1))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,1));title('Histogram of input image: HUE');
hn2_r_100 = imhist(Im_Rupees_100(:,:,1))./numel(Im_Rupees_100);
subplot(2,2,4);imhist(Im_Rupees_100(:,:,1));title('Histogram of reference image:HUE ');

% Calculate the histogram error
error_plane_1_r_100 = sqrt(mean((hn1_r_100-hn2_r_100).^2));
disp('HISTOGRAM ERROR PLANE 1');
disp(error_plane_1_r_100); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_100);title('Reference Image');
%PLANE 2
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_100 = imhist(Im_r(:,:,2))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,2));title('Histogram of input image :SATURATION');
hn2_r_100 = imhist(Im_Rupees_100(:,:,2))./numel(Im_Rupees_100);
subplot(2,2,4);imhist(Im_Rupees_100(:,:,2));title('Histogram of reference image:SATURATION');

% Calculate the histogram error
error_plane_2_r_100 =sqrt(mean((hn1_r_100-hn2_r_100).^2));
disp('HISTOGRAM ERROR PLANE 2');
disp(error_plane_2_r_100); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_100);title('Reference Image');
%PLANE 3
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_100 = imhist(Im_r(:,:,3))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,3));title('Histogram of input image: VALUE');
hn2_r_100 = imhist(Im_Rupees_100(:,:,3))./numel(Im_Rupees_100);
subplot(2,2,4);imhist(Im_Rupees_100(:,:,3));title('Histogram of reference image:VALUE');

% Calculate the histogram error
error_plane_3_r_100 = sqrt(mean((hn1_r_100-hn2_r_100).^2));
disp('HISTOGRAM ERROR PLANE 3');
disp(error_plane_3_r_100); %display the result to console

total_error_sum_r_100=error_plane_1_r_100+error_plane_2_r_100+error_plane_3_r_100;
disp('Total histogram error');
disp(total_error_sum_r_100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Comparisona with match3(samples of Rs.500) and      %
%   calculation of error in each plane with the cropped %
%   input image.                                        %                   
%                                                       %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Im_Ruppees_500 = imread('match3.jpg');
Im_Rupees_500 = im2double(Im_Ruppees_500);

% convert to hsv
Im_r = rgb2hsv(Im);
Im_Rupees_500 = rgb2hsv(Im_Rupees_500);

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_500);title('Reference Image');

%PALNE 1
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_500 = imhist(Im_r(:,:,1))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,1));title('Histogram of input image: HUE');
hn2_r_500 = imhist(Im_Rupees_500(:,:,1))./numel(Im_Rupees_500);
subplot(2,2,4);imhist(Im_Rupees_500(:,:,1));title('Histogram of reference image:HUE ');

% Calculate the histogram error
error_plane_1_r_500 = sqrt(mean((hn1_r_500-hn2_r_500).^2));
disp('HISTOGRAM ERROR PLANE 1');
disp(error_plane_1_r_500); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_500);title('Reference Image');
%PLANE 2
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_500 = imhist(Im_r(:,:,2))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,2));title('Histogram of input image :SATURATION');
hn2_r_500 = imhist(Im_Rupees_500(:,:,2))./numel(Im_Rupees_500);
subplot(2,2,4);imhist(Im_Rupees_500(:,:,2));title('Histogram of reference image:SATURATION');

% Calculate the histogram error
error_plane_2_r_500 =sqrt(mean((hn1_r_500-hn2_r_500).^2));
disp('HISTOGRAM ERROR PLANE 2');
disp(error_plane_2_r_500); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Ruppees_500);title('Reference Image');
%PLANE 3
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_r_500 = imhist(Im_r(:,:,3))./numel(Im_r);
subplot(2,2,3);imhist(Im_r(:,:,3));title('Histogram of input image: VALUE');
hn2_r_500 = imhist(Im_Rupees_500(:,:,3))./numel(Im_Rupees_500);
subplot(2,2,4);imhist(Im_Rupees_500(:,:,3));title('Histogram of reference image:VALUE');

% Calculate the histogram error
error_plane_3_r_500 =sqrt(mean((hn1_r_500-hn2_r_500).^2));
disp('HISTOGRAM ERROR PLANE 3');
disp(error_plane_3_r_500); %display the result to console

total_error_sum_r_500=error_plane_1_r_500+error_plane_2_r_500+error_plane_3_r_500;
disp('Total histogram error');
disp(total_error_sum_r_500);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Comparison with match(samples of $20 and $100) and  %
%   calculation of error in each plane with the cropped %
%   input image.                                        %                   
%                                                       %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Im_Dollar = imread('match.jpg');
Im_Dollars = im2double(Im_Dollar);

% convert to hsv
Im_d = rgb2hsv(Im);
Im_Dollars = rgb2hsv(Im_Dollars);

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Dollar);title('Reference Image');

%PALNE 1
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_d = imhist(Im_d(:,:,1))./numel(Im_d);
subplot(2,2,3);imhist(Im_d(:,:,1));title('Histogram of input image: HUE');
hn2_d= imhist(Im_Dollars(:,:,1))./numel(Im_Dollars);
subplot(2,2,4);imhist(Im_Dollars(:,:,1));title('Histogram of reference image:HUE ');

% Calculate the histogram error
error_plane_1_d = sqrt(mean((hn1_d-hn2_d).^2));
disp('HISTOGRAM ERROR PLANE 1');
disp(error_plane_1_d); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Dollar);title('Reference Image');

%PLANE 2
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_d = imhist(Im_d(:,:,2))./numel(Im_d);
subplot(2,2,3);imhist(Im_d(:,:,2));title('Histogram of input image :SATURATION');
hn2_d = imhist(Im_Dollars(:,:,2))./numel(Im_Dollars);
subplot(2,2,4);imhist(Im_Dollars(:,:,2));title('Histogram of reference image:SATURATION');

% Calculate the histogram error
error_plane_2_d = sqrt(mean((hn1_d-hn2_d).^2));
disp('HISTOGRAM ERROR PLANE 2');
disp(error_plane_2_d); %display the result to console

figure('Position',[10 10 1200 768]);
subplot(2,2,1);imagesc(Im);title('Input Image');
subplot(2,2,2);imagesc(Im_Dollar);title('Reference Image');
%PLANE 3
% Calculate the Normalized Histogram of Image 1 and Image 2
hn1_d = imhist(Im_d(:,:,3))./numel(Im_d);
subplot(2,2,3);imhist(Im_d(:,:,3));title('Histogram of input image: VALUE');
hn2_d = imhist(Im_Dollars(:,:,3))./numel(Im_Dollars);
subplot(2,2,4);imhist(Im_Dollars(:,:,3));title('Histogram of reference image:VALUE');

% Calculate the histogram error
error_plane_3_d = sqrt(mean((hn1_d-hn2_d).^2));
disp('HISTOGRAM ERROR PLANE 3');
disp(error_plane_3_d); %display the result to console

%Calculating total error from each plane.
total_error_sum_d=error_plane_1_d+error_plane_2_d+error_plane_3_d;
disp('Total histogram error');
disp(total_error_sum_d);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Predicting currency based on the lowest error          %                    
%   Displaying the final prediction in the command window  %         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%error.
if total_error_sum_r_10<total_error_sum_d
    disp('INDIAN CURRENCY');
elseif total_error_sum_r_100<total_error_sum_d
    disp('INDIAN CURRENCY');
elseif total_error_sum_r_500<total_error_sum_d
    disp('INDIAN CURRENCY');
else
    disp('AMERICAN CURRENCY');
end
end
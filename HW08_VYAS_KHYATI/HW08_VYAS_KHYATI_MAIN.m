% @author: Khyati K.Vyas
function HW08_VYAS_KHYATI_MAIN(fn)

%reference code: Prof. Kinsman.
close all;
addpath('../TEST_IMAGES');

% Tolerance in degrees.
del =45 ;
fn='IMG_1281.jpg';
%fn='IMG_1289.jpg';
%fn='IMG_1294.jpg';
%fn='IMG_1323.jpg';
%fn='IMG_1324.jpg';
%fn='IMG_1325.jpg';
%fn='IMG_1353.jpg';
%fn='IMG_1358.jpg';

%converting the image to im2double()
%figure('Position',[10 10 1200 768]);
figure;
im_3          = im2double( imread( fn ) );
imshow(im_3);
ttl = sprintf('ORIGINAL IMAGE');
title( ttl, 'FontSize', 14 );

%Using gaussian filter to remove noise in the form of small unwanted edges.
fltr  = fspecial('Gauss',30,1.5);
im_3  = imfilter(im_3, fltr,'same','repl');

%Sobel filter used on the image to detect vertical and horizontal edges in
%the image.These edges are then fed to atan2() to compute the angle.
fltr_sobel  = [1 0 -1;2 0 -2;1 0 -1]/8;
im_horz_lines = imfilter( im_3, fltr_sobel,   'same', 'repl' );
im_vert_lines = imfilter( im_3, fltr_sobel.', 'same', 'repl' );

%
%  Computing the magnitude and angle of the edges.Angle here is computed in
%  radians.
%
im_mag      = ((im_horz_lines.^2+im_vert_lines.^2));
im_ang      = atan2(im_horz_lines,im_vert_lines);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MAIN LOOP:
%  Here we form a meshgrid using the x and y coordinates of the image.We
%  use the green channel of the image since it works better than the other
%  channels.
%
im_mag_grn  = im_mag( :, :, 2 );            % Use the green channel.
dims        = size( im_mag_grn );
[xs, ys]    = meshgrid( 1:dims(2), 1:dims(1) );

%creating a matrix of 0's of the size equal to the image dimensions.
votes_vp    = zeros( dims );
%disp(votes_vp);

%Considering the angles
angles      = [ -135 : del : 150 ];
for angle = angles
    
    %
    %  Here, we calculate the the min and max threshold for angles.The
    %  angles are converted to radians.
    %
    min_angle_rads = (angle-del/2)*pi/180;
    max_angle_rads = (angle+del/2)*pi/180;
    
    %
    % Here, we set all the pixels less than the minimum angle threshold and
    % maximum angle threshold to 0. Since, we have to consider only the
    % angles at 135 and -135 degrees. And we consider some plus/minus error
    % value since all edges will not be exactly at 135/-135 degrees.
    %
    
    ang_of_int                                  = im_ang(:,:,2);
    ang_of_int( ang_of_int <= min_angle_rads )  = 0;
    ang_of_int( ang_of_int >= max_angle_rads )  = 0;
    
    %
    % Create an image of all the edges that are not 0. Therefore, this
    % image will have all edges that are at our specified angle.
    %
    b_edge_pts_this_angle = ang_of_int ~=0;
    
    %
    %  Here we consider only the top 5% of the edge strengths. We toss out
    %  the rest of the 95% out.Here I am sorting the values in descending
    %  order since we need only the top 5%.
    %
    
    im_mags_of_int      = im_mag_grn( b_edge_pts_this_angle );
    [ all_values sk ]   = sort( im_mags_of_int(:), 'descend' );
    dim = size(all_values);
    top_thresh_idx  = 1 : round(dim(1)*(5/100));
    top_thresh_value    = all_values( top_thresh_idx );
    im_mag_grn_big      = im_mag_grn;
    im_mag_grn_big(im_mag_grn< min(top_thresh_value)) = 0;    % CLEAR THE LOW VALUES.
    
    % FORM A BOOLEAN VALUE OF THE PIXELS THAT ARE AT THE CORRECT ANGLE,
    % AND HAVE MORE THAN THE "top_thresh_value" MAGNITUDE FOR EDGE STRENGTH:
    b_edge_pts_selected = (im_mag_grn_big > 0) & b_edge_pts_this_angle;
    
     %This plots the original image.
    figure('Position',[10 10 1200 768]);
    subplot(2,2,1);
    imagesc( im_3 );
    axis image;
    
    %This plots the image with the points that are at our specified angle.
    subplot(2,2,2);
    imagesc( b_edge_pts_selected );
    axis image;
    ttl = sprintf('Edge PTs Selected for Angle of %4.1f Degrees ', angle);
    title( ttl, 'FontSize', 18 );
    colormap(gray);
    
    %this plots the image with the magenta colored lines at the edges.
    subplot(2,2,1);
    imagesc( im_3 );
    colormap(gray);
    axis image;
    hold on;
    ttl = sprintf('Lines Found at Angle of %4.1f Degrees ', angle);
    title( ttl, 'FontSize', 18 );
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % here, we use the hough() method to find out the peaks and lines in
    % the image.
    %
    % This code, with modifided parameters, comes from the Matlab(tm) documentation,
    % Mathworks company, 2016.  MATLAB Version: 8.5.0.197613 (R2015a)
    %
    [H,T,R] = hough( b_edge_pts_selected, 'RhoResolution', 1, 'Theta',  -90:2:89 );
    peaks   = houghpeaks(H,5,'threshold',ceil(0.25*max(H(:))),'NHoodSize',[5 5]);
    lns     = houghlines( b_edge_pts_selected, T, R, peaks,'FillGap', 30);
    
    
    % Draw the lines in MAGENTA:
    for ln_idx = 1:length(lns)
        hold on;
        pt1     = lns(ln_idx).point1;
        pt2     = lns(ln_idx).point2;
        plot( [ pt1(1) pt2(1) ], [ pt1(2) pt2(2) ], 'm-', 'LineWidth', 2 );
        
        %Forms a meshgrid for the x and y coordinates.
        [xs, ys]    = meshgrid( 1:dims(2), 1:dims(1) );
        
        %finds the difference in the x and y values for the 2 points.
        dy=pt2(2)-pt1(2);
        dx=pt2(1)-pt1(1);
        
        %Computing the equation of the line in cannonical form.
        equation_of_line=pt2(1)*pt1(2)-pt2(2)*pt1(1);
        
        %computing the distance between the 2 points.
        distance=sqrt(dy^2+dx^2);
        
        % Now compute the distances from the line to all other points:
        dists   = abs(dy*xs - dx*ys+ (equation_of_line )) / distance;
        b_vote_map = (dists <= 1.5);
        
        %
        %Here, we count the votes of each line. And since we need the votes
        %that favor longer lines, add the square root of the length of the line i.e. the
        %distance between the 2 points.
        %
        votes_vp(b_vote_map) = votes_vp(b_vote_map) +sqrt(distance);
    end 

end

%Here, creating filter to smear out the points formed by the edges.We do
%this since the edges found are extremly fine and may result in more votes to a point
%which is not the exact vanishing point.Thus we smear out the edges.
dsk             = fspecial('disk', 11);
dsk(dsk>0)      = 1;
votes_smeared   = imfilter( votes_vp, dsk, 'same', 'repl' );


%
%  Find that maximum point.
%
mmax    = max( votes_smeared(:) );
[c, r]  = find( votes_smeared == mmax );

%This will show the edges after smearing.And we can see the vanishing point
%which is displayed with a red circle around it.
figure('Position',[10 10 1200 768]);
imagesc( votes_smeared );
%imagesc( votes_vp );
colormap(gray);
axis image;
hold on;
ttl = sprintf('Vanishing Point Votes for all Angles', angle);
title( ttl, 'FontSize', 18 );
hold on;
plot( r, c, 'ro', 'MarkerSize', 20, 'LineWidth', 2 );

%This diplays the vanishing point in the original image with a magenta
%cross , magenta circle and a green cross.
figure('Position',[10 10 1200 768]);
imagesc( im_3 );
colormap(gray);
axis image;
hold on;
ttl = 'Vanishing Point Found In Image: ';
title( ttl, 'FontSize', 18 );
hold on;
plot( r, c, 'mo', 'MarkerSize', 24, 'LineWidth', 2 );
plot( r, c, 'm+', 'MarkerSize', 30, 'LineWidth', 2 );
plot( r, c, 'gx', 'MarkerSize', 28, 'LineWidth', 2 );

end
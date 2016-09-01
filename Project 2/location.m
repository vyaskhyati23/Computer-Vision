%DN = 'fifa'; DR = sprintf('%s%s%s','.\',DN,'\'); % Database name and
%directory or    = [290,314,34,81];                               % Object
%location in the first frame
% tfn   = size(dir(sprintf('%s*.jpg',DR)),1);            % Total Frame Numbers
%sf    = 1;                                             % Start Frame For Tracking
%ef    = 640;                                 

%for fn = sf:ef
    
%I = imread(sprintf('%simage %01d.jpg',DR,fn));             % Read Frame    

function [lines,count,color]=location(I)

%I  = imread('C:\matlab\BE Project\sa\fifa\image 600.jpg');
%rotI = imrotate(I,33,'crop');
count=0;
color=0;
G=rgb2gray(I);
se1= strel('disk',12);
tophatFiltered = imtophat(G,se1);
%figure(1), imshow(tophatFiltered)
contrastAdjusted = imadjust(tophatFiltered);
%figure(3), imshow(contrastAdjusted)
se = strel('line',11,90);

 G=im2bw(G);
BW = edge(G,'canny');
%BW = imdilate(BW,se);
%figure, imshow(BW);
[H,theta,rho] = hough(BW);
%figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
    %    'InitialMagnification','fit');
%xlabel('\theta (degrees)'), ylabel('\rho');
%axis on, axis normal, hold on;
%colormap(hot)
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',12);

%figure, imshow(I), hold on
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];     % Finding longest line
   
   len=norm(lines(k).point1 - lines(k).point2);
   if(len > max_len)
       max_len = len;
       count=k;
      xy_long = xy;
   end
   
end

%checking the type of the line   
   if(lines(count).theta < 0 && lines(count).rho > 0) 
            len = norm(lines(count).point1 - lines(count).point2);
            if(300< len && len < 500)
  % plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','green');
   color='green';% For Penalty line
            else
                plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
                color ='red';% outside line
            end
   end
   if(lines(count).theta < 0 && lines(count).rho < 0)
       len = norm(lines(count).point1 - lines(count).point2);
     if(280< len && len < 500)
   plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','yellow');  
   
   color='yellow';%side - penalty line ( D-box)
            else
   plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');    %side line
color='blue';
    end
       
   end



% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');

%end
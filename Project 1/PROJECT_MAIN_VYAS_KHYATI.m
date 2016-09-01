% @author: Khyati K.Vyas
function PROJECT_MAIN_VYAS_KHYATI(fn)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN THIS FILE WITH INPUT AS ANY OF THE FOLLOWING IMAGES  
% 20D.jpg
% 100D.jpg
% 100R.jpgF
% 50R.jpg
% 10R.jpg
% 500R.jpg
% 100RB.jpg
% 10RB.jpg
% 500RB.jpg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('../Images');

edge_Detection(fn);
contouring();
cropping_Image(fn);
histogram_Matched_Images();
histogram();

end

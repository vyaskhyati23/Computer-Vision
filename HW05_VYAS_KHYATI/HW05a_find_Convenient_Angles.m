% @author: Khyati K.Vyas
function HW05a_find_Convenient_Angles( )
    max_dist = 9;  
    % Learn about meshgrid…
    [dx,dy]= meshgrid( 0:max_dist, 0:max_dist );   
    %disp(dx);disp(dy);
    %MY COMMENTS: PRODUCES A GRID OF SIZE 10x10.
    
     
     angles=atan2d(dy,dx);
     disp(angles);
     %MY COMMENTS: atan2d gives angles directly in degrees.
     
     
      
     uniq_angles = unique(angles);
     disp(uniq_angles);
     % MY COMMENTS: GIVES ALL THE UNIQUE ANGLES FROM THE angles MATRIX BUT
     % IN SORTED ORDER (ASCENDING TO DESCENDING). SORTED ANGLES ARE NOW
     % STORED IN THE unique_angles MATRIX.
     
     
     figure('Position', [10 10 1024 768]);
     plot( uniq_angles, uniq_angles, 'bs' );
     %MY COMMENTS: PLOTS THE UNIQUE ANGLES ON A GRAPH.RANGE OF THE ANGLES
     %IS BETWEEN 0 AND 90 .
     % plot( uniq_angles, uniq_angles, 'bs' ); FIRST 2 PARAMETERS STAND FOR
     % THE SCALE OF THE GRAPH AND 'bs' STANDS FOR BLUE SQUARES.
     
     disp(length(uniq_angles));
     
 end
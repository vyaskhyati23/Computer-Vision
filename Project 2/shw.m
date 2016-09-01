function [opc,opr] = shw(img,mp,or,cnt,fn,ef,sf,opc,opr,DN)

%% draw lines
img(or(2)+1:or(2)+or(4),or(1)-1:or(1)+1)                 = 255;
img(or(2)+1:or(2)+or(4),or(1)-1:or(1)+1,2:3)             = 0;
img(or(2)+1:or(2)+or(4),or(1)+or(3)-1:or(1)+or(3)+1)     = 255;
img(or(2)+1:or(2)+or(4),or(1)+or(3)-1:or(1)+or(3)+1,2:3) = 0;
img(or(2)-1:or(2)+1,or(1)+1:or(1)+or(3))                 = 255;
img(or(2)-1:or(2)+1,or(1)+1:or(1)+or(3),2:3)             = 0;
img(or(2)+or(4)-1:or(2)+or(4)+1,or(1)+1:or(1)+or(3))     = 255;
img(or(2)+or(4)-1:or(2)+or(4)+1,or(1)+1:or(1)+or(3),2:3) = 0;
%% map
Im      = im2double(img);
Oi      = mp(or(2)+1:or(2)+or(4),or(1)+1:or(1)+or(3));
Im(1:or(4),1:or(3),:) = double(cat(3,Oi,Oi,Oi));
%% show
imshow(Im)

title([num2str(fn-sf+1),'/',num2str(ef-sf+1)])
drawnow
%% record & save output
opc(fn-sf+1,:) = cnt;
opr(fn-sf+1,:) = or;
if fn == ef                                            
savecnt = sprintf('%s%s%s',DN,'C','.mat');  % save centroid [x(col) y(row)]
saveor  = sprintf('%s%s%s',DN,'R','.mat');  % save rectangle 
save(savecnt,'opc')
save(saveor,'opr')
end

end

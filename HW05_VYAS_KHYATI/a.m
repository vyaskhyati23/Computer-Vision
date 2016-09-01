% @author: Khyati K.Vyas
function gray_cmap_322()

im=imread('TBK_Kite.JPG');
im1=rgb2gray(im);
a_332_cmap = gen_332_cmap( );

im_idx = rgb2ind( im1, a_332_cmap, 'nodither' );
imagesc( im_idx );
colormap( a_332_cmap );
axis image;
colorbar;
display='Using gen_332_cmap( ) on grayscale image: TBK_KITE.JPG';
title(display);

end
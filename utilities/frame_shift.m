function [im_cell, im_nocell, im_bf, shift] = frame_shift(fluor_cell, fluor_nocell, bf_cell,yn_pause,crop_size)

%%% Corrects for frame shift between the pre and post dissociation image
%%% Four rectanges are chosen in ares expected to be outside the area of
%%% deformation. A mean of the 3 cross corelations finds x and y shift
%%% from cell to no cell image at pixel resolution. Then applies shift and crops images
%%% appropriately
%%%
%%% inputs:
%%% fluor_cell: pre-dissociation fluorescent image
%%% fluor_nocell: post-dissociation fluorescent image
%%% bf_cell: phase or bright field image of cell island. Used to define areas away from cells
%%% yn_pause: sets if code will pause for user to place ROI rectanges
%%% dm: block size of output in displacement calculation, used for cropping 
%%% yn_pause to an appropriate size
%%%
%%% outputs:
%%% im_cell: shifted and cropped pre-dissociation fluorescent image
%%% im_nocell: shifted and cropped post-dissociation fluorescent image
%%% bf_cell: shifted and cropped phase or bright field image of cell island. 
%%% shift: [xshift yshift] applied to images in pixels

[h, w] = size(bf_cell); 
figure, imagesc(bf_cell);colormap gray;    % Show the original bright field image 

%Places four ROI rectangles of width and height set by dm at the corners of
%the image. The inican be changed
rect1 = imrect(gca, [.025*w .025*h w/8 h/8]);
rect2 = imrect(gca, [.85*w .85*h w/8 h/8]);
rect3 = imrect(gca, [.85*w .025*h w/8 h/8]);
rect4 = imrect(gca, [0.025*w .85*h w/8 h/8]);

if yn_pause == 'y' %let used move rectangles if desired, then hit any key to continue
pause; 
end

positions(1,:) = getPosition(rect1);
positions(2,:) = getPosition(rect2);
positions(3,:) = getPosition(rect3);
positions(4,:) = getPosition(rect4);
positions = round(positions);

close all

xs = [];   
ys = [];

for i = 1:size(positions,1)
    
x1 = positions(i,1);    
y1 = positions(i,2);
w1 = positions(i,3);    
h1 = positions(i,4);
ROI = imcrop(fluor_cell, [x1 y1 w1 h1]);

corr = normxcorr2(ROI,fluor_nocell);
[~, imax]    = max(corr(:));
[ypeak1, xpeak1]      = ind2sub(size(corr),imax(1));
xs(i) = xpeak1 - round(x1) - w1;
ys(i) = ypeak1 - round(y1) - h1;

end

xshift = round(mean(xs));
yshift = round(mean(ys));

im_cell = imtranslate(fluor_cell, [xshift yshift]);
im_nocell  = fluor_nocell;
im_bf  = imtranslate(bf_cell, [xshift yshift]);
shift = [xshift yshift];

im_cell = imcrop(im_cell,[xshift, yshift, size(im_cell,2), size(im_cell,1)]);
im_nocell = imcrop(im_nocell,[xshift, yshift, size(im_cell,2), size(im_cell,1)]);
im_bf = imcrop(im_bf,[xshift, yshift, size(im_cell,2), size(im_cell,1)]);

crop_size = floor(min(size(fluor_cell))/256)*256;
scrop = floor((size(im_cell) - crop_size)/2);

im_cell = im_cell(scrop(1):crop_size+scrop(1)-1,scrop(2):crop_size+scrop(2)-1);
im_nocell = im_nocell(scrop(1):crop_size+scrop(1)-1,scrop(2):crop_size+scrop(2)-1);
im_bf = im_bf(scrop(1):crop_size+scrop(1)-1,scrop(2):crop_size+scrop(2)-1);

end



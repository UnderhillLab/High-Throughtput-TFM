function [boundary_points,mask] = cell_boundary(im_bf, sigma, cny,di)

% Draws Boundary Around Cellular island using edge detection

% inputs:
% im_bf: bight field or phase contrast image used to draw cell/island
% boundary
% sigma: used for gaussian filter in blurring edges and smoothing sharp
% corners in boundary drawing
% cny: threshold used in canny edge filter process
% di: size of diamond used for erosion in boundary drawing process


% This program was produced at the University of Illinois, by Ian Berg in
% 2019. This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as
% published by the Free Software Foundation, either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


is = mat2gray(im_bf);
[h, wi] = size(im_bf);
offseth = ones(h,1)*median(is);
offsetv = median(is,2)*ones(1,wi);
offset = (offseth+offsetv)./2;
im_off = abs(is - 1*offset);
im_soft = im_off;
im_edge = double(edge(im_soft,'canny', cny));
im_fill = mat2gray(im_edge);
im_fill = imgaussfilt(im_fill,sigma);
im_fill = imbinarize(im_fill,.1);
im_fill= double(imfill(im_fill,'holes'));
im_fill = bwareaopen(im_fill,100);
im_fill = mat2gray(im_fill);
im_fill = imgaussfilt(im_fill,sigma);
seD = strel('diamond',di);
im_fill = imerode(im_fill,seD);
im_fill = imbinarize(im_fill, 0.5);
im_fill= imfill(im_fill,'holes');
im_fill = double(im_fill);

simp = bwareaopen(im_fill,1000);

[boundary_points,mask] = bwboundaries(simp,'noholes');

if isempty(boundary_points)
    boundary_points{1} = [1,1];      
else

end

function Im = imgaussfilt(I, sigma)

H = fspecial('gaussian', sigma/2, sigma);
Im = imfilter(I,H,'replicate');

end

end

function [data_rr] = rotate_and_center(phi, X, Y, im_size, data)

%phi is the rotation angle, counterclockwise from positive x axis
%rotation matrix to rotate an object phi, clockwise

R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ]; 

data_x = data{1};
data_y = data{2};

[imageHeight, imageWidth, ~] = size(data_x);
ratio = imageHeight./im_size(1);

centerX = floor(imageWidth/2);
centerY = floor(imageHeight/2);
X = floor(X);
Y = floor(Y);
dy = centerY-Y*ratio;
dx = centerX-X*ratio;

data_x_t = imtranslate(data_x,[dx, dy]);
data_x_r = imrotate(data_x_t, -phi*180/pi,'crop');

data_y_t = imtranslate(data_y,[dx, dy]);
data_y_r = imrotate(data_y_t, -phi*180/pi,'crop');

%reshape x and y matrices into a vector
N = size(data_x_r,1);
data_x_rv = reshape(data_x_r,[1,N^2]);
data_y_rv = reshape(data_y_r,[1,N^2]);
data_rv = [data_x_rv;data_y_rv];

%rotate vectors negative phi
data_rvr = R'*data_rv;

%shape back into matrix
data_x_rvr = data_rvr(1,:);
data_y_rvr = data_rvr(2,:);
data_rr{1} = reshape(data_x_rvr,[N,N]);
data_rr{2} = reshape(data_y_rvr,[N,N]);

end
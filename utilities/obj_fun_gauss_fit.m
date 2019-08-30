 function resids = obj_fun_gauss_fit(px,py,param,img)
 
 % peak position_x  xn
 % peak position_y  yn
 % amplitude        zn
 % width:           wn
 
  % initial param =[min(min(image)) ny/2, nx/2, max(max(image))/1.5, ny/2, nx/2]

zo = param(1); 
xn = param(2); 
yn = param(3); 
zn = param(4); 
wnx = param(5);
wny = param(6); 
theta = param(7);
transform=[cos(theta) sin(theta) 
    -sin(theta) cos(theta)];

size_p=size(px);
n=size_p(1);
m=size_p(2);

px1 = zeros(n, m);
py1 = zeros(n, m);

for i = 1:n
    for j = 1:m
        px1(i,j)=transform(1,:)*([px(i,j), py(i,j)]');
        py1(i,j)=transform(2,:)*([px(i,j), py(i,j)]');
    end
end

xp=transform(1,:)*([xn, yn])';
yp=transform(2,:)*([xn, yn])';
   
arg1 = (px1-xp).^2;
arg2=(py1-yp).^2;
arg=-arg1/wnx^2-arg2/wny^2;
resids = zo+zn*exp(arg) - img; %minimizing difference between new gaussian and IMAGE


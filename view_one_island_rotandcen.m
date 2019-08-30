function [t,u,cell_info] = view_one_island_rotandcen(cell_data,draw_bound)

    % View the bight field, displacement vector field, and traction filed
    % for a single island which has been roated and centered based on the
    % ellipse fit to the island;
    % 
    % Input: cell_data, a structure containing all of the data for a single
    % island. Alternatively, all_cell_data{i} where i is the index of an
    % island in the full data file from an image set
    % Output: t: traction data, u: displacement data, cell_info:
    % description of experiment and island

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

    t = cell_data.cell_tractions.rotated_tractions;
    u = cell_data.cell_displacements.rotated_displacements;
    cell_info = cell_data.cell_info;
     
    pixelsize = cell_data.cell_info.pixelsize;
    dm = cell_data.cell_info.dm;
    im_bf = im2double(cell_data.Images{3});
        
    ellipse_fit = cell_data.cell_boundaries.ellipse_fit;
    phi = ellipse_fit.phi;
    X0_in = ellipse_fit.X_center*pixelsize;
    Y0_in = ellipse_fit.Y_center*pixelsize;

    a = ellipse_fit.major_axis;
    b = ellipse_fit.minor_axis;
         
    boundary_points = cell_data.cell_boundaries.rotated_boundary_points;
    for i = 1:length(boundary_points)
        xrub{i} = boundary_points{i}(:,2).*pixelsize;
        yrub{i} = boundary_points{i}(:,1).*pixelsize;
    end
     
    [x,y] = meshgrid(dm:dm:size(t{1},1)*dm,dm:dm:size(t{1},2)*dm);
    xvec = dm:dm:max(max(x));
    yvec = dm:dm:max(max(y));
    xvec = (xvec).*pixelsize; xvec = xvec - mean(xvec);
    yvec = (yvec).*pixelsize; yvec = yvec - mean(yvec);
    x = x*pixelsize;x = x - mean(x(:));
    y = y*pixelsize;y = y - mean(y(:));
    fig_scale = [16 16];
  
    ver_line        = [ [0 0]; b*[-1 1] ];
    horz_line       = [ a*[-1 1]; [0 0] ];

    theta_r         = linspace(0,2*pi);
    ellipse_x_r     = a*cos( theta_r );
    ellipse_y_r     = b*sin( theta_r );
    ellipse = [ellipse_x_r;ellipse_y_r];
    
   [imageHeight, imageWidth, ~] = size(im_bf);
    centerX = floor(imageWidth/2);
    centerY = floor(imageHeight/2);
    el_X = floor(ellipse_fit.X_center);
    el_Y = floor(ellipse_fit.Y_center);
    dy = centerY-el_Y;
    dx = centerX-el_X;
    im_r = imtranslate(im_bf,[dx, dy]);
    im_r = imrotate(im_r, -phi*180/pi,'crop');
    im_r = im2double(im_r);      
    
    figure;
    % Brightfield with boundary and ellipse 
    subplot(2,2,4);
    imagesc(xvec, yvec, im_r)
    colormap gray
    hold on
    axis equal; axis tight; axis off;colorbar
    H = gca; set(H.Colorbar,'Visible','off');
                
   
    % Displacement Vector field image   
    subplot(2,2,2);
    data_xfig = imresize(u{1},fig_scale);
    data_yfig = imresize(u{2},fig_scale);
    xfig = imresize(x,fig_scale);
    yfig = imresize(y,fig_scale);
    ax = gca;
    hold on    
    surf(x,y,u{3}); 
    view(2); colormap(ax, jet); shading interp; colorbar;  
    mD = 10*max(max(sqrt(data_xfig.^2+data_yfig.^2)));
    h = quiver3(xfig,yfig,mD*ones(size(xfig)),data_xfig,data_yfig,zeros(size(xfig)));
    set(h,'Color','w','LineWidth',1);
    title('Displacement (um)')
    axis equal; axis tight; axis ij;axis off; colorbar
    
    % Traction Vector field image 
    subplot(2,2,3);
    data_xfig = imresize(t{1},fig_scale);
    data_yfig = imresize(t{2},fig_scale);
    xfig = imresize(x,fig_scale);
    yfig = imresize(y,fig_scale);
    ax = gca;
    hold on    
    surf(x,y,t{3}); 
    view(2); colormap(ax, jet); shading interp; colorbar;  
    mT = 10*max(max(sqrt(data_xfig.^2+data_yfig.^2)));
    h = quiver3(xfig,yfig,mT*ones(size(xfig)),data_xfig,data_yfig,zeros(size(xfig)));
    set(h,'Color','w','LineWidth',1);
    axis equal; axis tight; axis ij;axis off; colorbar
    colormap(gca, 'jet');
    hold on
    title('Traction (Pa)')
    axis equal; axis tight; axis off;colorbar
    
    experiment = cell_data.cell_info.experiment;
    date_ID = cell_data.cell_info.date_ID;
    young = num2str(cell_data.cell_info.young);
    soluble = cell_data.cell_info.soluble;
    dish_num = cell_data.cell_info.dish_num;
    time = cell_data.cell_info.time;
    arrayed_condition = cell_data.cell_info.arrayed_condition;
    image_number = cell_data.cell_info.image_number;
       
    annotation('textbox',...
    [.175 .61 .175 .3],...
    'String',{[experiment,' ',date_ID],[young, ' kPa'],...
    soluble, dish_num, time,arrayed_condition,['Island ' num2str(image_number)]},...
    'FitBoxToText','on','EdgeColor','none','HorizontalAlignment','center',...
    'FontUnits','normalized','FontSize',0.032);

%Draw boundaries if selected
    if draw_bound
    subplot(2,2,4);
        for i = 1:length(boundary_points)
        plot(xrub{i}, yrub{i}, 'y', 'LineWidth', 2)
        end
        plot( ver_line(1,:),ver_line(2,:),'r' );
        plot( horz_line(1,:),horz_line(2,:),'r' );
        plot(ellipse(1,:),ellipse(2,:),'r' );
    subplot(2,2,3);
        for i = 1:length(boundary_points)
        plot3(xrub{i}, yrub{i},mT*ones(size(xrub{i})), '-k', 'LineWidth', 2)
        end
    subplot(2,2,2);
        for i = 1:length(boundary_points)
        plot3(xrub{i}, yrub{i},mD*ones(size(xrub{i})), '-k', 'LineWidth', 2)
        end
    end
     
        

end
function [T,U,ellipse_axes] = summarize_islands(summary_table,fields)

    % Outputs and plots the averaged displacement and traction vector fields 
    % Takes as input the outputs of collect_island_data (summary_table and
    % fields) 
    % summary_table can be indexed on a variable to choose which islands
    % are included in the summary
    % outputs:
    % T, U average traction and displacements
    % average major and minor axes of the islands

    tractions = fields.tractions;
    displacements = fields.displacements;

    ind = summary_table.summ_ind(1);
    t = tractions{ind};
    u = displacements{ind};
    pixelsize = summary_table.pixelsize(1);
    dm = summary_table.dm(1);

    for j = 1:3

        T{j} = zeros(size(t{j}));
        U{j} = zeros(size(u{j}));

    end

    for i = 1:size(summary_table,1)

        ind = summary_table.summ_ind(i);
        t = tractions{ind};
        u = displacements{ind};

        for j = 1:3
        T{j} = T{j}+t{j};
        U{j} = U{j}+u{j};
        end

    end

    for j = 1:3
    T{j} = T{j}./size(summary_table,1);
    U{j} = U{j}./size(summary_table,1);
    end
    
    X0_in = 0;
    Y0_in = 0;
    major_axis = mean(summary_table.major_axis);
    minor_axis = mean(summary_table.minor_axis);
    a = major_axis;
    b = minor_axis;
    ellipse_axes = [major_axis;minor_axis];
        
    
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
    
    
     % Displacement Vector field image   
    subplot(1,2,1);
    data_xfig = imresize(U{1},fig_scale);
    data_yfig = imresize(U{2},fig_scale);
    xfig = imresize(x,fig_scale);
    yfig = imresize(y,fig_scale);
    ax = gca;
    hold on    
    surf(x,y,U{3}); 
    view(2); colormap(ax, jet); shading interp; colorbar;  
    mU = 10*max(max(sqrt(data_xfig.^2+data_yfig.^2)));
    h = quiver3(xfig,yfig,mU*ones(size(xfig)),data_xfig,data_yfig,zeros(size(xfig)));
    set(h,'Color','w','LineWidth',1);
    title('Displacement (um)')
    axis equal; axis tight; axis ij;axis off; colorbar
    
    % Traction Vector field image 
    subplot(1,2,2);
    data_xfig = imresize(T{1},fig_scale);
    data_yfig = imresize(T{2},fig_scale);
    xfig = imresize(x,fig_scale);
    yfig = imresize(y,fig_scale);
    ax = gca;
    hold on    
    surf(x,y,T{3}); 
    view(2); colormap(ax, jet); shading interp; colorbar;  
    mT = 10*max(max(sqrt(data_xfig.^2+data_yfig.^2)));
    h = quiver3(xfig,yfig,mT*ones(size(xfig)),data_xfig,data_yfig,zeros(size(xfig)));
    set(h,'Color','w','LineWidth',1);
    axis equal; axis tight; axis ij;axis off; colorbar
    colormap(gca, 'jet');
    hold on
    title('Traction (Pa)')
    axis equal; axis tight; axis off;colorbar
    

    subplot(1,2,1);
        plot3( ver_line(1,:)+X0_in,ver_line(2,:)+Y0_in,mU*ones(size(ver_line(2,:))),'k' );
        plot3( horz_line(1,:)+X0_in,horz_line(2,:)+Y0_in,mU*ones(size(ver_line(2,:))),'k' );
        plot3( ellipse(1,:)+X0_in,ellipse(2,:)+Y0_in,mU*ones(size(ellipse(2,:))),'k' );
    subplot(1,2,2);
        plot3( ver_line(1,:)+X0_in,ver_line(2,:)+Y0_in,mT*ones(size(ver_line(2,:))),'k' );
        plot3( horz_line(1,:)+X0_in,horz_line(2,:)+Y0_in,mT*ones(size(ver_line(2,:))),'k' );
        plot3( ellipse(1,:)+X0_in,ellipse(2,:)+Y0_in,mT*ones(size(ellipse(2,:))),'k' );
    
     
    
end
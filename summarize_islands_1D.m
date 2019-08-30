function [summary_table,R_avg,U_avg,T_avg, peak_T] = summarize_islands_1D(summary_table,fields)

    
    % Outputs and plots the averaged displacement as a function of 
    % Takes as input the outputs of collect_island_data (summary_table and
    % fields) 
    % summary_table can be indexed on a variable to choose which islands
    % are included in the summary
    % outputs:
    % T, U average traction and displacements
    % average major and minor axes of the islands

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


    tractions = fields.tractions;
    displacements = fields.displacements;

    RRv = [];
    UUv = [];
    TTv = [];
    
    for i = 1:size(summary_table,1)
        
        ind = summary_table.summ_ind(i);
        rad = (summary_table.major_axis(i)+summary_table.minor_axis(i))/2;
        pixelsize = summary_table.pixelsize(i);
        dm = summary_table.dm(i);
        t = tractions{ind}{3};
        u = displacements{ind}{3};
        [x,y] = meshgrid(0:dm:size(t,1)*dm-dm,0:dm:size(t,2)*dm-dm);
        x = x-mean(mean(x));
        y = y - mean(mean(y));
        r = (x.^2+y.^2).^(1/2);
        r = r.*pixelsize;
        r = r./rad; %NOTE Remove this line if you do not want to normalize against the island radius
        s = size(r,2);
        Rv{i} = round(100.*reshape(r,[s^2,1]))./100;
        Uv{i} = [Rv{i} reshape(u,[s^2,1])];
        Tv{i} = [Rv{i} reshape(t,[s^2,1])];
        
        [Rv_avg{i},~,idx] = unique(Rv{i});
        Uv_avg{i} = [Rv_avg{i},accumarray(idx,Uv{i}(:,2),[],@mean)];
        Tv_avg{i} = [Rv_avg{i},accumarray(idx,Tv{i}(:,2),[],@mean)];
        Pk_Tv_avg(i,1) = max(Tv_avg{i}(:,2));
        
       
        RRv = [RRv;Rv{i}];
        UUv = [UUv;Uv{i}];
        TTv = [TTv;Tv{i}];
              
    end

[R_avg,~,idx] = unique(RRv(:,1));
U_avg = [R_avg,accumarray(idx,UUv(:,2),[],@mean)];
T_avg = [R_avg,accumarray(idx,TTv(:,2),[],@mean)];
U_std = [R_avg,accumarray(idx,UUv(:,2),[],@std)];
T_std = [R_avg,accumarray(idx,TTv(:,2),[],@std)];

T_avg = [T_avg T_std(:,2)];

peak_T = max(T_avg(:,2));
summary_table.Peak_Traction = Pk_Tv_avg;
    
end
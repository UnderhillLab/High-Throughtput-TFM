
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

%% View displacement and traction for one island
load('data out\110717_BMEL Mechano_30kPa_72_DMSO_D1_2.mat')
cell_data = all_cell_data{17};
[t,u,cell_info] = view_one_island(cell_data,true);
[t,u,cell_info] = view_one_island_rotandcen(cell_data,true);

%% View averaged displacement and traction for a set of islands
[fields,summary_table] = collect_island_data('110717_BMEL Mechano_30kPa_72_DMSO_D1_2.mat');
plot_table = summary_table(summary_table.arrayed_condition == "JAG1",:);
[T,U,ellipse_axes] = summarize_islands(plot_table,fields);


%% Plot radial profile of a set of islands
ar_con = unique(summary_table.arrayed_condition);
figure; hold on
for i = 1:length(ar_con)
plot_table = summary_table(summary_table.arrayed_condition == ar_con{i},:);
[~,R_avg,U_avg,T_avg,peak_T] = summarize_islands_1D(plot_table,fields);

subplot(1,4,i);hold on
plot(T_avg(:,1),T_avg(:,2),'b-')
plot(T_avg(:,1),T_avg(:,2)+T_avg(:,3),'b--')
plot(T_avg(:,1),T_avg(:,2)-T_avg(:,3),'b--')
xlim([0,1.2]);ylim([0,150]);axis square;
xlabel('R');
title(ar_con{i})

end
subplot(1,4,1);ylabel('Traction (Pa)');

function [fields,summary_table] = collect_island_data(varargin)

    % Collect the data from multiple data output files into a table
    % containing summary data and fields which contain the
    % traction/displacemnet field data
    % 
    % Input: If no input, user is prompted to select files to load with
    % multiselect
    % Can also pass a cell with a list of file names. All files must be in
    % the data out folder, or the code must be altered
    %
    % Output: 
    % summary_table: a table containg the information and summary
    % data from all islands loaded from the files loaded. see protocol documentation for full explanation of all outputs
    % description of experiment and island
    % fields: structure with fields for tractions and displacements. Data
    % indexed accorinding to trhe summ_ind field in the summary table   


    if nargin == 0
        [files,path] = uigetfile('*.mat','MultiSelect', 'on');
        if ~iscell(files)
            files = {files};
        end
    else
        files = varargin{1};
        if ~iscell(files)
        files = {files};
        end
        path = 'data out\'; %change this to use a different folder holding the data files
    end
    
    summ_ind = 0;

    for file_ind = 1:length(files)
        
        full_file = [path,files{file_ind}];
        load(full_file);
        
        for is_ind = 1:length(all_cell_data)
            
            summ_ind = summ_ind + 1;
            
            cell_data = all_cell_data{is_ind};
            cell_info = cell_data.cell_info;
            tab_is_ind = struct2table(cell_info);
            
            t = cell_data.cell_tractions.rotated_tractions;
            u = cell_data.cell_displacements.rotated_displacements;
            
            tab_is_ind.file_ind = is_ind;
            tab_is_ind.major_axis = cell_data.cell_boundaries.ellipse_fit.major_axis;
            tab_is_ind.minor_axis = cell_data.cell_boundaries.ellipse_fit.minor_axis;
            tab_is_ind.RMS = cell_data.cell_tractions.RMS;
            tab_is_ind.RMS_int = cell_data.cell_tractions.RMS_int;
            tab_is_ind.Strain_Energy = cell_data.cell_tractions.Strain_Energy;
            tab_is_ind.summ_ind = summ_ind;
            
            fields.tractions{summ_ind} = t;
            fields.displacements{summ_ind} = u;
                        
            for i = 1:size(tab_is_ind,2)
            island_info{1,i} = convertCharsToStrings(tab_is_ind{1,i});
            end
                    
            if summ_ind == 1
               row_names = tab_is_ind.Properties.VariableNames;
                for i = 1:size(island_info,2)
                varTypes{i} = class(island_info{i});
                end
                summary_table = table('Size',size(island_info),'VariableTypes',varTypes,'VariableNames',row_names);
            end
             
            summary_table(summ_ind,:) = cell2table(island_info);
                                   
        end
        
    end
    
end
            
            
 


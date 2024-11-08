% Pipeline for the minimal data pre-processing
% Including:
% 1. Loading
% 2. Bandpass filter
% 3. Re-reference to the ref channel X3
% 4. Convert to cvs for further analysis in Python

% Load eeglab set from the one created earlier
eeglab;
data_folder = 'D:\BCI\HaLT\';
file_list = dir(fullfile(data_folder, '*.set'));
% Loop through each .set file 
for i = 1:length(file_list)
    set_name = file_list(i).name;
     
    EEG = pop_loadset('filename', set_name, 'filepath', data_folder);
    
    % Bandpass & notch filtering 
    low_cutoff = 0.5; high_cutoff = 70;
    EEG = pop_eegfiltnew(EEG, 'locutoff', low_cutoff, 'hicutoff', high_cutoff); 
    EEG = pop_eegfiltnew(EEG, 'locutoff', 49, 'hicutoff', 51, 'revfilt', 1);  % Notch 
    
    % Re-reference the data to the channel X3
    EEG = pop_reref(EEG, find(strcmp({EEG.chanlocs.labels}, 'X3')));  
    
    % Save for export in csv
    if set_name(end-20:end-4) == 'StLRHandLegTongue'
        csv_filename = [set_name(1:end-21) '_min_proc.csv'];
    else
        disp(['hey check out the file names: ' set_name]);
        csv_filename = [set_name(1:end-4) '_min_proc.csv'];
    end
    
    writematrix( EEG.data', [data_folder csv_filename]);
end
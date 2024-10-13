% Pipeline for the data pre-processing
% Including:
% 1. Loading
% 2. Bandpass filter
% 3. Re-reference to the ref channel X3
% 3. Artifact correction / rejection
% ---- need to decide btw correction and rejection
% 3.1. Eye blinks
% 3.2. Movements 
% 4. Convert to cvs or json for further analysis in Python

% Load eeglab set from the one created earlier
eeglab;
data_folder = 'D:\BCI\large_eeg_19ch_13subj';
set_name = 'SubjectJ_LRHand.set'; % need to make universal later
EEG = pop_loadset('filename', set_name, 'filepath', data_folder);

% Bandpass & notch filtering 
low_cutoff = 0.5; high_cutoff = 70;
EEG = pop_eegfiltnew(EEG, 'locutoff', low_cutoff, 'hicutoff', high_cutoff); 
EEG = pop_eegfiltnew(EEG, 'locutoff', 49, 'hicutoff', 51, 'revfilt', 1);  % Notch 

% Re-reference the data to the channel X3
EEG = pop_reref(EEG, find(strcmp({EEG.chanlocs.labels}, 'X3')));  

% clean data using the clean_rawdata plugin
EEG = pop_clean_rawdata( EEG,'FlatlineCriterion',5,'ChannelCriterion',0.87, ...
    'LineNoiseCriterion',4,'Highpass',[0.25 0.75] ,'BurstCriterion',20, ...
    'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian', ...
    'WindowCriterionTolerances',[-Inf 7] ,'fusechanrej',1);

% Run Independent Component Analysis (ICA) to correct for artifacts
EEG = pop_runica(EEG, 'extended', 1);

% run ICLabel and flag artifactual components
EEG = pop_iclabel(EEG, 'default');
EEG = pop_icflag( EEG,[NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);

% Save for export in csv
csv_filename = [set_name '_reg_proc.csv'];
writematrix( EEG.data', [data_folder csv_filename]);

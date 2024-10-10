% Pipeline for the data pre-processing
% Including:
% 1. Loading
% 2. Bandpass filter
% 3. Re-reference to the ref channel X3
% 3. Artifact correction / rejection
% 3.1. Eye blinks
% 3.2. Movements 
% 4. Convert to cvs or json for further analysis in Python

% Load eeglab set from the one created earlier
eeglab;
data_folder = 'D:\BCI\large_eeg_19ch_13subj';
set_name = 'SubjectJ_LRHand.set'; % need to make universal later
EEG = pop_loadset('filename', set_name, 'filepath', data_folder);

% Bandpass filtering (e.g., between 1 and 50 Hz)
EEG = pop_eegfiltnew(EEG, 'locutoff', 1, 'hicutoff', 50);  % 1-40 Hz bandpass filter

% Re-reference the data to the channel
EEG = pop_reref(EEG, find(strcmp({EEG.chanlocs.labels}, 'X3')));  % Use [] for average reference

% Run Independent Component Analysis (ICA) to correct for artifacts
EEG = pop_runica(EEG, 'extended', 1);  % Extended ICA

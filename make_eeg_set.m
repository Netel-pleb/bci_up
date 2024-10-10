<<<<<<< HEAD
% Load the data
data_folder = 'D:\BCI\large_eeg_19ch_13subj\';
subj_file = 'CLA-SubjectJ-170504-3St-LRHand-Inter.mat';  % test for 1 subject for now

load([data_folder subj_file]);  % Load the dataset
eeglab;
EEG = eeg_emptyset(); % Create an empty EEG structure for EEGLAB

% Fill in the relevant fields from the structure wisely named as 'o'
EEG.setname = o.id;                 % Use the ID as the dataset name
EEG.srate = o.sampFreq;             % Sampling frequency
EEG.data = o.data';                 % EEG data (transposed for EEGLAB compatibility)
EEG.nbchan = size(o.data, 2);       % Number of channels
EEG.pnts = size(o.data, 1);         % Number of time points
EEG.trials = 1;                     % Assume continuous data for now
EEG.xmin = 0;                       % Start time 
EEG.xmax = (EEG.pnts - 1) / EEG.srate;  % End time in seconds
EEG.times = linspace(EEG.xmin, EEG.xmax, EEG.pnts);  % Time vector

% Add channel labels
EEG.chanlocs = struct('labels', o.chnames);

% Create the event structure from markers
EEG.event = [];
for i = 1:length(o.marker)
    EEG.event(i).type = num2str(o.marker(i));  % Marker code as string
    EEG.event(i).latency = i;                  % Event latency (sample index)
end

% Finalize the EEG structure
EEG = eeg_checkset(EEG);

% Plot the data to verify it's loaded correctly
pop_eegplot(EEG, 1);

% Save the EEG dataset to EEGLAB format
EEG = pop_saveset(EEG, 'filename', 'SubjectJ_LRHand.set', 'filepath', data_folder);

=======
% Load the data
data_folder = 'D:\BCI\large_eeg_19ch_13subj\';
subj_file = 'CLA-SubjectJ-170504-3St-LRHand-Inter.mat';  % test for 1 subject for now

load([data_folder subj_file]);  % Load the dataset
eeglab;
EEG = eeg_emptyset(); % Create an empty EEG structure for EEGLAB

% Since the name of the last channel is missing from the data:
o.chnames{end+1} = 'X3';

% Fill in the relevant fields from the structure wisely named as 'o'
EEG.setname = o.id;                 % Use the ID as the dataset name
EEG.srate = o.sampFreq;             % Sampling frequency
EEG.data = o.data';                 % EEG data (transposed for EEGLAB compatibility)
EEG.nbchan = size(o.data, 2);       % Number of channels
EEG.pnts = size(o.data, 1);         % Number of time points
EEG.trials = 1;                     % Assume continuous data for now
EEG.xmin = 0;                       % Start time 
EEG.xmax = (EEG.pnts - 1) / EEG.srate;  % End time in seconds
EEG.times = linspace(EEG.xmin, EEG.xmax, EEG.pnts);  % Time vector

% Add channel labels
EEG.chanlocs = struct('labels', o.chnames);

% Create the event structure from markers
EEG.event = [];
for i = 1:length(o.marker)
    EEG.event(i).type = num2str(o.marker(i));  % Marker code as string
    EEG.event(i).latency = i;                  % Event latency (sample index)
end

% Finalize the EEG structure
EEG = eeg_checkset(EEG);

% Plot the data to verify it's loaded correctly
pop_eegplot(EEG, 1);

% Save the EEG dataset to EEGLAB format
EEG = pop_saveset(EEG, 'filename', 'SubjectJ_LRHand.set', 'filepath', data_folder);

>>>>>>> 9f810a4 (add the reference channel name)
disp('EEG data loaded, structure created, and dataset saved successfully yay!');
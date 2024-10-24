CREATE TABLE IF NOT EXISTS eeg_data (
    recording_key SERIAL PRIMARY KEY,         -- Auto-incrementing primary key
	recording_name TEXT[] NOT NULL,         -- Recording name from file name
    subject CHAR(1) NOT NULL,         -- Single letter for subject ID
    task_type TEXT[] NOT NULL,           -- HaLT, CLA or FREE 
    eeg_data FLOAT[] NOT NULL,            -- Actual EEG voltage time series
    sampling_rate FLOAT NOT NULL,          -- Sampling frequency of recording in Hz: 200 or 1000
    channel_names TEXT[] NOT NULL,             -- Array for channel names 
    event_starts INTEGER NOT NULL,           -- Event times as index of the EEG array
    event_durations INTEGER NOT NULL,          -- Event durations in frames
    event_type INTEGER NOT NULL          -- 1: L hand MI, 2: R hand MI, 3: passive, 4: L leg MI, 5: tongue MI, 6: R leg MI
);

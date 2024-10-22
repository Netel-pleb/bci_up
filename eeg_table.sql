CREATE TABLE eeg_data (
    trial_id SERIAL PRIMARY KEY,         -- Auto-incrementing primary key
    subject_id CHAR(1) NOT NULL,         -- Single letter for subject ID
    task_type TEXT[] NOT NULL,           -- Character array for task type
    voltage FLOAT[] NOT NULL,            -- Array to store voltage time series
    sample_rate FLOAT NOT NULL,          -- Frequency of recording in Hz
    channel TEXT[] NOT NULL,             -- Array for channel names or numbers
    timestamp TIMESTAMPTZ DEFAULT NOW()  -- Timestamp of the recording
);

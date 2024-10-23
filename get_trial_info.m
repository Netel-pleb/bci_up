function [event_types, event_starts, event_durations] = get_trial_info(trial_markers)
    % Get the starts and ends of events & compute durations from that
    event_starts = find(diff([0; trial_markers]) > 0);
    event_ends = find(diff([0; trial_markers]) < 0);
    event_durations = event_ends-event_starts;
    % get the event types
    event_types = trial_markers(event_starts);
end

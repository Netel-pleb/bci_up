% check the length of each trial
% damn i wrote better code than my ai overlord
    event_starts = find(diff([0; trial_markers]) > 0);
    event_ends = find(diff([0; trial_markers]) < 0);
    event_durations = event_ends-event_starts;
    event_types = trial_markers(event_starts);
    


% %
% trial_markers = o.marker;
% save("trial_markers.mat","trial_markers");
% trial_type = 0; trial_ongoing = false;
% trial_dur = 0;
% for m = trial_markers
%     if m ~= 0
%         trial_type = m;
%         trial_ongoing = true;
%         trial_dur = trial_dur + 1;
%     end
% end
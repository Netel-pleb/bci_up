% Assume 'myXYZ' is your 64x3 double array
% Normalize each coordinate to have a unit length
myXYZ = eeg.psenloc;
norms = sqrt(sum(myXYZ.^2, 2));
myXYZ_norm = myXYZ ./ norms;

% Load standard 10-10 electrode locations
standardChanlocs = readlocs('Standard-10-10-Cap33.ced');

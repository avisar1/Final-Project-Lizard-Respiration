%run brfore using EVM
% Build matlabPyrTools
fprintf('Building matlabPyrTools...\n');
run(fullfile('matlabPyrTools', 'Mex', 'compilePyrTools.m'));


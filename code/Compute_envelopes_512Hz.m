clear;clc

clear; clc
addpath(genpath(''))
origDir ='audios\';
outdir ='ENVELOPES_3sec_512\';
addpath(genpath('\Documents\brainstorm3'));
brainstorm nogui

cd([origDir]);fname = dir();
fname(1:2) =[]; 
%fname(2:17) =[];
for i = 1:length(fname)
origDir =['audios\' fname(i).name];
% key parameters
norm = 1; % normalize volume (1|0)
fs = 22050;
fq = .2:.2:50; % 32 cf
cd([origDir]); stim = dir('*.wav');stim = dir('*.wav');
nfilt = 32;
X1  = NaN(length(stim),     25000);
stim_name = {};
outdir2 =['ENVELOPES_3sec_512\' fname(i).name];

for j0 = 1:length(stim)
    stim_name{j0} = stim(j0).name;

    % load data - mono - normalize volume
    [in, sr] = audioread(stim(j0).name);
    if sr ~= fs; fprintf('problem'); pause; end
    in = in(:,1);
    if norm == 1; in=in./sqrt(mean(in.^2)); end

    % a. compute envelope w. vocoder - resample - sum env
    [env, ~, ~, deltan] = vocoder(in, 80, nfilt, 1, fs); % env
    env = sum(env, 1); % group filters        
    env = env(max(deltan+1):end); % remove delay   
  
    fstf = 512; xcut = 2;
    O  = [];
        O.Method      = 'morlet'; O.Output = 'all'; O.Comment = 'acousticTF';
        O.ListFiles   = []; O.iTargetStudy = []; O.TimeVector = []; % in ms
        O.SensorTypes = []; O.RowNames = {1:length(fq)}; O.Freqs = fq;
        O.TimeBands   = []; O.MorletFc = 1; O.MorletFwhmTc = 3;
        O.Measure     = 'power'; O.ClusterFuncTime = 'none';
    tfenv =resample(env,fstf,fs);
    n = length(tfenv);
    X1(j0,1:n) = tfenv; % group filters
    clear in sr  env n
end
save([outdir2 '_env.mat'],      'X1', 'stim_name')
end
%end %looping through folders
% Mindfulness Number Sequence Task Generator
function Mindfulness_Memory_Task_Gen(run)
% Generate a random sequence of 6 digits.
% Create sequence and experimental parameters.

%% Set parameters

% Timing
seqDur = 6; %(seconds) duration the sequence is displayed
iti = 2; % (seconds) inter-trial interval time
ibi = 10; % (min) time between blocks; testing: 0.1667min exp: 10min

% Trials
trialsPerBlock = 10; %number of trials per block; testing: 1 exp: 10
numBlocks = 2; %number of blocks
numTrials = numBlocks*trialsPerBlock; %total number of trials

% Sequence Numbers
numDig = 6; %number of digits in a sequence
maxNum = 9; %max digit possible to be displayed

%% Generate sequences
numSeq = round(maxNum*rand(numTrials, numDig));
% responses = nan(numTrials,numDig);

%% Store parameters
param.seqDur = seqDur/numDig;
param.numBlocks = numBlocks;
param.numDig = numDig;
param.iti = iti;
param.ibi = ibi;
param.trialsPerBlock = trialsPerBlock;
param.numTrials = numTrials;


%% Store trial info
trials.numSeq = numSeq;

%% Save sequences
save(['stimuli/MMT_Seq' num2str(run)], 'trials', 'param')

% Mindfulness Number Sequence Task Generator
function Mindfulness_Memory_Task_Gen(run)
% Generate a random sequence of 6 digits.
% Create sequence and experimental parameters.

%% Set parameters

% Timing
seqDur = 6; %seconds the sequence is displayed
iti = 3; %inter-trial interval (seconds)
ibi = 10; % time between blocks

% Trials
trialsPerBlock = 10; %number of trials per block
numBlocks = 1; %number of blocks
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
param.ibi = ibi;
param.trialsPerBlock = trialsPerBlock;
param.numTrials = numTrials;


%% Store trial info
trials.numSeq = numSeq;

%% Save sequences
save(['MMT_Seq' num2str(run)], 'trials', 'param')

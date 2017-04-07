% Mindfulness Number Sequence Task Generator
function Mindfulness_Memory_Task_Gen(run)
% Generate a random sequence of 6 digits.
% Create sequence and experimental parameters.

%% Set parameters
seqDur = 6; %seconds the sequence is displayed
iti = 3; %inter-trial interval (seconds)
numBlocks = 2; %number of blocks
exp_ibi = 10; %inter-block interval (minutes) mindfulness group training
ctrl_ibi = 5; %inter-block interval (minutes) control group break
trialsPerBlock = 5; %number of trials per block
numTrials = numBlocks*trialsPerBlock; %total number of trials
numDig = 6; %number of digits in a sequence
maxNum = 9; %max digit possible to be displayed

%% Generate sequences
numSeq = round(maxNum*rand(numTrials, numDig));
responses = nan(numTrials,numDig);

%% Store parameters
param.seqDur = seqDur/numDig;
param.iti = iti;
param.numBlocks = numBlocks;
param.exp_ibi = exp_ibi;
param.con_ibi = ctrl_ibi;
param.trialsPerBlock = trialsPerBlock;
param.numTrials = numTrials;
param.numDig = numDig;
param.maxNum = maxNum;
%% Store trial info
trials.numSeq = numSeq;

%% Save sequences
save(['MMT_Seq' num2str(run)], 'trials', 'param')

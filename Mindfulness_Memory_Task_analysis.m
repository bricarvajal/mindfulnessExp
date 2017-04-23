% Mindfulness Memory Task Analysis
function Mindfulness_Memory_Task_analysis(subj, run)

load(['data/MMT_' num2str(subj) '_' num2str(run) '.mat'])

matCorrect = nan(param.trialsPerBlock,param.numDig,param.numBlocks);
currTrial = 1;
for iBlock = 1:param.numBlocks
    for iTrial = 1:param.trialsPerBlock
        for iNum = 1:param.numDig
            if trials.responses(currTrial,iNum) == trials.numSeq(iTrial, iNum)
                correct = 1;
            elseif trials.responses(currTrial,iNum) ~= trials.numSeq(iTrial, iNum)
                correct = 0;
            end
            matCorrect(iTrial, iNum, iBlock) = correct;
        end
        currTrial = currTrial + 1;
    end
end

data.matCorrect = matCorrect;

sumCorrect = sum(matCorrect,2);

percCorrectPerTrial = sumCorrect./param.numDig;
data.percCorrectPerTrial = percCorrectPerTrial;

perCorrectExp = mean(percCorrectPerTrial);
data.perCorrectExp = perCorrectExp;

save(['analysis/MMT_' num2str(subj) '_' num2str(run) '_data'], 'trials', 'param', 'data')


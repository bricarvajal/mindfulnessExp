% Mindfulness Memory Task Analysis
function Mindfulness_Memory_Task_analysis(subj, run)

load(['data/MMT_' num2str(subj) '_' num2str(run)])

matCorrect = nan(size(trials.numSeq));

for iTrial = 1:param.numTrials
    for iNum = 1:param.numDig
        if trials.responses(iTrial,iNum) == trials.numSeq(iTrial, iNum)
            correct = 1;
        else
            correct = 0;
        end
        matCorrect(iTrial, iNum) = correct;
    end
end

data.matCorrect = matCorrect;

sumCorrect = sum(matCorrect,2);

percCorrectPerTrial = sumCorrect./param.numDig;
data.percCorrectPerTrial = percCorrectPerTrial;

perCorrectExp = mean(percCorrectPerTrial);
data.perCorrectExp = perCorrectExp;

save(['MMT_' num2str(subj) '_' num2str(run) '_data'], 'trials', 'param', 'data')


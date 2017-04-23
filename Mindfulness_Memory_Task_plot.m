% Mindfulness Memory Task plot

function Mindfulness_Memory_Task_plot(numSubj, run)

% subjNames = input('Enter subject names as a string, each separated by commas: ');
for n = 1:numSubj
    load(['analysis/MMT_yoloo' num2str(n) '_' num2str(run) '_data.mat'])  
    allData(:,n) = squeeze(data.perCorrectExp);
end

ylims = [0 1];
figure
bar(allData)
% set(gca,'XTickLabel', {['subj' num2str(n)]})
ylabel('proportion correct')
ylim(ylims)
title('per block')
%title()

figure
bar(allData')
ylabel('proportion correct')
ylim(ylims)
title('per subject')


end



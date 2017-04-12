% Mindfulness Number Sequence Task Experiment
function Mindfulness_Memory_Task_Exp(subj, run)

load(['stimuli/MMT_Seq' num2str(run)])
subjGroup = ''; %Options: 'experimental' 'control'

switch subjGroup
    case 'experimental'
        % loads audio, 10 minute mindfulness audio (black screen)
        audioFileName = 'audiofile';
        [y,Fs] = audioread(audioFileName);
        InitializePsychSound(1)
        PsychPortAduio('Open', [], [], 2, Fs, 1)
        
        
    case 'control'
        % no audio; 10 minute block
        
end

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Reponse statement
respText = 'Enter the sequence.\n Press ENTER/RETURN when done.';
endText = 'All done, \n thank you for your participation.\n Press any key to exit.';
retryText = ['You did not enter ' num2str(param.numDig) '.\n Please enter '...
    num2str(param.numDig)  ' digits.'];

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 50);
Screen('TextFont', window, 'Courier');

for iTrial = 1:param.numTrials
    for iNum = 1:param.numDig
        curr_num = num2str(trials.numSeq(iTrial, iNum));
        % Draw number sequence
        DrawFormattedText(window, curr_num, 'center', 'center', black);
        % Flip to the screen
        Screen('Flip', window);
        pause(param.seqDur);      
    end
    if iNum == param.numDig
        DrawFormattedText(window, respText, 'center', 'center', black);
    %   [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([deviceNumber]);
        Screen('Flip', window);
        response = input('user input: ', 's');
        response = response - '0';
        while length(response) ~= param.numDig
            DrawFormattedText(window, retryText, 'center', 'center', black);
            Screen('Flip', window);
            response = input('retry user input: ', 's');
            response = response - '0';
        end
        trials.responses(iTrial,:) = response;
    end
end

save(['data/MMT_' num2str(subj) '_' num2str(run)], 'trials', 'param')

DrawFormattedText(window, endText, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;
sca;


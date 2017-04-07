% Mindfulness Number Sequence Task Experiment
function Mindfulness_Memory_Task_Exp(subj, run)

load(['MMT_Seq' run])
subjGroup = ''; %Options: 'experimental' 'control'

switch subjGroup
    case 'experimental'
        
    case 'control'
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
respText = 'Enter the sequence.';

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Courier');

for trial = 1:length(numSeq)
    % Draw number sequence
    DrawFormattedText(window, numSeq(trial,:), 'center', 'center', black);
    % Flip to the screen
    Screen('Flip', window);
    pause(param.seqDur);
    DrawFormattedText(window, respText, 'center', 'center', black);
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([deviceNumber]);
    Screen('Flip', window);
    response = 0;
    responses(trial) = response;
end

save(['MMT_' num2str(subj)], responses)
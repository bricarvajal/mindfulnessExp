% Mindfulness Number Sequence Task Experiment
function Mindfulness_Memory_Task_Exp(subj, run)

%% Initialization of Files
load(['stimuli/MMT_Seq' num2str(run)])
subjGroup = 'experimental'; %Options: 'experimental' 'control'
param.subjGroup = subjGroup;

% Change subject's group here
switch subjGroup
    case 'experimental'
        % loads audio, 10 minute mindfulness audio (black screen)
        wavfilename = 'stimuli/DW_Breath_Sound_Body_Meditation.wav';
        audioText = 'Please listen to the following meditation audio.';
    case 'control'
        wavfilename = 'stimuli/MarkBittmanTEDTalkClip.wav';
        audioText = 'Please listen to the following audio.';
end

%% Initialize Audio
InitializePsychSound;
[y, freq] = psychwavread(wavfilename);
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows == number of channels.
pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
soundAmp = 1;
% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', pahandle, wavedata);
timer = param.ibi*60; %(s)

%% Initialize Screens

Screen('Preference', 'SkipSyncTests', 1);

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

%% Texts
% Reponse statement
respText = 'Enter the sequence.\n Press ENTER/RETURN when done.';
endText = 'All done, \n thank you for your participation.\n Press any key to exit.';
retryText = ['You did not enter ' num2str(param.numDig) '.\n Please enter '...
    num2str(param.numDig)  ' digits.'];

% Text size and font
Screen('TextSize', window, 44);
Screen('TextFont', window, 'Arial');

%% Welcome screen

welcomeSecs = 5; %(s) How long the welcome screen is up. testing: 5 exp: 15
for n = 1:welcomeSecs
    welcomeText = ['Welcome to the experiment.\n Each trial you will be presented a sequence of numbers.\n When prompted, enter the sequence of numbers you were presented.\n The session will begin in ' num2str(welcomeSecs) ' seconds.'];
    DrawFormattedText(window, welcomeText, 'center', 'center', black);
    Screen('Flip', window);
    pause(1);
    welcomeSecs = welcomeSecs - 1;
end

% Delay before first trial
Screen('FillRect',window, grey)
Screen('Flip', window);
pause(2)

% Next block screen
nextText = 'The next block of trials will begin shortly.';


%% TRIAL STARTS HERE
currTrial = 1; %initialize trials completed
for iBlock = 1:param.numBlocks
    
    %after 1st block is complete run the 10min training or break
    if iBlock == param.numBlocks
        switch subjGroup
            case 'experimental'
                % Start audio playback for 'repetitions' repetitions of the sound data,
                % start it immediately (0) and wait for the playback to start, return onset
                % timestamp.
                DrawFormattedText(window, audioText, 'center', 'center', black);
                Screen('Flip', window);
%                 pause(4);
%                 Screen('FillRect',window, grey)
%                 Screen('Flip', window);
                t1 = PsychPortAudio('Start', pahandle, 0, 0, 1);
                while timer > 0
%                     DrawFormattedText(window, num2str(round(timer), 'center', 'center', black);
%                     Screen('Flip', window);
                    pause(1)
                    timer = timer - 1;
                end
                PsychPortAudio('Stop', pahandle, 1);
            case 'control'
                % Start audio playback for 'repetitions' repetitions of the sound data,
                % start it immediately (0) and wait for the playback to start, return onset
                % timestamp.
                DrawFormattedText(window, audioText, 'center', 'center', black);
                Screen('Flip', window);
%                 pause(4);
%                 Screen('FillRect',window, grey)
%                 Screen('Flip', window);
                t1 = PsychPortAudio('Start', pahandle, 0, 0, 1);
                while timer > 0
%                     DrawFormattedText(window, num2str(round(timer)), 'center', 'center', black);
%                     Screen('Flip', window);
                    pause(1)
                    timer = timer - 1;
                end
                PsychPortAudio('Stop', pahandle, 1);
%                 % timer
%                 % Here is our drawing loop
%                 for iN = timer:-1:1
%                     % Convert our current number to display into a string
%                     timer = iN;
%                     timerString = ['break timer: ' num2str(round(timer))];
% 
%                     % Draw our number to the screen
%                     DrawFormattedText(window, timerString, 'center', 'center', black);
% 
%                     % Flip to the screen
%                     Screen('Flip', window);
%                     pause(1);
%                 end
        end
        DrawFormattedText(window, nextText, 'center', 'center', black);
        Screen('Flip', window);
        pause(4)
        Screen('FillRect',window, grey)
        pause(3) 
    end
    
    % run number sequence
    for iTrial = 1:param.trialsPerBlock
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
            trials.responses(currTrial,:) = response;
            currTrial = currTrial + 1;
        end
    end
end

%% Saving responses

save(['data/MMT_' num2str(subj) '_' num2str(run)], 'trials', 'param')

DrawFormattedText(window, endText, 'center', 'center', black);
Screen('Flip', window);
PsychPortAudio('Close');
KbStrokeWait;
sca;


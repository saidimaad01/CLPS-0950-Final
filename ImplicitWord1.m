% Edited by Imaad Said, 4/29/2022 at 1:30
%Edited by Imaad Said, 5/02/2022 at 3:00
% Edited by Imaad Said, 5/03/2022 at 10:00

% Clear the workspace and the screen
sca;
close all;
clear all;
Screen('Preference', 'SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle').
% For help see: help rand
rand('seed', sum(100 * clock));

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer. For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this. For help see: help max
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% luminace values are (in general) defined between 0 and 1.
% For help see: help WhiteIndex and help BlackIndex
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open the screen, defined as 1000 x 1000 matrix
[window, windowRect] = PsychImaging('OpenWindow', 0, [255 255 255], [0 0 1000 1000], screenNumber, white, [], 32, 2);
%Here screen is opened just for changing the SyncTest preference

[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set text size to 40 
Screen('TextSize', window, 40);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
% For help see: Screen BlendFunction?
% Also see: Chapter 6 of the OpenGL programming guide
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%----------------------------------------------------------------------
%                       Keyboard Presses
%----------------------------------------------------------------------

kKey = KbName('k');
escapeKey = KbName('ESCAPE');
lKey = KbName('l');

DrawFormattedText(window, ['Congrats on completing the first portion of the task! \n\n ' ...
    'Press any key to continue!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

Screen('TextSize', window, 25);
DrawFormattedText(window, ['In this task, you will be presented with a string of letters. \n\n ' ...
    'The letters will either make a word or a non-word. \n\n When the letters appear, press: \n\n the K key if the letters DO form a word, \n\n and press the L key if they do NOT form a word. \n\n ' ...
    '\n\n *Work as quickly as you can - if nothing is pressed in 1.5 seconds, the trial will be skipped! \n\n Press the L key to begin!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Stimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);


% Number of frames to wait before next stimulus
waitframes = 1;


% Set the color of our dot to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which
% define our RGB values. The maximum number for each is 1 and the minimum
% 0. So, "full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0
% 1]. Play around with these numbers and see the result.
dotColor = [0 0 0];

% Determine a random X and Y position for our dot. NOTE: As dot position is
% randomised each time you run the reenript the output picture will show the
% dot in a different position. Similarly, when you run the script the
% position of the dot will be randomised each time. NOTE also, that if the
% dot is drawn at the edge of the screen some of it might not be visible.
dotXpos = xCenter
dotYpos = yCenter
% Dot size in pixels
dotSizePix = 10;
scrambledWords = cell(1,25);

% Make the matrix which will determine our condition combinations
condMatrixBase = [sort(repmat([1 2 3 4], 1, 3)); repmat([1 2 3 4], 1, 3)];% This matrix is 12 columns wide, allowing us to record the results of each trial


% This is for the number of trials per condition, giving us a total of 12 trials.
trialsPerCondition = 3;

% Duplicate the condition matrix to get the full number of trials
condMatrix = repmat(condMatrixBase, 1, trialsPerCondition);

% Get the size of the matrix
[~, numTrials] = size(condMatrix);

% To randomize the conditions so that a randomly chosen word is presented in a
% randomly chosen color
shuffler = Shuffle(1:numTrials);
condMatrixShuffled = condMatrix(:, shuffler);
% Draw the dot to the screen. For information on the command used in
% this line type "Screen DrawDots?" at the command line (without the
% brackets) and press enter. Here we used good antialiasing to get nice
% smooth edges
% inediblewords = cell (1,3);
% inedibleWords{1,1} = ['b' 'o' 't' 't' 'l' 'e'];
% inedibleWords{1,2} = ['j' 'a' 'c' 'k' 'e' 't'];
% inedibleWords{1,3} = ['l' 'i' 'b' 'r' 'a' 'r' 'y'];
% primedWords = inedibleWords(randperm(numel(inedibleWords)))
% 
% newWords = cell(1,3);
% newWords{1,1} = ['t' 'a' 'b' 'l' 'e'];
% newWords{1,2} = ['l' 'a' 'b' 'o' 'r' 'a' 't' 'o' 'r' 'y'];
% newWords{1,3} = ['p' 'i' 'p' 'e' 't' 't' 'e'];
% newestWords = newWords(randperm(numel(newWords)))

% for i = 1:numTrials
%     inputScramble = char(randomScramble(1,i));
%     outputScramble = randomizeStr(inputScramble);
%     scrambledWords{1,i} = outputScramble;
% end   
trialNum = 1
scoreTally = 0;
tracker1 = 1; tracker2 = 1; tracker3 = 1; %tracks number of each trial type
rtTracker1 = [0]; rtTracker2 = [0]; rtTracker3 = [0];
rtTrackerTot = [0 0 0 0 0 0 0 0 0 0 0 0];
randomorder = randperm(12);
%15 trials, can move between them with a key press
Screen('TextSize', window, 40);
while trialNum < 12
    [keyIsDown,secs, keyCode] = KbCheck;
    if keyCode(escapeKey)
        ShowCursor;
        sca;
        return
        %if the nonmatch (n) or match (right arrow) key pressed, progress
        %to next trial
    else
            trialNum = trialNum + 1
            trialType = randomorder([trialNum])     
        % Flip to the screen
       Screen('Flip', window);
            if trialType == 1 || trialType == 2 || trialType == 3 || trialType == 4 %slider should only change r_given_exp
                run("scrambling_words.m")
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                WaitSecs(rand + rand + rand)
                 DrawFormattedText (window, (char((outputScramble))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                Screen('Flip', window);
                
            
            elseif trialType == 5 || trialType == 6 || trialType == 7 || trialType == 8 
                run("new_words.m")
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                WaitSecs(rand + rand + rand);
                DrawFormattedText (window, (char((inputNew))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                 Screen('Flip', window);
                
               
            elseif trialType == 9 || trialType == 10 || trialType == 11 || trialType == 12
                run("combinedprimedwords.m")
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                WaitSecs(rand + rand + rand)
                DrawFormattedText (window, (char((allprimedWords))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                 Screen('Flip', window);
            end

            
onsetTime = GetSecs;
rt =  1.5;
while (GetSecs - onsetTime) < 1.5
[keyIsDown,secs,keyCode] = PsychHID('KbCheck');
    if keyCode(lKey)
        KbReleaseWait;
        rt = secs - onsetTime
        % if match trial types (1 and 3) are presented and the n key is
        % pressed, the answer is incorrect and scoreTally remains the same
     elseif keyCode(kKey)
         KbReleaseWait;
        rt = secs - onsetTime
     
        end
         end
 

    if trialType == 1|| trialType == 2 || trialType == 3 || trialType == 4
        rtTracker1(tracker1) = rt;
        tracker1 = tracker1 + 1;
    elseif trialType == 5 || trialType == 6 || trialType == 7 || trialType == 8 
        rtTracker2(tracker2) = rt;
        tracker2 = tracker2 + 1;
    elseif trialType == 9 || trialType == 10 || trialType == 11 || trialType == 12
        rtTracker3(tracker3) = rt;
        tracker3 = tracker3 + 1;
    end

rtTrackerTot(trialNum) = rt;
   end

end



        % if nonmatch trial types (2 and 4) are presented and the n key is
        % pressed, the answer is correct and scoreTally in increased by 1
        
  

       

        %Move to the next trial
               

%         Implicitscore = scoreTally/(trialNum + 1);


rtFinal = mean(rtTrackerTot);
rtWord = mean(rtTracker2);
rtPrimed = mean(rtTracker3);
rtNonword = mean(rtTracker1);

% DrawFormattedText(window, [strcat('Your Score is:','  ', Implicitscore, ' \n\n Press any key to exit. Thanks for playing!')],...
%     'center', 'center', black);
% Screen('Flip', window);
% KbStrokeWait

Screen('TextSize', window, 20);
DrawFormattedText(window, ['Congrats on completing the tests! \n\n This was actually an implicit word test, \n\n which measured your ability to recall and respond to the words you viewed in the previous task (known as primed words),\n\n versus some new words you had not seen before, and some scrambled words. \n\n In theory, participants respond the fastest to primed words,\n\n and the slowest to scrambled words - but of course, everyone has a different experience.' '\n\n Press any key to see your reaction times. Thanks for playing!'],...
     'center', 'center', black);
 Screen('Flip', window);
 KbStrokeWait;


 Screen('TextSize', window, 35);
 DrawFormattedText(window, [strcat('Your average reaction time for all trials is:','  ', num2str(rtFinal), 's',  ' \n\n Your reaction time for previously seen (primed) words is:','   ', num2str(rtPrimed), 's', '\n\n Your reaction time for new words is:','   ', num2str(rtWord), 's', '\n\n Your reaction time for scrambled words is:','   ',num2str(rtNonword), 's', '\n\n Press any key to exit. Thanks for playing!')],...
     'center', 'center', black);
 Screen('Flip', window); 
 KbStrokeWait;

sca;

% 
% Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 2);
% 
% % Flip to the screen. This command basically draws all of our previous
% % commands onto the screen. See later demos in the animation section on more
% % timing details. And how to demos in this section on how to draw multiple
% % rects at once.
% % For help see: Screen Flip?
%   vbl = Screen('Flip', window, vbl + (waitframes - 300) * ifi);
% 
% % Now we have drawn to the screen we wait for a keyboard button press (any
% % key) to terminate the demo. For help see: help KbStrokeWait
% 
% Screen('TextSize', window, 50);
% DrawFormattedText (window, (char((outputScramble))), (rand * 0.6 *  screenXpixels), (rand * screenYpixels), [1 0 0]);
% 
% % Flip to the screen
%   vbl = Screen('Flip', window, vbl + (waitframes - 300) * ifi);
% KbStrokeWait;
% 
% 
% % Now we have drawn to the screen we wait for a keyboard button press (any
% % key) to terminate the demo
% 
% 
% 
% % Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% % all features related to PTB. Note: we leave the variables in the
% % workspace so you can have a look at them if you want.
% % For help see: help sca
% sca;



function [] = SetParameters()
%Sets all the default parameters for a TTW experiment!
%The types of parameters in this file are things that should never ever
%need to change.  If I find myself wanting to change for debugging or
%different versions, I take it out of here and add it to para.txt and make
%a corresponding ReadParaFile line

global parameters; %(Remember this gets declared at the start of every function!)

%%%%%%%%%%%
% Set up screen and standard size/color parameters
%%%%%%%%%%%

%Screen default parameters that the calibrator/tobii uses- should be 
%constant for any experiment

scr.screens = Screen('Screens');
scr.displayScreen = max(scr.screens); %Should be the Tobii screen!
scr.black = BlackIndex(scr.displayScreen);
scr.white = WhiteIndex(scr.displayScreen);
scr.gray = GrayIndex(scr.displayScreen);
scr.bgcolor = [scr.gray scr.gray scr.gray];
scr.rect = Screen('Rect', scr.displayScreen);
scr.rect = [1366 0 2646 1024]; %VERY STUPID BUG FIX, MAC IS TREATING WINDOWS AS SINGLE SCREEN :(
scr.res = scr.rect(3:4);
scr.numberOfBuffers = 2; %doublebuffer
scr.winPtr = [];
[scr.winPtr, scr.winRect] = Screen('OpenWindow', scr.displayScreen, [], scr.rect);
parameters.scr = scr;

% Set priority for script execution to realtime priority.
% This ensures that we can run the experiment with minimal 
% interference from other computer operations.
priorityLevel=MaxPriority(parameters.scr.winPtr);
Priority(priorityLevel);

%Set keyboard stuff - Macs seem to prefer if you also declare these in the
%main function for some reason.  Whatever, just do it :p
KbName('UnifyKeyNames');
parameters.space=KbName('SPACE');
parameters.esc=KbName('ESCAPE');
parameters.z_press=KbName('z');
parameters.c_press=KbName('c');

% Set text size
Screen('TextSize', parameters.scr.winPtr, 32);

%for responses and trial parameters!
parameters.response = [];

%%%%%%%%%%%
% Set video rectangle parameters
% Note: this is all relativized to monitor size
%%%%%%%%%%%

winlength = parameters.scr.rect(3);
winheight = parameters.scr.rect(4);

border = 30;
moviewidth = winlength/2 - 2*(border);
movieheight = moviewidth * (3/4);


topheight = (winheight-movieheight)/3;
leftcorner = border-5;
rightcorner = winlength/2 + border;
parameters.leftbox = [leftcorner,topheight,leftcorner+moviewidth,topheight+movieheight];
parameters.rightbox = [rightcorner,topheight,rightcorner+moviewidth,topheight+movieheight];
centercorner = (winlength/2)-(moviewidth/2);
parameters.centerbox = [centercorner, topheight, centercorner+moviewidth, topheight + movieheight];

%%%%%%%%%%%
% Set Tobii parameters
%%%%%%%%%%%

parameters.ConnTobii = 1; %Are we trying to connect to the Tobii right now?
parameters.EYETRACKER = 0; %Are we actually connected?

%Tobii connection parameters for ECCL/BCM eyetracker, override in para.txt for yours
%parameters.hostName = '169.254.6.227';
%Tobii connection parameters for Lion room 
parameters.hostName = '169.254.5.184';
parameters.portName = '4455';

%%%%%%%%%%%
% Set any other parameters
%%%%%%%%%%%

%Set any parameters here that will be constant in your experiment.  With
%very slightly more effort you might want to set them in a para.txt file &
%add lines to ReadParaFile instead, to make them easier to modify.  





end


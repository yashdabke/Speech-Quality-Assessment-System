% added playback controls (play, pause, stop, and seek) to the GUI using buttons and a slider
% The functions playAudio, pauseAudio, stopAudio, and seekAudio are responsible for controlling playback. 
% The playerObj variable keeps track of the audio player, and the audioData variable stores the recorded audio.

clear all; close all; clc
set(0, 'DefaultAxesFontSize', 20);

% Create the main figure for the GUI
mainFig = uifigure('Name', 'Voice Recording and Analysis Tool', 'Position', [100, 100, 600, 300]);

% Create a label for status messages
statusLabel = uilabel(mainFig, 'Text', 'Status: Ready', 'Position', [20, 230, 460, 30]);

% Create buttons for recording, playback, and saving
recordButton = uibutton(mainFig, 'Text', 'Record', 'Position', [20, 180, 100, 30], 'ButtonPushedFcn', @(btn, event) recordAudio());
playButton = uibutton(mainFig, 'Text', 'Play', 'Position', [140, 180, 60, 30], 'ButtonPushedFcn', @(btn, event) playAudio());
pauseButton = uibutton(mainFig, 'Text', 'Pause', 'Position', [205, 180, 60, 30], 'ButtonPushedFcn', @(btn, event) pauseAudio());
stopButton = uibutton(mainFig, 'Text', 'Stop', 'Position', [270, 180, 60, 30], 'ButtonPushedFcn', @(btn, event) stopAudio());
seekSlider = uislider(mainFig, 'Position', [20, 130, 400, 3], 'Limits', [0, 1], 'ValueChangedFcn', @(slider, event) seekAudio());
seekLabel = uilabel(mainFig, 'Text', 'Seek:', 'Position', [20, 100, 40, 30]);

% Initialize audio player variables
playerObj = [];
audioData = [];

% Function to record audio
function recordAudio()
    recObj = audiorecorder;
    disp('Start speaking.');
    recordblocking(recObj, 5);
    disp('End of Recording.');
    audioData = getaudiodata(recObj);
    updateStatusLabel('Status: Recording complete');
    plotWaveform(audioData);
    plotSpectrogram(audioData);
end

% Function to play recorded audio
function playAudio()
    playerObj = audioplayer(audioData, recObj.SampleRate);
    disp('Playing back the recording...');
    play(playerObj);
    updateStatusLabel('Status: Playback in progress');
end

% Function to pause audio playback
function pauseAudio()
    if ~isempty(playerObj) && isplaying(playerObj)
        pause(playerObj);
        updateStatusLabel('Status: Playback paused');
    end
end

% Function to stop audio playback
function stopAudio()
    if ~isempty(playerObj) && (isplaying(playerObj) || ispaused(playerObj))
        stop(playerObj);
        updateStatusLabel('Status: Playback stopped');
    end
end

% Function to seek audio playback
function seekAudio()
    if ~isempty(playerObj) && ~isempty(audioData)
        newPosition = seekSlider.Value * length(audioData);
        if isplaying(playerObj) || ispaused(playerObj)
            seek(playerObj, newPosition);
        end
    end
end

% Function to update the status label
function updateStatusLabel(newStatus)
    statusLabel.Text = newStatus;
end

% Function to plot the waveform
function plotWaveform(audioData)
    figure;
    plot(audioData);
    title('Your Speech Signal', 'FontSize', 14);
    xlabel('Sample Index', 'FontSize', 12);
    ylabel('Amplitude (Double-Precision)', 'FontSize', 12);
end

% Function to plot the spectrogram
function plotSpectrogram(audioData)
    figure;
    spectrogram(audioData, 8e3, 'yaxis');
    title('Spectrogram of your Recording', 'FontSize', 14);
    xlabel('Time', 'FontSize', 12);
end

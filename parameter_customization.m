% parameter customization: allows users to customize recording parameters like duration, sample rate, or recording format
% The updateDuration, updateSampleRate, and updateFormat functions handle updating these parameters based on user input
% The audio recorder object is also created with the specified sample rate and duration


clear all; close all; clc
set(0, 'DefaultAxesFontSize', 20);

% Create the main figure for the GUI
mainFig = uifigure('Name', 'Voice Recording and Analysis Tool', 'Position', [100, 100, 600, 400]);

% Create a label for status messages
statusLabel = uilabel(mainFig, 'Text', 'Status: Ready', 'Position', [20, 330, 460, 30]);

% Create buttons for recording, playback, and saving
recordButton = uibutton(mainFig, 'Text', 'Record', 'Position', [20, 280, 100, 30], 'ButtonPushedFcn', @(btn, event) recordAudio());
playButton = uibutton(mainFig, 'Text', 'Play', 'Position', [140, 280, 60, 30], 'ButtonPushedFcn', @(btn, event) playAudio());
pauseButton = uibutton(mainFig, 'Text', 'Pause', 'Position', [205, 280, 60, 30], 'ButtonPushedFcn', @(btn, event) pauseAudio());
stopButton = uibutton(mainFig, 'Text', 'Stop', 'Position', [270, 280, 60, 30], 'ButtonPushedFcn', @(btn, event) stopAudio());
seekSlider = uislider(mainFig, 'Position', [20, 230, 400, 3], 'Limits', [0, 1], 'ValueChangedFcn', @(slider, event) seekAudio());
seekLabel = uilabel(mainFig, 'Text', 'Seek:', 'Position', [20, 200, 40, 30]);

% Create edit fields for customization
durationEditField = uieditfield(mainFig, 'numeric', 'Position', [20, 150, 120, 22], 'Value', 5, 'ValueChangedFcn', @(field, event) updateDuration());
sampleRateDropdown = uidropdown(mainFig, 'Items', {'44100 Hz', '22050 Hz', '11025 Hz'}, 'Position', [150, 150, 120, 22], 'Value', '44100 Hz', 'ValueChangedFcn', @(dropdown, event) updateSampleRate());
formatDropdown = uidropdown(mainFig, 'Items', {'WAV', 'MP3', 'FLAC'}, 'Position', [280, 150, 80, 22], 'Value', 'WAV', 'ValueChangedFcn', @(dropdown, event) updateFormat());

% Initialize audio player variables
playerObj = [];
audioData = [];

% Function to record audio
function recordAudio()
    recObj = audiorecorder('SampleRate', getSampleRate(), 'TotalSamples', getDuration() * getSampleRate());
    disp('Start speaking.');
    recordblocking(recObj, getDuration());
    disp('End of Recording.');
    audioData = getaudiodata(recObj);
    updateStatusLabel('Status: Recording complete');
    plotWaveform(audioData);
    plotSpectrogram(audioData);
end

% Function to play recorded audio
function playAudio()
    playerObj = audioplayer(audioData, getSampleRate());
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

% Function to update recording duration
function updateDuration()
    % Customization: Update the recording duration
    newDuration = durationEditField.Value;
    durationEditField.Value = newDuration;
end

% Function to update sample rate
function updateSampleRate()
    % Customization: Update the sample rate
    sampleRateStr = sampleRateDropdown.Value;
    sampleRate = str2double(strtok(sampleRateStr, ' '));
end

% Function to update recording format
function updateFormat()
    % Customization: Update the recording format
    format = formatDropdown.Value;
end

% Function to get recording duration from the edit field
function duration = getDuration()
    duration = durationEditField.Value;
end

% Function to get sample rate from the dropdown
function sampleRate = getSampleRate()
    sampleRateStr = sampleRateDropdown.Value;
    sampleRate = str2double(strtok(sampleRateStr, ' '));
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

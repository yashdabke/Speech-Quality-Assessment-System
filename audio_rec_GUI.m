% this code creates a simple GUI with buttons for recording, playback, and saving, along with a label to display status messages


clear all; close all; clc
set(0, 'DefaultAxesFontSize', 20);

% Create the main figure for the GUI
mainFig = uifigure('Name', 'Voice Recording and Analysis Tool', 'Position', [100, 100, 500, 300]);

% Create a label for status messages
statusLabel = uilabel(mainFig, 'Text', 'Status: Ready', 'Position', [20, 230, 460, 30]);

% Create buttons for recording, playback, and saving
recordButton = uibutton(mainFig, 'Text', 'Record', 'Position', [20, 180, 100, 30], 'ButtonPushedFcn', @(btn, event) recordAudio());
playButton = uibutton(mainFig, 'Text', 'Play', 'Position', [140, 180, 100, 30], 'ButtonPushedFcn', @(btn, event) playAudio());
saveButton = uibutton(mainFig, 'Text', 'Save', 'Position', [260, 180, 100, 30], 'ButtonPushedFcn', @(btn, event) saveAudio());

% Function to record audio
function recordAudio()
    recObj = audiorecorder;
    disp('Start speaking.');
    recordblocking(recObj, 5);
    disp('End of Recording.');
    myRecording = getaudiodata(recObj);
    updateStatusLabel('Status: Recording complete');
    plotWaveform(myRecording);
    plotSpectrogram(myRecording);
end

% Function to play recorded audio
function playAudio()
    playerObj = audioplayer(myRecording, recObj.SampleRate);
    disp('Playing back the recording...');
    play(playerObj);
    updateStatusLabel('Status: Playback complete');
end

% Function to save recorded audio
function saveAudio()
    timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    audioFileName = ['myRecording_' timestamp '.wav'];
    audiowrite(audioFileName, myRecording, recObj.SampleRate);
    updateStatusLabel(['Status: Recording saved as ' audioFileName]);
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

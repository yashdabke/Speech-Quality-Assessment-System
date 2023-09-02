clear all; close all; clc
set(0, 'DefaultAxesFontSize', 20);

% Record your voice for 5 seconds.
recObj = audiorecorder;
disp('Start speaking.');
recordblocking(recObj, 5);
disp('End of Recording.');

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Display audio properties
audioDuration = length(myRecording) / recObj.SampleRate;
fprintf('Audio Duration: %.2f seconds\n', audioDuration);
fprintf('Sample Rate: %d Hz\n', recObj.SampleRate);
fprintf('Number of Samples: %d\n', length(myRecording));

% Plot the waveform.
figure(1)
plot(myRecording);
title('Your Speech Signal','interpreter','latex','FontSize',25,'FontWeight','bold')
xlabel('Sample Index','FontSize',19,'FontWeight','bold')
ylabel('Amplitude (Double-Precision)','FontSize',19,'FontWeight','bold')

% Create a timestamp for the filename
timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');

% Specify the filename with the timestamp
audioFileName = ['myRecording_' timestamp '.wav'];

% Save the recording to a WAV file
audiowrite(audioFileName, myRecording, recObj.SampleRate);
fprintf('Recording saved as: %s\n', audioFileName);

% Display spectrogram
figure(2)
spectrogram(myRecording, 8e3, 'yaxis');
title('Spectrogram of your Recording','interpreter','latex','FontSize',25,'FontWeight','bold')
xlabel('Time','FontSize',19,'FontWeight','bold')

% Play back the recording.
uiwait(msgbox('Hit OK to play the recording','Title','modal'));
disp('Playing back the recording...');
play(recObj);
disp('Playback complete.');

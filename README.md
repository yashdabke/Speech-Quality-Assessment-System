MATLAB Voice Recording and Analysis Tool with Customization and Playback

This MATLAB code is a versatile "Voice Recording and Analysis Tool" with a Graphical User Interface (GUI). It allows users to record audio, customize recording parameters (duration, sample rate, format), play back recorded audio, visualize it as a waveform and spectrogram, and save the recording with a timestamped filename. This tool simplifies the process of recording and analyzing audio, making it user-friendly and adaptable to various recording needs.

1. Record Audio: Capture audio from a microphone for a specified duration, making it ideal for tasks like voice notes, interviews, or sound samples.
2. Customize Recording Parameters: Tailor your recording experience by specifying the recording duration, choosing the sample rate (e.g., 44100 Hz, 22050 Hz), and selecting the desired format (WAV, MP3, FLAC).
3. Playback and Control: Play back your recorded audio with playback controls that include play, pause, and stop, providing precise control over audio review.
4. Visualize Audio Data: Analyze the recorded audio using both waveform and spectrogram visualizations, facilitating a deeper understanding of the captured sound.
5. Save Recordings: Easily save your recordings with automatically generated timestamped filenames, ensuring efficient organization and retrieval of audio files.

This tool is designed to simplify the process of audio recording and analysis, making it accessible for various applications, from voice memos to music production.

The MATLAB code (audio_recording.m) performs the following actions:
1. Initialization and Setup:
   - Clears all existing variables and figures.
   - Sets the default font size for plot axes to 20.

2. Recording Voice:
   - Initializes an `audiorecorder` object called `recObj` to record audio.
   - Displays a message to start speaking and then records audio for 5 seconds using the `recordblocking` function.
   - Displays a message indicating the end of the recording.

3. Storing Recorded Data:
   - Retrieves the recorded audio data as a double-precision array called `myRecording`.

4. Plotting the Waveform:
   - Creates Figure 1 and plots the waveform of the recorded speech using the `plot` function.
   - Sets appropriate titles, labels, and font sizes for the plot.

5. Displaying Audio Properties:
   - Calculates and displays the audio duration, sample rate, and the number of samples in the recorded data.

6. Saving the Recording:
   - Generates a timestamp to create a unique filename for the recorded audio.
   - Saves the recorded audio as a WAV file with the timestamp in the filename.
   - Displays a message indicating the filename where the recording was saved.

7. Plotting the Spectrogram:
   - Creates Figure 2 and generates a spectrogram of the recorded speech using the `spectrogram` function.
   - Sets appropriate titles, labels, and font sizes for the spectrogram plot.

8. Playback of Recorded Audio:
   - Creates a message box prompting the user to click "OK" to play back the recorded audio.
   - When the user clicks "OK," the code plays back the recorded audio using the `play` function.

it records your voice for 5 seconds, visualizes the waveform and spectrogram of the recorded speech, saves the recording to a WAV file with a timestamp, and allows you to play back the recorded audio. 
It's a basic voice recording and analysis tool in MATLAB.

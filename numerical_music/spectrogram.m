function [S, f, t] = spectrogram(signal, fs, window_size)
	% get the size of the signal and compute the number of windows
	signal_size = size(signal, 1);
	nr_windows = floor(signal_size / window_size);

	% initialize the spectrogram matrix
	S = zeros(window_size, nr_windows);

	% window indices
	start_pos = 1;
	end_pos = window_size;

	% for each window
	for i = 1:nr_windows
		% apply the Hann function
		current_window = hanning(window_size);

		% apply window function
		current_window = signal(start_pos:end_pos) .* current_window;

		% Fourier Transform with double resolution
		resolution = 2 * window_size;
		fourier_transform = fft(current_window, resolution);

		% discard the conjugate part
		result_without_conjugate = fourier_transform(1:window_size);

		% store the result in spectrogram matrix
		S(:, i) = abs(result_without_conjugate);
		start_pos = start_pos + window_size;
		end_pos = end_pos + window_size;
	end

	% frequency vector (first half only)
	f = (0:window_size - 1)' * fs / (2 * window_size);

	% time vector, one per window
	t = ((0:nr_windows - 1)' * window_size) / fs;
end

% Comment on the difference between "Plain Sound" and the "Plain Loop" one.
% The "Plain Sound" looks much cleaner and more regular. The "Plain Loop" has
% more noise and randomness, probably because it’s a real recording. The "Plain
% Sound" seems computer-generated.

% Comment on the difference between "High Pass Sound" and "Plain Sound".
% After the high-pass filter, the sound lost the low parts. Now it
% mostly shows the higher tones, and the spectrogram looks brighter at the top
% and darker at the bottom.

% Comment on the difference between "Reverb Sound" and "Plain Sound".
% The reverb made the sounds last longer. You can see the colors stretch more
% in time, like the sound is echoing or happening in a big room.

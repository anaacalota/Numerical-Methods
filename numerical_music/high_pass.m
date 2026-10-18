function signal = high_pass(signal, fs, cutoff_freq)
	% compute the Fourier Transform of the signal
	fourier_transform = fft(signal);

	% create all possible frequencies of the signal
	freq_vector = (0:length(signal) - 1)' * fs / length(signal);

	% create a vector mask that is 1 for frequencies higher than the cutoff
	% frequency, and 0 for frequencies lower than the cutoff frequency
	mask = freq_vector > cutoff_freq;

	% apply the mask to the Fourier transform
	fourier_transform = fourier_transform .* mask;

	% apply the mask to the conjugate part of the Fourier transform
	fourier_transform = fourier_transform .* mask(end:-1:1);

	% apply the inverse Fourier transform to get the filtered signal
	signal = ifft(fourier_transform);

	% normalize the signal
	signal = signal / max(abs(signal));
end

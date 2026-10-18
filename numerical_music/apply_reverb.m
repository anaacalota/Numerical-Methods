function signal = apply_reverb(signal, impulse_response)
	% make sure the signal is a column vector
	impulse_response = stereo_to_mono(impulse_response);

	% generate the convolution of the signal and the impulse response
	signal = fftconv(signal, impulse_response);

	% normalize the signal
	signal = signal / max(abs(signal));
end

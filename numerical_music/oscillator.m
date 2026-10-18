function x = oscillator(freq, fs, dur, A, D, S, R)
	% create time vector
	t = (0:1/fs:dur-1/fs)';

	% generate sine wave
	x = sin(2 * pi * freq * t);

	% compute total number of samples
	total_samples = length(t);

	% compute number of samples for each envelope phase
	attack_samples = floor(A * fs);
	decay_samples = floor(D * fs);
	release_samples = floor(R * fs);
	sustain_samples = total_samples - attack_samples - decay_samples - release_samples;

	% attack: linear ramp from 0 to 1
	attack_env = linspace(0, 1, attack_samples)';

	% decay: linear ramp from 1 to S
	decay_env = linspace(1, S, decay_samples)';

	% sustain: constant value of S
	sustain_env = S * ones(sustain_samples, 1);

	% release: linear ramp from S to 0
	release_env = linspace(S, 0, release_samples)';

	% concatenate envelope
	envelope = [attack_env; decay_env; sustain_env; release_env];

	% apply the amplitude modulation
	x = x .* envelope;
end
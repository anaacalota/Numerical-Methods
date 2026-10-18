Copyright 2025 Calota Ana-Cristina

# Numerical Methods

## 1. Numerical Music

- The code implements audio signal processing, using numerical methods
  for analyzing, generating, and modifying signals.
- The related functions include mono conversion, spectrogram creation,
  frequency filtering, and effects such as reverb.

**Implementation:**

- `stereo_to_mono()` converts a stereo signal into a mono one and normalizes
  the result.
- `spectrogram()` splits the signal into fixed-size windows and applies the
  Hann function to each window, then computes the Fourier transform and
  provides a frequency-over-time representation. The function returns the
  spectrogram matrix S, the frequency vector f, and the time vector t. At the
  end, I also noted the differences between the plots mentioned.
- `oscillator()` generates a sinusoidal signal with a specified frequency and
  duration, at a sampling rate `fs`. A feature of the function is the ADSR
  envelope applied to the signal's amplitude.
- `high_pass()` filters the audio signal, keeping only the frequencies higher
  than `cutoff_freq`. A mask is applied to the Fourier transform, then the
  inverse transform is computed, and the result is normalized at the end.
- `apply_reverb()` first converts the impulse to mono for uniformity, then
  performs the convolution of the signal and normalizes the result.

## 2. Robotzii

- The code implements interpolation techniques, with applications in
  reconstructing a trajectory. Two main methods are covered: interpolation
  with Vandermonde-form polynomials and C2-class cubic spline interpolation.

<!-- -->

- `parse_data()` reads from a file and returns the vectors x and y, the values
  to be interpolated.
- `spline_c2()` builds `s_i(x)` between the points x and y and solves a system
  of 4n equations for 4n coefficients.
- `P_spline()` evaluates the spline defined by `coef` at the points `x_interp`,
  finding the interval `[x_i, x_i+1]` that each interpolation point falls into
  and applying the corresponding spline formula.
- `vandermonde()` builds the matrix and solves the Vandermonde system,
  returning the coefficients of the polynomial.
- `P_vandermonde()` evaluates the Vandermonde polynomial at a set of points
  `x_interp`.

## 3. Recommendations

- The code implements a recommendation system that analyzes user preferences
  in order to suggest themes that they will like and that are similar to
  the ones they already enjoy.

**Implementation:**

- `read_mat()` loads a CSV file containing a matrix of reviews and removes
  the first row and column.
- `preprocess()` removes users who gave fewer than `min_reviews` reviews, by
  counting the nonzero reviews for each user and marking the users who meet
  the condition that their number of reviews is greater than or equal to the
  minimum number of reviews.
- `cosine_similarity()` computes the similarity between 2 column vectors
  according to the given formula.
- `recommendations()` reads the review matrix, filters the users using
  `preprocess()`, applies SVD to extract the orthonormal matrix V, computes the
  similarities between `liked_theme` and all the others, and sorts the themes
  by similarity, returning the most relevant recommendations.
  
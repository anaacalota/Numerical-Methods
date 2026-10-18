function y_interp = P_vandermonde (coef, x_interp)
	% P_vandermonde(x) = a0 + a1 * x + a2 * x^2 + ... + an * x^n
	% coef = [a0, a1, a2, ..., an]'
	% y_interp(i) = P_vandermonde(x_interp(i)), i = 0 : length(x_interp) - 1

	% Calcualte y_interp using the Vandermonde coefficients
	n = length(coef) - 1; % degree of the polynomial
	y_interp = zeros(length(x_interp), 1);

	for k = 1 : length(x_interp)
		xi = x_interp(k); % what I want to interpolate
		y_interp(k) = 0;
		for j = 0 : n
			y_interp(k) = y_interp(k) + coef(j + 1) * xi^j;
		end
	end

end

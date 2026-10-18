function y_interp = P_spline (coef, x, x_interp)
	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3, i = 0 : n - 1
	% coef = [a0, b0, c0, d0, a1, b1, c1, d1, ..., an-1, bn-1, cn-1, dn-1]
	% x = [x0, x1, ..., xn]
	% y_interp(i) = P_spline(x_interp(i)), i = 0 : length(x_interp) - 1
	% Be careful! Indexes in Matlab start from 1, not 0

	% Calculate y_interp using the Spline coefficients
	n = length(x) - 1; % number of intervals
	y_interp = zeros(length(x_interp), 1);

	for k = 1 : length(x_interp)
		xi = x_interp(k); % what I want to interpolate

		% finding the interval [x_i, x_i+1] that contains xi
		j = 1;
		while j <= n
			if xi >= x(j) && xi <= x(j + 1)
				break;
			end
			j = j + 1;
		end

		% calculating the coefficients
		delta = xi - x(j);
		pos_ai = 4 * (j - 1) + 1;
		ai = coef(pos_ai);
		bi = coef(pos_ai + 1);
		ci = coef(pos_ai + 2);
		di = coef(pos_ai + 3);

		% calculating the value of the polynomial
		y_interp(k) = ai + bi * delta + ci * delta^2 + di * delta^3;
	end
end
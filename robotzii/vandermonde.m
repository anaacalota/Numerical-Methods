function coef = vandermonde(x, y)
	% x = [x0, x1, ..., xn]'
	% y = [y0, y1, ..., yn]'
	% coef = [a0, a1, a2, ..., an]'

	% Calculate the Vandermonde coefficients
	n = length(x) - 1; % degree of the polynomial
	A = zeros(n + 1, n + 1); % vandermonde matrix

	% raise x to the power of j - 1 to create the Vandermonde matrix
	for i = 1 : n + 1
		for j = 1 : n + 1
			A(i, j) = x(i)^(j - 1);
		end
	end

	b = y;
	coef = A \ b;
endfunction
function coef = spline_c2 (x, y)
	% Remember that the indexes in Matlab start from 1, not 0

	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
	% si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
	% si''(x) =                   2ci          + 6di(x - xi)

	n = length(x) - 1; % number of intervals
	deltas = diff(x); % delta
	A = sparse(4 * n, 4 * n); % coefficients matrix
	b = zeros(4 * n, 1); % vector of the right side

	% 1: si(xi) = yi, i = 0 : n - 1
	for i = 1 : n
		A(i, 4 * (i - 1) + 1) = 1; % ai
		b(i) = y(i);
	end

	% 2: s_n-1(xn) = yn
	delta = deltas(n);
	% a_n-1, b_n-1, c_n-1, d_n-1
	A(n + 1, 4 * (n - 1) + (1:4)) = [1, delta, delta^2, delta^3];
	b(n + 1) = y(n + 1);

	% 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 1
	for i = 1 : n - 1
		delta = deltas(i);
		% a_i, b_i, c_i, d_i
		A(n + 1 + i, 4 * (i - 1) + (1 : 4)) = [1, delta, delta^2, delta^3];
		A(n + 1 + i, 4 * i + 1) = -1; % a_i+1
	end

	% 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 1
	for i = 1 : n - 1
		delta = deltas(i);
		% b_i, c_i, d_i
		A(2 * n + i, 4 * (i - 1) + (2 : 4)) = [1, 2 * delta, 3 * delta^2];
		A(2 * n + i, 4 * i + 2) = -1; % b_i+1
		b(2 * n + i) = 0;
	end

	% 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 1
	for i = 1 : n - 1
		delta = deltas(i);
		% b_i, c_i, d_i
		A(3 * n + i - 1, 4 * (i - 1) + (3:4)) = [2, 6 * delta];
		A(3 * n + i - 1, 4 * i + 3) = -2; % c_i+1
		b(3 * n + i - 1) = 0;
	end

	% 6: s0''(x0) = 0
	A(4 * n - 1, 3) = 2; % c_0

	% 7: s_n-1''(x_n) = 0
	delta = deltas(n);
	A(4 * n, 4 * (n - 1) + 3) = 2; % c_n-1
	A(4 * n, 4 * (n - 1) + 3 + 1) = 6 * delta; % d_n-1

	% Solve the system of equations
	coef = A \ b;
end
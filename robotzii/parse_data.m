function [x, y] = parse_data(filename)
	% file input format:
	% n
	% x0 x1 ... xn
	% y0 y1 ... yn

	% Open the file for reading
	file = fopen(filename, "r");
	if file == -1
		fprintf("could not open file");
		return;
	end

	% Read n, x, y from the file
	n = fscanf(file, "%d", 1);
	x = fscanf(file, "%d", n + 1);
	y = fscanf(file, "%d", n + 1);

	% Close the file
	fclose(file);
end
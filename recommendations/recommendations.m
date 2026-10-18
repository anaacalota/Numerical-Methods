function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
	% load the matrix
	mat = read_mat(path);

	% determine the number of themes (columns)
	nr_themes = size(mat, 2);

	% preprocess the matrix
	result_mat = preprocess(mat, min_reviews);

	% compute reduced SVD of the matrix
	[~, ~, V] = svds(result_mat, num_features);

	% compute similarity between liked_theme and all other themes using V
	similarities = zeros(1, nr_themes);
	liked_vector = V(liked_theme, :);

	for theme = 1:nr_themes
		if theme == liked_theme
			similarities(theme) = -1; % exclude the liked theme itself
		else
			theme_vector = V(theme, :);
			similarities(theme) = cosine_similarity(liked_vector', theme_vector');
		end
	end

	% sort themes by similarity and get the top num_recoms
	[~, idx] = sort(similarities, 'descend');
    idx = idx(idx ~= liked_theme); % remove liked_theme

	recoms = idx(1:min(num_recoms, nr_themes-1));
end
function reduced_mat = preprocess(mat, min_reviews)
	# Remove all user rows from `mat` that have strictly less then `min_reviews` reviews.

	% count the reviews that are not zero for each user (on rows)
	nr_reviews = sum(mat ~= 0, 2);

	% mark users with enough reviews as valid
	valid_users = nr_reviews >= min_reviews;

	% create a new matrix with only the valid users
	reduced_mat = mat(valid_users, :);
end
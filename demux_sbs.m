function [left, right] = stereo_split_sbs( sbs_url )

sbs = imread(sbs_url);
full_width = size(sbs, 2);
half_width = full_width / 2;

fprintf('=== Demultiplex - Side by Side into Left and Right Matrixes ===\n');
[iw, pc, pw] = progress_bar_init(1, 0, 30);
left = sbs(:, 1 : half_width, :)
right = sbs(:, half_width + 1 : full_width, :);
progress_bar(1, iw, pc, pw);

function [ views ] = fmt_demux8tile( imgurl )
% Input: Auto-stereoscopic 8-View Tile Format Image
% Output: A views consisting of matrixes of views 1 to 8

% Load image and extract parameters
full_img = imread(imgurl);
full_width = size(full_img, 2);
full_height = size(full_img, 1);
full_depth = size(full_img, 3);

% Initiate sub-view parameters
sub_width  = full_width / 3;
sub_height = full_height * 3 / 8;
t7_height  = full_height * 1 / 8;
b7_height  = full_height * 2 / 8;
t8_height  = full_height * 2 / 8;
b8_height  = full_height * 1 / 8;

views = {};

fprintf('=== Demultiplex - 8 Tile into Cell of Views ===\n');
[iw, pc, pw] = progress_bar_init(1, 0, 30);
% Crop the full image into sub-views, allocate into views
views{1} = full_img([1:sub_height], [1:sub_width], [1:full_depth]);
views{2} = full_img([1:sub_height], [sub_width + 1:sub_width*2], [1:full_depth]);
views{3} = full_img([1:sub_height], [2*sub_width + 1:full_width], [1:full_depth]);
views{4} = full_img([sub_height + 1:2*sub_height], [1:sub_width], [1:full_depth]);
views{5} = full_img([sub_height + 1:2*sub_height], [sub_width + 1:sub_width*2], [1:full_depth]);
views{6} = full_img([sub_height + 1:2*sub_height], [2*sub_width + 1:full_width], [1:full_depth]);
views{7}(1:t7_height,1:sub_width, [1:full_depth]) = full_img([2*sub_height + 1 : 2*sub_height + t7_height], [sub_width + 1 : sub_width * 2], [1:full_depth]);
views{7}(t7_height + 1:sub_height,1:sub_width, [1:full_depth]) = full_img([2*sub_height + 1 : full_height], [1 : sub_width], [1:full_depth]);
views{8}(1:t8_height,1:sub_width, [1:full_depth]) = full_img([2*sub_height + 1 : full_height], [2*sub_width + 1 : full_width], [1:full_depth]);
views{8}(t8_height + 1:sub_height,1:sub_width, [1:full_depth]) = full_img([2*sub_height + b8_height + 1 : full_height], [sub_width + 1 : 2*sub_width], [1:full_depth]);
progress_bar(1, iw, pc, pw);

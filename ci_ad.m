function [cost_left, cost_right] = ci_ad(img_l, img_r, ndisp, zerodisp)

[rows, cols, dims] = size(img_l);

cost_r = zeros(rows, cols, ndisp, 'double');
cost_g = zeros(rows, cols, ndisp, 'double');
cost_b = zeros(rows, cols, ndisp, 'double');
cost_r(:,:,:) = 256.0; 
cost_g(:,:,:) = 256.0; 
cost_b(:,:,:) = 256.0;

%% Compute Left Disparity Map
fprintf('=== Absolute Difference Cost Evaluation ===\n');

fprintf('LEFT DISPARITY ');
% NEGATIVE PARALLAX
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = zerodisp : -1 : 1
    maxl = cols - (zerodisp - disp);
    minr = zerodisp - disp + 1;
    cost_r(:, minr : cols, disp) = imabsdiff( img_l( :, minr : cols, 1), img_r( :, 1 : maxl, 1) );
    cost_g(:, minr : cols, disp) = imabsdiff( img_l( :, minr : cols, 2), img_r( :, 1 : maxl, 2) );
    cost_b(:, minr : cols, disp) = imabsdiff( img_l( :, minr : cols, 3), img_r( :, 1 : maxl, 3) );
    %%%
    progress_bar(zerodisp - disp, iw, pc, pw);
end

% POSITIVE PARALLAX
for disp = zerodisp : 1 : ndisp
    maxl = cols - (disp - zerodisp);
    minr = disp - zerodisp + 1;
    cost_r(:, 1 : maxl, disp) = imabsdiff( img_l( :, 1 : maxl, 1), img_r( :, minr : cols, 1) );
    cost_g(:, 1 : maxl, disp) = imabsdiff( img_l( :, 1 : maxl, 2), img_r( :, minr : cols, 2) );
    cost_b(:, 1 : maxl, disp) = imabsdiff( img_l( :, 1 : maxl, 3), img_r( :, minr : cols, 3) );
    %%%
    progress_bar(disp, iw, pc, pw);
end


cost_left = (cost_r + cost_g + cost_b) / 3.0;

%% Compute Right Disparity Map
cost_r(:,:,:) = 256.0; 
cost_g(:,:,:) = 256.0; 
cost_b(:,:,:) = 256.0;

fprintf('RIGHT DISPARITY ');
% NEGATIVE PARALLAX
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = zerodisp : -1 : 1
    maxl = cols - (zerodisp - disp);
    minr = zerodisp - disp + 1;
    cost_r(:, 1 : maxl, disp) = imabsdiff( img_l( :, minr : cols, 1), img_r( :, 1 : maxl, 1) );
    cost_g(:, 1 : maxl, disp) = imabsdiff( img_l( :, minr : cols, 2), img_r( :, 1 : maxl, 2) );
    cost_b(:, 1 : maxl, disp) = imabsdiff( img_l( :, minr : cols, 3), img_r( :, 1 : maxl, 3) );
    %%%
    progress_bar(zerodisp - disp, iw, pc, pw);
end

% POSITIVE PARALLAX
for disp = zerodisp : 1 : ndisp
    maxl = cols - (disp - zerodisp);
    minr = disp - zerodisp + 1;
    cost_r(:, minr : cols, disp) = imabsdiff( img_l( :, 1 : maxl, 1), img_r( :, minr : cols, 1) );
    cost_g(:, minr : cols, disp) = imabsdiff( img_l( :, 1 : maxl, 2), img_r( :, minr : cols, 2) );
    cost_b(:, minr : cols, disp) = imabsdiff( img_l( :, 1 : maxl, 3), img_r( :, minr : cols, 3) );
    %%%
    progress_bar(disp, iw, pc, pw);
end


cost_right = (cost_r + cost_g + cost_b) / 3.0;

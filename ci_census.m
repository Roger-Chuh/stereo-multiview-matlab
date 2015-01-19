function [cost_l, cost_r] = ci_census(img_l, img_r, ndisp, zerodisp)

fprintf('=== L&R Census Transforms ===\n');

[rows, cols, dims] = size(img_l);

% Census Transforms of L and R
fprintf('LEFT ');
census_l = census_transform_7x9(img_l);
fprintf('RIGHT ');
census_r = census_transform_7x9(img_r);

cost_l = zeros(rows, cols, ndisp, 'double');
cost_r = zeros(rows, cols, ndisp, 'double');
cost_l(:,:,:) = 64.0; 

fprintf('=== Census Cost Evaluation ===\n');

%% Left Cost Evaluation
fprintf('LEFT ');
% NEGATIVE PARALLAX
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = zerodisp : -1 : 1
    maxl = cols - (zerodisp - disp);
    minr = zerodisp - disp + 1;
    dsum = zeros(rows, cols, 'uint8');
    for d = 1 : dims
        dsum(:, minr : cols) = dsum(:, minr : cols) + uint8(disthammingu64( census_l( :, minr : cols, d), census_r( :, 1 : maxl, d)));
    end
    cost_l(:, minr : cols, disp) = double(dsum(:, minr : cols)) / 3.0;
    %%%
    progress_bar(zerodisp - disp, iw, pc, pw);
end

% POSITIVE PARALLAX
for disp = zerodisp : 1 : ndisp
    maxl = cols - (disp - zerodisp);
    minr = disp - zerodisp + 1;
    dsum = zeros(rows, cols, 'uint8');
    for d = 1 : dims
        dsum(:, 1 : maxl) = dsum(:, 1 : maxl) + uint8(disthammingu64( census_l( :, 1 : maxl, d), census_r( :, minr : cols, d)));
    end
    cost_l(:, 1 : maxl, disp) = double(dsum(:, 1 : maxl)) / 3.0;
    %%%
    progress_bar(disp, iw, pc, pw);
end


%% Right Cost Evaluation

cost_r(:,:,:) = 64.0; 

fprintf('RIGHT ');
% NEGATIVE PARALLAX
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = zerodisp : -1 : 1
    maxl = cols - (zerodisp - disp);
    minr = zerodisp - disp + 1;
    dsum = zeros(rows, cols, 'uint8');
    for d = 1 : dims
        dsum(:, 1 : maxl) = dsum(:, 1 : maxl) + uint8(disthammingu64( census_l( :, minr : cols, d), census_r( :, 1 : maxl, d)));
    end
    cost_r(:, 1 : maxl, disp) = double(dsum(:, 1 : maxl)) / 3.0;
    %%%
    progress_bar(zerodisp - disp, iw, pc, pw);
end

% POSITIVE PARALLAX
for disp = zerodisp : 1 : ndisp
    maxl = cols - (disp - zerodisp);
    minr = disp - zerodisp + 1;
    dsum = zeros(rows, cols, 'uint8');
    for d = 1 : dims
        dsum(:, minr : cols) = dsum(:, minr : cols) + uint8(disthammingu64( census_l( :, 1 : maxl, d), census_r( :, minr : cols, d)));
    end
    cost_r(:, minr : cols, disp) = double(dsum(:, minr : cols)) / 3.0;
    %%%
    progress_bar(disp, iw, pc, pw);
end

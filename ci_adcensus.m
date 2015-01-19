function [cost_l, cost_r] = ci_adcensus(img_l, img_r, ndisp, zerodisp, gamma_ad, gamma_census)

[rows, cols, dims] = size(img_l);

fprintf('=====================================\n');
fprintf('=== COST INITIALIZATION: ADCENSUS ===\n');
fprintf('=====================================\n');

[cost_ad_l, cost_ad_r] = ci_ad(img_l, img_r, ndisp, zerodisp);
[cost_census_l, cost_census_r] = ci_census(img_l, img_r, ndisp, zerodisp);
cost_l = zeros(rows, cols, ndisp, 'double');
cost_r = zeros(rows, cols, ndisp, 'double');

fprintf('=== AD + CENSUS Function ===\n');
fprintf('LEFT ');
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = 1 : ndisp
    comp_ad = 1 - exp(-cost_ad_l(:, :, disp)/gamma_ad);
    comp_census = 1 - exp(-cost_census_l(:, :, disp)/gamma_census);
    cost_l(:, :, disp) = comp_ad + comp_census;
    
    % Display Progress
    progress_bar(disp, iw, pc, pw);
end

fprintf('RIGHT ');
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = 1 : ndisp
    comp_ad = 1 - exp(-cost_ad_r(:, :, disp)/gamma_ad);
    comp_census = 1 - exp(-cost_census_r(:, :, disp)/gamma_census);
    cost_r(:, :, disp) = comp_ad + comp_census;
    
    % Display Progress
    progress_bar(disp, iw, pc, pw);
end

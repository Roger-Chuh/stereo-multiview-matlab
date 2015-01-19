function [ out, views, disp_l, disp_r, acost_l, acost_r, cost_l, cost_r ] = sys_stm(img_l, img_r, out_width, out_height, angle, nviews, ndisp, zerodisp, gamma_ad, gamma_census, ucd, lcd, usd, lsd)

% Stereo to Multiview Program
% Disparity Program based on ADCensus

%% Pre-processing Routine

%% Rectification Routine


%% Disparity Routine
% 1. Cost Initialization
[cost_l, cost_r] = ci_adcensus(img_l, img_r, ndisp, zerodisp, gamma_ad, gamma_census);
% 2. Cost Aggragation
acost_l = ca_cross(cost_l, img_l, ucd, lcd, usd, lsd);
acost_r = ca_cross(cost_r, img_r, ucd, lcd, usd, lsd);
% 3. Disparity Computation
disp_l = dc_wta(acost_l, zerodisp);
disp_r = dc_wta(acost_r, zerodisp);
% 4. Disparity Refinement

%% DIBR Routine
views = {};
views{nviews} = img_l;
views{1} = img_r;
shift_dist = 1.0 / (nviews - 1); 
for v = nviews - 1 : -1 : 2
    views{v} = dibr_basic(img_l, img_r, disp_l, disp_r, zerodisp, (nviews - v) * shift_dist);
end

%% Multiplex Routine
out = mux_mv(views, nviews, angle, out_width, out_height);
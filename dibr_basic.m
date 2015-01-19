function [new_view] = dibr_basic(img_l, img_r, disp_l, disp_r, zerodisp, shift)

fprintf('===================\n');
fprintf('=== DIBR: BASIC ===\n');
fprintf('===================\n');

[fmap_l, holes_l] = w2d_fmap(img_l, disp_l, shift);
[fmap_r, holes_r] = w2d_fmap(img_r, disp_r, -(1.0 - shift));

holes_m = holes_l & holes_r;

% Fill Holes
fmap_r = fmap_r .* holes_l;
new_view = fmap_l + fmap_r;


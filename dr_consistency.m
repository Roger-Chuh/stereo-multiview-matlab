function consist_map = dr_consistency(disp_l, disp_r, thresh)

[rows, cols] = size(disp_l);

fprintf('=== Disparity Refinement - Consistency Kernel ===\n');
consist_map = zeros(rows, cols, 'double');
fprintf('CONSISTENCY CHECK ');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        dl = disp_l(y, x);
        d_delta = 0;
        if x + dl > 0 && x + dl < cols
            dr = disp_r(y, x + dl);
            d_delta = abs(dr - dl);
        end
        if d_delta == 0
            consist_map(y, x) = 1;
        elseif d_delta > thresh
            consist_map(y, x) = 0;
        else
            consist_map(y, x) = 1 / double(d_delta);
        end
    end
    progress_bar(y, iw, pc, pw);
end

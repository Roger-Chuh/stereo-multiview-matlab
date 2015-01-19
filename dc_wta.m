function [disp_map] = dc_wta(cost, zerodisp)

fprintf('=== Disparity Computation - Winner Takes All ===\n');

[rows, cols, ndisp] = size(cost);

disp_map = zeros(rows, cols, 'int16');
max_cost = max(max(max(cost)));
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        lowest_cost = max_cost;
        lc_disp = 1;
        for disp = 1 : ndisp
            if cost(y, x, disp) < lowest_cost
                lowest_cost = cost(y, x, disp);
                lc_disp = disp;
            end
        end
        disp_map(y, x) = lc_disp - zerodisp;
    end
    progress_bar(y, iw, pc, pw);
end

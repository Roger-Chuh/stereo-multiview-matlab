function [outliers_l, outliers_r] = dr_outliers(disp_l, disp_r)

[rows, cols] = size(disp_l);

fprintf('=== Disparity Refinement - Search Outliers ===\n');
outliers_l = zeros(rows, cols, 'uint8');
fprintf('LEFT -> RIGHT ');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        disp = disp_l(y, x);
        disp_delta = 0;
        if x - disp > 0
            disp_delta = abs(disp_r(y, x - disp) - disp);
        end
        outliers_l(y, x) = disp_delta;
    end
    progress_bar(y, iw, pc, pw);
end

outliers_r = zeros(rows, cols, 'uint8');
fprintf('RIGHT -> LEFT ');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        disp = disp_r(y, x);
        disp_delta = 0;
        if x + disp <= cols
            disp_delta = abs(disp_l(y, x + disp) - disp);
        end
        outliers_r(y, x) = disp_delta;
    end
    progress_bar(y, iw, pc, pw);
end
function [new_view, holes] = dibr_fmap(img, disp, shift)

fprintf('=== 2D WARP - Forward Mapping ===\n');

[rows, cols, dims] = size(img);

new_view = zeros(rows, cols, dims, 'uint8');
holes = ones(rows, cols, dims, 'uint8');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        d = disp(y, x);
        mdisp = d * shift;
        target = round(int16(x) + mdisp);
        if target <= cols & target > 0
            new_view(y, target, :) = img(y, x, :);
            holes(y, target, :) = 0;
        end
    end
    progress_bar(y, iw, pc, pw);
end
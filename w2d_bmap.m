function [new_view] = dibr_bmap(img_l, img_r, disp_l, disp_r, shift)

[rows, cols, dims] = size(img_l);

new_view = zeros(rows, cols, dims, 'uint8');

for y = 1 : rows
    for x = 1 : cols
        disp = disp_r(y, x);
        mdisp = disp * shift;
        target = uint16(x) + uint16(mdisp);
        if target <= cols & target > 0
            new_view(y, x, :) = img_l(y, target, :);
        end
    end
end
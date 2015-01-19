function [census_map] = census_transform_7x9(img)

winsz_h = 7;
winsz_w = 9;

winsz = [winsz_h, winsz_w];
winsz2 = [(winsz_h - 1) / 2, (winsz_w - 1) / 2];

[rows, cols, dims] = size(img);

bits = uint64(0);

census_map = uint64(zeros(rows, cols, dims));

% Progress HUD
[iw, pc, pw] = progress_bar_init(dims * rows, 0, 30);
for d = 1 : dims
    for y = winsz2(1) + 1 : rows - winsz2(1)
        for x = winsz2(2) + 1 : cols - winsz2(2)
            census = 0;
            for y1 = -winsz2(1) : winsz2(1)
                for x1 = -winsz2(2) : winsz2(2)
                    if ~(y1 == 0 && x1 == 0)
                        census = bitshift(census,1);
                        if (img(y + y1, x + x1, d) < img(y, x, d))
                            census = census + 1;
                        end
                    end
                end
            end
            census_map(y, x, d) = census;
        end
        progress_bar((d - 1) * rows + y, iw, pc, pw);
    end
end

function [cost] = ca_cross_vh(initial_cost, cross_map)

[rows, cols, ndisp] = size(initial_cost);

fprintf('--- Vertical First ---\n');

%% First pass - Vertical Aggragation
fprintf('PASS 1 ');
v_cost = zeros(rows, cols, ndisp, 'double');
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = 1 : ndisp
    for y = 1 : rows
        for x = 1 : cols
            asum = 0;
            t_arm = cross_map(y, x, 1);
            b_arm = cross_map(y, x, 2);
            for ay = y - t_arm : y + b_arm
                asum = asum + initial_cost(ay, x, disp);
            end
            v_cost(y, x, disp) = asum;
        end
    end
    progress_bar(disp, iw, pc, pw);
end

%% Second pass - Horizontal Aggragation
fprintf('PASS 2 ');
cost = zeros(rows, cols, ndisp, 'double');
[iw, pc, pw] = progress_bar_init(ndisp, 0, 30);
for disp = 1 : ndisp
    for y = 1 : rows
        for x = 1 : cols
            asum = 0;
            l_arm = cross_map(y, x, 3);
            r_arm = cross_map(y, x, 4);
            for ax = x - l_arm : x + r_arm
                asum = asum + v_cost(y, ax, disp);
            end
            cost(y, x, disp) = asum;
        end
    end
    progress_bar(disp, iw, pc, pw);
end

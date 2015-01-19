function [so_cost_l, so_cost_r] = dc_so(cost_l, cost_r, img_l, img_r, C1, C2, thresh)

[rows, cols, ndisp] = size(cost_l);

% Quad-Directional Scanline Optimisation of Cost Map

C1_4 = C1 / 4.0;
C2_4 = C2 / 4.0;
C1_10 = C1 / 10.0;
C2_10 = C2 / 10.0;

% Right Direction
% Left Cost Map
pcost_l_r = zeros(rows, cols, ndisp);

fprintf('--- Scanline Optimization ---\n');
fprintf('(LEFT MAP, RIGHT DIRECTION) ');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        for disp = 1 : ndisp
            % Compute Component 1
            comp_1 = cost_l(y, x, disp);
            comp_2 = 0;
            comp_3 = 0;
            if (x - 1) > 0
                % Compute D1 & D2
                D1 = double(sum(abs(img_l(y, x, :) - img_l(y, x-1, :)))) / 3.0;
                D2 = 0;
                P1 = 0;
                P2 = 0;
                if (x + disp) <= cols
                    D2 = double(sum(abs(img_r(y, x+disp, :) - img_r(y, x-1+disp, :)))) / 3.0;
                end
                % Compute P1 & P2
                if D1 < thresh & D2 < thresh
                    P1 = C1;
                    P2 = C2;
                elseif D1 < thresh & D2 > thresh
                    P1 = C1_4;
                    P2 = C2_4;
                elseif D1 > thresh & D2 < thresh
                    P1 = C1_4;
                    P2 = C2_4;
                else
                    P1 = C1_10;
                    P2 = C2_10;
                end
                
                % Compute Component 2
                comp_2a = pcost_l_r(y, x-1, disp);
                comp_2b = comp_2a;
                comp_2c = comp_2a;
                if (disp - 1 > 0)
                    comp_2b = pcost_l_r(y, x-1, disp-1);
                end
                if (disp + 1 <= ndisp)
                    comp_2c = pcost_l_r(y, x-1, disp+1);
                end
                comp_3 = min(pcost_l_r(y, x-1, :));
                comp_2d = comp_3 + P2;
                comp_2 = min([comp_2a, comp_2b, comp_2c, comp_2d]);
                
                % Component 3 Already computed 4 lines above
            end
            pcost_l_r(y, x, disp) = comp_1 + comp_2 - comp_3;
        end
    end
    progress_bar(y, iw, pc, pw);
end

so_cost_l = pcost_l_r;


% Left Direction

% Up Direction

% Down Direction
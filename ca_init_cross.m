function [cross_map] = ca_init_cross(img, ucd, lcd, usd, lsd)

[rows, cols, dims] = size(img);



% Cross Construction, each dimension holds a value of # of arm length
% extruding from anchor pixel
% 1 - Pixels Up
% 2 - Pixels Down
% 3 - Pixels Left
% 4 - Pixels RIght

% PARAMETERS
% img - Image of View in Evaluation
% ucd - Upper Limit Color Delta
% lcd - Lower Limit Color Delta
% usd - Upper Limit Spatial Delta
% lcd - Lower Limit Spatial Delta

cross_map = zeros(rows, cols, 4);

fprintf('--- Aggragation Cross Map Construction: --- \n');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
        % Get anchor data
        p_color = img(y, x, :);
        
        % Top Arm
        for y_arm = 1 : usd
            if (y - y_arm) < 1
                break;
            end
            cross_map(y, x, 1) = y_arm;
            p1_color = img(y - y_arm, x, :);
            pp_color = img(y - y_arm + 1, x, :);
            p1_mad = max(abs(p1_color - p_color));
            pp_mad = max(abs(p1_color - pp_color));
            if y_arm > lsd
                if p1_mad > lcd
                    break;
                end
            else
                if p1_mad > ucd
                    break;
                end
                if pp_mad > ucd
                    break;
                end
            end
        end
        
        % Bottom Arm
        for y_arm = 1 : usd
            if (y + y_arm) > rows
                break;
            end
            cross_map(y, x, 2) = y_arm;
            p1_color = img(y + y_arm, x, :);
            pp_color = img(y + y_arm - 1, x, :);
            p1_mad = max(abs(p1_color - p_color));
            pp_mad = max(abs(p1_color - pp_color));
            if y_arm > lsd
                if p1_mad > lcd
                    break;
                end
            else
                if p1_mad > ucd
                    break;
                end
                if pp_mad > ucd
                    break;
                end
            end
        end
        
        % Left Arm
        for x_arm = 1 : usd
            if (x - x_arm) < 1
                break;
            end
            cross_map(y, x, 3) = x_arm;
            p1_color = img(y, x - x_arm, :);
            pp_color = img(y, x - x_arm + 1, :);
            p1_mad = max(abs(p1_color - p_color));
            pp_mad = max(abs(p1_color - pp_color));
            if x_arm > lsd
                if p1_mad > lcd
                    break;
                end
            else
                if p1_mad > ucd
                    break;
                end
                if pp_mad > ucd
                    break;
                end
            end
        end
        
        % Right Arm
        for x_arm = 1 : usd
            if (x + x_arm) > cols
                break;
            end
            cross_map(y, x, 4) = x_arm;
            p1_color = img(y, x + x_arm, :);
            pp_color = img(y, x + x_arm - 1, :);
            p1_mad = max(abs(p1_color - p_color));
            pp_mad = max(abs(p1_color - pp_color));
            if x_arm > lsd
                if p1_mad > lcd
                    break;
                end
            else
                if p1_mad > ucd
                    break;
                end
                if pp_mad > ucd
                    break;
                end
            end
        end
    end
    progress_bar(y, iw, pc, pw);
end
